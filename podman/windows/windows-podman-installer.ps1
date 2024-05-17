function Print-Note {
    $note = @"
***************************************************************************************************
***************************************************************************************************
* Welcome, brave scripter! This script is your trusty companion for setting up a powerful dev 
* environment with Podman 5.0.3, Podman Desktop 1.10.2, Python 3.9, and Podman Compose 1.0.6.
* Here's what this script does, step by step:
* 
* 1. First, it makes sure you're running as an admin. No shortcuts here!
* 2. Then, it checks if Windows Subsystem for Linux (WSL) is installed. If not, it enables it for you.
* 3. It creates a cozy little directory called 'podman-installers' to keep all the downloads.
* 4. Next, it checks if the Podman installer is already downloaded. If not, it grabs it from the web.
* 5. It installs Podman in a smooth and silent way.
* 6. It repeats the download and install steps for Podman Desktop.
* 7. Now, it's Python's turn! The script checks, downloads, and installs Python for you.
* 8. After installing Python, it updates your environment variables to include Python paths.
* 9. It makes sure pip (Python's package installer) is upgraded to the latest version.
* 10. With pip ready, it installs Podman Compose, so you can manage containers like a pro.
* 11. It refreshes the environment variables to ensure all changes take effect.
* 12. Finally, it checks if a Podman machine exists and is running. If not, it sets one up for you.
* 
* By the end of this journey, you'll have Podman, Podman Desktop, and Python all set up and ready
* to conquer your containerized adventures. Happy scripting!
*
* Note: Script is tested with Windows 10. 
***************************************************************************************************
***************************************************************************************************
"@

    Write-Host -ForegroundColor Cyan $note
}

Print-Note

# Enable running scripts as admin
function Check-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    $adminRole = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $adminRole) {
        Write-Host -ForegroundColor Red "This script must be run as an administrator."
        pause
        exit 1
    }
}

Check-Admin

# Check if WSL is installed and enable it if not
function Check-WSL {
    Write-Host -ForegroundColor Cyan ""
    Write-Host -ForegroundColor Yellow "### Checking if WSL is installed ###"
    wsl --list > $null 2>&1

    if ($LASTEXITCODE -ne 0) {
        Write-Host -ForegroundColor Yellow "WSL not found, enabling WSL..."
        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        wsl --set-default-version 2
        Write-Host -ForegroundColor Green "WSL is enabled now. Please restart your computer and re-run the script."
        exit 0
    } else {
        Write-Host -ForegroundColor Green "WSL is already installed."
    }
}

Check-WSL

# Set the directory where you want to download and install Podman, Podman Desktop, and Python
$DOWNLOAD_DIR = Join-Path -Path $PSScriptRoot -ChildPath "podman-installers"

# Create the podman-installers directory if it does not exist
if (-not (Test-Path -Path $DOWNLOAD_DIR)) {
    Write-Host -ForegroundColor Yellow "### Creating podman-installers directory ###"
    New-Item -Path $DOWNLOAD_DIR -ItemType Directory | Out-Null
}
Set-Location -Path $DOWNLOAD_DIR

# Download Podman MSI Installer if it does not exist (Update the version as necessary)
$podmanInstaller = "podman-5.0.3-setup.exe"
Write-Host -ForegroundColor Yellow "### Checking if need to download Podman Installer ###"
if (-not (Test-Path -Path $podmanInstaller)) {
    Write-Host -ForegroundColor Yellow "### Downloading Podman Installer ###"
    Invoke-WebRequest -Uri 'https://github.com/containers/podman/releases/download/v5.0.3/podman-5.0.3-setup.exe' -OutFile $podmanInstaller
} else {
    Write-Host -ForegroundColor Green "Podman Installer already exists."
}

# Install Podman
Write-Host -ForegroundColor Yellow "### Installing Podman ###"
Start-Process -FilePath $podmanInstaller -ArgumentList "/S /D=$env:USERPROFILE\Podman" -Wait

# Download Podman Desktop Installer if it does not exist (Update the version as necessary)
$podmanDesktopInstaller = "podman-desktop-1.10.2-setup-x64.exe"
Write-Host -ForegroundColor Yellow "### Checking if need to download Podman Desktop Installer ###"
if (-not (Test-Path -Path $podmanDesktopInstaller)) {
    Write-Host -ForegroundColor Yellow "### Downloading Podman Desktop Installer ###"
    Invoke-WebRequest -Uri 'https://github.com/containers/podman-desktop/releases/download/v1.10.2/podman-desktop-1.10.2-setup-x64.exe' -OutFile $podmanDesktopInstaller
} else {
    Write-Host -ForegroundColor Green "Podman Desktop Installer already exists."
}

# Install Podman Desktop
Write-Host -ForegroundColor Yellow "### Installing Podman Desktop ###"
Start-Process -FilePath $podmanDesktopInstaller -ArgumentList "/S /D=$env:USERPROFILE\PodmanDesktop" -Wait

# Download Python MSI Installer if it does not exist
$pythonInstaller = "python-3.9.0-amd64.exe"
Write-Host -ForegroundColor Yellow "### Checking if need to download Python Installer ###"
if (-not (Test-Path -Path $pythonInstaller)) {
    Write-Host -ForegroundColor Yellow "### Downloading Python Installer ###"
    Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.9.0/python-3.9.0-amd64.exe' -OutFile $pythonInstaller
} else {
    Write-Host -ForegroundColor Green "Python Installer already exists."
}

# Install Python
Write-Host -ForegroundColor Yellow "### Installing Python ###"
Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=0 TargetDir=$env:USERPROFILE\Python" -Wait

# Update environment variables for the current session
Write-Host -ForegroundColor Yellow "### Updating environment variables ###"
$env:Path = "$env:USERPROFILE\Python;$env:USERPROFILE\Python\Scripts;$env:Path;$env:APPDATA\Python\Python39\Scripts"

# Ensure pip is upgraded and use user-wide pip installation
Write-Host -ForegroundColor Yellow "### Ensuring pip is upgraded ###"
& "$env:USERPROFILE\Python\python.exe" -m ensurepip --upgrade

# Upgrade pip to the latest version
Write-Host -ForegroundColor Yellow "### Upgrading pip to the latest version ###"
& "$env:USERPROFILE\Python\python.exe" -m pip install --upgrade pip

# Install Podman Compose using pip
Write-Host -ForegroundColor Yellow "### Installing Podman Compose ###"
& "$env:USERPROFILE\Python\python.exe" -m pip install --user podman-compose

# Refresh environment variables for the current session
Write-Host -ForegroundColor Yellow "### Refreshing environment variables for the current session ###"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
[System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Process)

# Add 'C:\Program Files\Python39\Scripts' to Path if not already present
$pythonScriptsPath = "$env:USERPROFILE\AppData\Roaming\Python\Python39\Scripts"
if (-not $env:Path.Contains($pythonScriptsPath)) {
    Write-Host -ForegroundColor Yellow "### Adding 'C:\Program Files\Python39\Scripts' to the Path ###"
    $env:Path += ";$pythonScriptsPath"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
}

# Check Podman version
Write-Host -ForegroundColor Yellow "### Checking Podman version ###"
& podman --version

# Check Podman Compose version
Write-Host -ForegroundColor Yellow "### Checking Podman Compose version ###"
$podmanComposeVersion = & podman-compose --version 2>&1
$podmanComposeVersion | ForEach-Object { Write-Host -ForegroundColor Green $_ }

# Function to check if Podman machine exists and is running
function Ensure-PodmanMachine {
    Write-Host -ForegroundColor Yellow "### Checking Podman machine status ###"
    $machineStatus = & podman machine ls --format "{{.Name}},{{.Running}}"
    $machineFound = $false
    $machineStatus | ForEach-Object {
        $parts = $_ -split ","
        $name = $parts[0].Trim()
        $running = $parts[1].Trim()
        Write-Host -ForegroundColor Yellow "Machine Name: $name, Running: $running"
        if ($name -eq "podman-machine-default*" -and $running -eq "true") {
            Write-Host -ForegroundColor Green "Podman machine 'podman-machine-default' is already running."
            $machineFound = $true
            return
        }
    }
    if (-not $machineFound) {
        Write-Host -ForegroundColor Yellow "Podman machine 'podman-machine-default' is not running. Initializing and starting..."
        & podman machine init > $null 2>&1
        & podman machine start > $null 2>&1
        Write-Host -ForegroundColor Green "Podman machine 'podman-machine-default' has been initialized and started."
    }
}

# Ensure Podman machine is initialized and started
Ensure-PodmanMachine

Write-Host -ForegroundColor Green "### Script execution completed ###"