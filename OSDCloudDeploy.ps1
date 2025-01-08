# Main Script Start
# -------------------------------------------
Write-Host -ForegroundColor Cyan "Starting the Deployment Process..."

# Trigger Custom OSDCloud Provisioning
Write-Host -ForegroundColor Cyan "Running OSDCloud Provisioning Script..."
Watch-OSDCloudProvisioning {
    Write-Host -ForegroundColor Cyan "Starting SeguraOSD's Custom OSDCloud ..."
    Start-Sleep -Seconds 5

    # Change Display Resolution for Virtual Machine
    if ((Get-MyComputerModel) -match 'Virtual') {
        Write-Host -ForegroundColor Cyan "Setting Display Resolution to 1600x"
        Set-DisRes 1600
    }

    # Update and Import OSD PowerShell Module
    Write-Host -ForegroundColor Cyan "Updating the awesome OSD PowerShell Module"
    Install-Module OSD -Force
    Write-Host -ForegroundColor Cyan "Importing the sweet OSD PowerShell Module"
    Import-Module OSD -Force

    # Placeholder for ISO Ejection
    Write-Host -ForegroundColor Cyan "Ejecting ISO"
    Write-Warning "That didn't work because I haven't coded it yet!"

    # Start OSDCloud Deployment
    Write-Host -ForegroundColor Cyan "Start OSDCloud with MY Parameters"
    Start-OSDCloud -OSLanguage en-us -OSBuild 20H2 -OSEdition Enterprise -ZTI

    # Placeholder for Post-Action
    Write-Host -ForegroundColor Cyan "Starting OSDCloud PostAction ..."
    Write-Warning "I'm not sure of what to put here yet"

    # Restart from WinPE
    Write-Host -ForegroundColor Cyan "Restarting in 20 seconds!"
    Start-Sleep -Seconds 20
    wpeutil reboot
}

# Continue with Winget Installation
Write-Host -ForegroundColor Cyan "OSDCloud provisioning completed. Proceeding with Winget installation..."

# Ensure Winget is Installed
Write-Host -ForegroundColor Cyan "Checking if Winget is installed..."
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host -ForegroundColor Cyan "Winget not found. Installing Winget..."
    osdcloud-StartOOBE -InstallWinGet -WinGetUpgrade -WinGetPwsh -SkipOSD
}

# Install Applications using Winget
Write-Host -ForegroundColor Cyan "Installing Applications via Winget..."
Start-Sleep -Seconds 3

# Example Application Installations
Write-Host -ForegroundColor Cyan "Installing Microsoft Office..."
winget install -e --id Microsoft.Office --accept-package-agreements --accept-source-agreements

Write-Host -ForegroundColor Cyan "Installing Google Chrome..."
winget install -e --id Google.Chrome --accept-package-agreements --accept-source-agreements

Write-Host -ForegroundColor Cyan "Installing Zoom..."
winget install -e --id Zoom.Zoom --accept-package-agreements --accept-source-agreements

Write-Host -ForegroundColor Cyan "Application installation complete. Deployment process finished!"

# End of Script
# -------------------------------------------
