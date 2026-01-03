# PowerShell automation for BullBearEye (TradeXray)
# This script sets up the environment, installs modules, runs analysis, tests, and linting.

param(
    [string]$InputFile = "data.csv"
)

Write-Information "[BullBearEye] Starting automation..."

# 1. Check PowerShell version
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Error "PowerShell 7+ is required. Current version: $($PSVersionTable.PSVersion)"
    exit 1
}

# 2. Install required modules if missing
$modules = @('Pester', 'PSScriptAnalyzer')
foreach ($mod in $modules) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Write-Information "Installing module: $mod"
        try {
            Install-Module -Name $mod -Scope CurrentUser -Force -ErrorAction Stop
        } catch {
            Write-Error "Failed to install $mod. Try running as Administrator."
            exit 1
        }
    } else {
        Write-Information "$mod already installed."
    }
}

# 3. Run analysis script
$analysisScript = "./scripts/Run-Analysis.ps1"
if (Test-Path $analysisScript) {
    Write-Information "Running analysis script..."
    try {
        pwsh $analysisScript -Input $InputFile
    } catch {
        Write-Error "Analysis script failed."
    }
} else {
    Write-Warning "Analysis script not found at $analysisScript."
}

# 4. Run tests
if (Test-Path "./tests") {
    Write-Information "Running Pester tests..."
    try {
        Invoke-Pester -Path ./tests -EnableExit
    } catch {
        Write-Error "Tests failed."
    }
} else {
    Write-Warning "No tests directory found."
}

# 5. Linting
Write-Information "Running PSScriptAnalyzer..."
try {
    Invoke-ScriptAnalyzer -Path . -Recurse
} catch {
    Write-Error "Linting failed."
}

Write-Information "[BullBearEye] Automation complete!"
