################################
##                            ##
## vSphere powershell prereqs ##
##                            ##
################################
param(
    [switch]$Update = $false
)

try {
    # Set TLS v1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    # Enable console prompting
    if (!(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds").ConsolePrompting) {
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds" ConsolePrompting True | Out-Null
    }
}
catch {
    Write-Output "STEP1: something failed"
}

try {
    # Set PSGallery to trusted repo
    if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne "Trusted") {
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    }
    
}
catch {
    Write-Output "PSGallerySTEP: something failed"
}

# Modules to install
$modules = @(
    "VMware.PowerCLI"
    "VMware.Community.VCSA.Update"
)

# UPDATE
if ($Update) { # DO THIS IF UPDATE SWITCH = TRUE
    try {
        foreach ($module in $modules) {
                Write-Host "Updating '$module'..." -ForegroundColor Yellow -BackgroundColor Black
                Install-Module -Name $module -Force -SkipPublisherCheck
            }      
    }
    catch {
        Write-Host "Updating '$module' failed..." -ForegroundColor Red -BackgroundColor Black
    }
} else { # DO THIS IF UPDATE SWITCH = FALSE (DEFAULT)
    try {
        foreach ($module in $modules) {
            if (!(Get-Module -ListAvailable -Name $module)) {
                Write-Host "Installing $module..."
                Install-Module -Name $module -SkipPublisherCheck
            } else { Write-Host "$module already installed." -ForegroundColor Green -BackgroundColor Black }
        }
    }
    catch {
        Write-Host "Install failed for $module" -ForegroundColor Red -BackgroundColor Black
    }
}

# Ignore certificate warnings, don't participate in CEIP
try {
    if (Get-Module -ListAvailable -Name VMware.PowerCLI) {
        Set-PowerCLIConfiguration -InvalidCertificateAction ignore -ParticipateInCeip $false -confirm:$false | Out-Null
    }
}
catch {
    Write-Output "POWERCLI-CONFIG: Is the module installed?"
}
