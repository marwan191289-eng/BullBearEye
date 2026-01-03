# =====================================================================
# Setup-Maven-GitHub.ps1
#
# Automates Maven GitHub Packages authentication setup for Windows/CI/CD
#
# USAGE (CI/CD or local automation):
#   Set the following environment variables before running:
#     GITHUB_USERNAME      - Your GitHub username
#     GITHUB_REPOSITORY    - The repository in OWNER/REPOSITORY format
#     GITHUB_TOKEN         - A GitHub Personal Access Token (with read:packages)
#
#   Example (PowerShell):
#     $env:GITHUB_USERNAME = "your-username"
#     $env:GITHUB_REPOSITORY = "owner/repo"
#     $env:GITHUB_TOKEN = "ghp_..."
#     powershell -ExecutionPolicy Bypass -File .\Setup-Maven-GitHub.ps1
#
# The script will fail with a clear error if any variable is missing.
# =====================================================================
# Setup-Maven-GitHub.ps1
# Automates Maven GitHub Packages authentication setup for Windows

$ErrorActionPreference = 'Stop'



# Fully non-interactive: require env vars, fail if missing
$githubUser = $env:GITHUB_USERNAME
$githubRepo = $env:GITHUB_REPOSITORY
$githubToken = $env:GITHUB_TOKEN

if ([string]::IsNullOrWhiteSpace($githubUser)) {
  Write-Error 'GITHUB_USERNAME environment variable is required. Set it before running this script.'
  exit 1
}
if ([string]::IsNullOrWhiteSpace($githubRepo)) {
  Write-Error 'GITHUB_REPOSITORY environment variable is required. Set it before running this script.'
  exit 1
}
if ([string]::IsNullOrWhiteSpace($githubToken)) {
  Write-Error 'GITHUB_TOKEN environment variable is required. Set it before running this script.'
  exit 1
}

# Prepare .m2 directory
$m2Dir = Join-Path $env:USERPROFILE '.m2'
if (-not (Test-Path $m2Dir)) {
    New-Item -ItemType Directory -Path $m2Dir | Out-Null
}

# Generate settings.xml content
$settingsXml = @"
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <activeProfiles>
    <activeProfile>github</activeProfile>
  </activeProfiles>

  <profiles>
    <profile>
      <id>github</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>https://repo.maven.apache.org/maven2</url>
        </repository>
        <repository>
          <id>github</id>
          <url>https://maven.pkg.github.com/$githubRepo</url>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>

  <servers>
    <server>
      <id>github</id>
      <username>$githubUser</username>
      <password>$githubToken</password>
    </server>
  </servers>
</settings>
"@

# Write settings.xml
$settingsPath = Join-Path $m2Dir 'settings.xml'
$settingsXml | Set-Content -Path $settingsPath -Encoding UTF8

Write-Output "Maven settings.xml configured for GitHub Packages at $settingsPath"
Write-Output "You can now use Maven with GitHub Packages."
Write-Output "Authenticating against repository 'github' with username '$githubUser'"

# Check if 'mvn' command is available
if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
  Write-Error "'mvn' command not found. Ensure Maven is installed and added to your PATH."
  exit 1
}

# Ensure Maven binary directory is in PATH
$mavenBinDir = Join-Path (Get-Command mvn).Source '..\bin'
if (-not ($env:PATH -split ';' | Where-Object { $_ -eq $mavenBinDir })) {
  Write-Output "Adding Maven binary directory to PATH: $mavenBinDir"
  $env:PATH += ";$mavenBinDir"
}

# Verify Maven commands are accessible
$mvnCommands = @('mvn', 'mvn.cmd', 'mvnDebug', 'mvnDebug.cmd', 'm2.conf', 'mvnyjp')
foreach ($cmd in $mvnCommands) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    Write-Error "Expected Maven command '$cmd' not found in PATH."
    exit 1
  }
}
