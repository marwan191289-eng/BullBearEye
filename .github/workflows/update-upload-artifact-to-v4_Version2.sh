 #!/usr/bin/env bash
# Fully-automated upgrade: actions/upload-artifact@v3 -> @v4
# - Creates branch
# - Replaces occurrences in files
# - Commits & pushes
# - Creates a PR (gh CLI if available, else GitHub API using GITHUB_TOKEN)
set -euo pipefail

REPLACE_FROM='actions/upload-artifact@v3'
REPLACE_TO='actions/upload-artifact@v4'
BRANCH_PREFIX='chore/bump-upload-artifact-v4'
COMMIT_MSG='chore(ci): bump actions/upload-artifact to v4'
PR_TITLE='chore(ci): bump actions/upload-artifact to v4'
PR_BODY="Automated change: replace ${REPLACE_FROM} with ${REPLACE_TO} in workflow files."

# Ensure we are in a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: this script must be run from inside a git repository."
  exit 1
fi

# Get files that contain the string (include untracked by using grep over filesystem)
mapfile -t files < <(grep -R --line-number --binary-files=without-match -F "${REPLACE_FROM}" . | cut -d: -f1 | sort -u || true)

if [ ${#files[@]} -eq 0 ]; then
  echo "No occurrences of '${REPLACE_FROM}' found. Nothing to do."
  exit 0
fi

echo "Found ${#files[@]} file(s) to update:"
for f in "${files[@]}"; do
  echo "  - $f"
done

# Create branch
timestamp=$(date -u +"%Y%m%d-%H%M%SZ")
branch="${BRANCH_PREFIX}-${timestamp}"
git checkout -b "${branch}"

# Replace safely using perl (portable across macOS/linux). Create .bak for safety.
echo "Replacing occurrences..."
for f in "${files[@]}"; do
  # skip binary files
  if file --brief --mime-type "$f" | grep -qv text; then
    echo "Skipping non-text file: $f"
    continue
  fi
  perl -0777 -pe "s/\Q${REPLACE_FROM}\E/${REPLACE_TO}/g" "$f" > "${f}.tmp" && mv "${f}.tmp" "$f"
done

# Show git status of changes
echo "Changes staged for commit (git diff --name-only):"
git add -A
git --no-pager diff --staged --name-only || true

# If no staged changes (should not happen) exit
if [ -z "$(git diff --staged --name-only)" ]; then
  echo "No changes to commit after replacement. Exiting."
  git checkout -  # go back
  exit 0
fi

git commit -m "${COMMIT_MSG}"

# Push branch
echo "Pushing branch ${branch} to origin..."
git push -u origin "${branch}"

# Determine repo owner/name from remote
remote_url=$(git remote get-url origin)
if [[ "$remote_url" =~ ^git@github.com:(.+)/(.+)(\.git)?$ ]]; then
  owner_repo="${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
elif [[ "$remote_url" =~ ^https://github.com/(.+)/(.+)(\.git)?$ ]]; then
  owner_repo="${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
else
  # fallback: try to parse generically
  owner_repo=$(echo "$remote_url" | sed -E 's|.*[:/]{1}([^/]+/[^/]+)(\.git)?$|\1|')
fi

echo "Repository detected: ${owner_repo}"

# Create PR
if command -v gh >/dev/null 2>&1; then
  echo "Creating PR with gh CLI..."
  # Use --fill to auto-populate body if possible; fallback to given title/body
  if gh pr create --title "${PR_TITLE}" --body "${PR_BODY}" --head "${branch}" --base main >/dev/null 2>&1; then
    echo "Pull request created via gh CLI."
  else
    # try without suppressing output to show errors
    gh pr create --title "${PR_TITLE}" --body "${PR_BODY}" --head "${branch}" --base main || true
  fi
else
  # Use GitHub API via GITHUB_TOKEN
  if [ -z "${GITHUB_TOKEN:-}" ]; then
    echo "Error: gh CLI not found and GITHUB_TOKEN is not set. Cannot create PR automatically."
    echo "You can install GitHub CLI (https://cli.github.com/) or set GITHUB_TOKEN to allow PR creation."
    exit 1
  fi

  api_url="https://api.github.com/repos/${owner_repo}/pulls"
  payload=$(jq -n --arg t "${PR_TITLE}" --arg b "${PR_BODY}" --arg head "${branch}" --arg base "main" \
    '{title:$t, body:$b, head:$head, base:$base}')
  echo "Creating PR via GitHub API..."
  resp=$(curl -sS -o /dev/stderr -w "%{http_code}" -X POST -H "Authorization: token ${GITHUB_TOKEN}" -H "Accept: application/vnd.github+json" \
    "${api_url}" -d "${payload}") || true
  if [ "$resp" -ge 200 ] && [ "$resp" -lt 300 ]; then
    echo "Pull request created via API."
  else
    echo "Failed to create PR via API. HTTP status: $resp"
    exit 1
  fi
fi

echo "Done. Branch: ${branch}"
echo "You may want to review the PR and merge it after CI checks pass."