# Backend + Frontend PowerShell Automation



# Save the original directory
$originalDir = Get-Location

try {
	# Start Backend
	Set-Location backend
	..\.venv\Scripts\python.exe -m pip install -r requirements.txt
	Start-Process powershell -ArgumentList 'uvicorn app.main:app'
	Set-Location $originalDir

	# Start Frontend
	Set-Location frontend
	npm install
	Start-Process powershell -ArgumentList 'npm run dev'
	Set-Location $originalDir

	# Health check for backend
	Write-Host "Waiting for backend to start..."
	$backendReady = $false
	for ($i = 0; $i -lt 20; $i++) {
		try {
			$response = Invoke-WebRequest -Uri "http://localhost:8000" -UseBasicParsing -TimeoutSec 2
			if ($response.StatusCode -eq 200) {
				$backendReady = $true
				break
			}
		} catch {}
		Start-Sleep -Seconds 1
	}
	if ($backendReady) {
		Write-Host "Backend is running at http://localhost:8000"
	} else {
		Write-Warning "Backend did not start in time. Check the backend terminal for errors."
	}

	# Health check for frontend
	Write-Host "Waiting for frontend to start..."
	$frontendReady = $false
	for ($i = 0; $i -lt 30; $i++) {
		try {
			$response = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing -TimeoutSec 2
			if ($response.StatusCode -eq 200) {
				$frontendReady = $true
				break
			}
		} catch {}
		Start-Sleep -Seconds 1
	}
	if ($frontendReady) {
		Write-Host "Frontend is running at http://localhost:3000"
	} else {
		Write-Warning "Frontend did not start in time. Check the frontend terminal for errors."
	}
} catch {
	Write-Error "An error occurred: $_"
	Set-Location $originalDir
}
