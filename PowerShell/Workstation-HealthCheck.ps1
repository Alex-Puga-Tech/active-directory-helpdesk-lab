param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$DomainController = "DC01",
    [string]$DNSServer = "192.168.60.10",
    [string]$DomainName = "adlab.local"
)

Invoke-Command -ComputerName $ComputerName -ScriptBlock {

    # Basic system information
    $ComputerSystem = Get-CimInstance Win32_ComputerSystem
    $OS = Get-CimInstance Win32_OperatingSystem

    $ComputerName = $env:COMPUTERNAME
    $Domain = $ComputerSystem.Domain

    # Uptime
    $Uptime = (Get-Date) - $OS.LastBootUpTime

    # RAM
    $TotalRAM = [math]::Round($OS.TotalVisibleMemorySize / 1MB, 2)
    $FreeRAM = [math]::Round($OS.FreePhysicalMemory / 1MB, 2)
    $UsedRAM = [math]::Round($TotalRAM - $FreeRAM, 2)
    $RAMPercent = [math]::Round(($UsedRAM / $TotalRAM) * 100, 1)

    if ($RAMPercent -ge 90) {
        $RAMStatus = "CRITICAL"
    }
    elseif ($RAMPercent -ge 80) {
        $RAMStatus = "WARNING"
    }
    else {
        $RAMStatus = "OK"
    }

    # Disk
    $Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

    $DiskFreeGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
    $DiskSizeGB = [math]::Round($Disk.Size / 1GB, 2)
    $DiskUsedPercent = [math]::Round((($Disk.Size - $Disk.FreeSpace) / $Disk.Size) * 100, 1)

    if ($DiskUsedPercent -ge 90) {
        $DiskStatus = "CRITICAL"
    }
    elseif ($DiskUsedPercent -ge 80) {
        $DiskStatus = "WARNING"
    }
    else {
        $DiskStatus = "OK"
    }

    # Important services
    $Services = @(
    "Spooler",
    "w32time",
    "Dnscache"
)

    $ServiceStatus = foreach ($Service in $Services) {

    $Result = Get-Service -Name $Service -ErrorAction SilentlyContinue

    if ($Result) {

        if ($Result.Status -eq "Running") {
            "$($Result.Name): Running - OK"
        }
        else {
            "$($Result.Name): $($Result.Status) - WARNING"
        }

    }
    else {
        "${Service}: Not Found - WARNING"
    }
}

    # Network connectivity to domain controller
$DCConnection = Test-Connection -ComputerName $using:DomainController -Count 2 -Quiet

# DNS resolution
try {
    $DNSResult = Resolve-DnsName $using:DomainName -ErrorAction Stop
    $DNSStatus = "OK"
}
catch {
    $DNSStatus = "FAILED"
}

    # Results
    Write-Host ""
    Write-Host "===== REMOTE WORKSTATION HEALTH CHECK ====="
    Write-Host ""

    Write-Host "Computer Name : $ComputerName"
    Write-Host "Domain        : $Domain"
    Write-Host "OS            : $($OS.Caption)"
    Write-Host "Uptime        : $($Uptime.Days) days $($Uptime.Hours) hours $($Uptime.Minutes) minutes"

    Write-Host ""

    Write-Host "RAM           : $UsedRAM GB used / $TotalRAM GB total ($RAMPercent%)"
    Write-Host "RAM Status    : $RAMStatus"

    Write-Host ""

    Write-Host "C: Drive      : $DiskFreeGB GB free / $DiskSizeGB GB total ($DiskUsedPercent% used)"
    Write-Host "Disk Status   : $DiskStatus"

    Write-Host ""

    Write-Host "Services:"
    $ServiceStatus | ForEach-Object {
        Write-Host "  $_"
    }

    Write-Host ""

    if ($DCConnection) {
        Write-Host "$using:DomainController Network      : OK"
    }
    else {
        Write-Host "$using:DomainController Network      : FAILED"
    }

    Write-Host "DNS Resolution: $DNSStatus"

    Write-Host ""
    Write-Host "==========================================="
}

Write-Host "===== NETWORK CONFIGURATION =====" -ForegroundColor Cyan

$network = Invoke-Command -ComputerName $ComputerName -ScriptBlock {

    $config = Get-NetIPConfiguration |
        Where-Object {$_.IPv4Address -ne $null} |
        Select-Object -First 1

    $ipAddress = $config.IPv4Address.IPAddress
    $dnsServer = $config.DNSServer.ServerAddresses

    [PSCustomObject]@{
        Interface = $config.InterfaceAlias
        IPAddress = $ipAddress
        DNSServer = $dnsServer -join ", "
    }
}

$expectedDNS = $DNSServer

Write-Host "Interface     : $($network.Interface)"
Write-Host "IP Address    : $($network.IPAddress)"
Write-Host "DNS Server    : $($network.DNSServer)"
Write-Host "Expected DNS  : $expectedDNS"

if ($network.DNSServer -contains $expectedDNS) {
    Write-Host "DNS Status    : OK" -ForegroundColor Green
}
else {
    Write-Host "DNS Status    : WARNING - Incorrect DNS Server" -ForegroundColor Red
}

Write-Host "===== DNS HEALTH CHECK =====" -ForegroundColor Cyan

$dnsTest = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    try {
        $result = Resolve-DnsName $using:DomainName -Server $using:DNSServer -ErrorAction Stop

        [PSCustomObject]@{
            Status = "OK"
            Name   = $result[0].Name
            IP     = $result[0].IPAddress
        }
    }
    catch {
        [PSCustomObject]@{
            Status = "FAILED"
            Name   = $using:DomainName
            IP     = "N/A"
        }
    }
}

Write-Host "DNS Server   : $DNSServer"
Write-Host "Domain       : $($dnsTest.Name)"
Write-Host "Resolved IP  : $($dnsTest.IP)"

if ($dnsTest.Status -eq "OK") {
    Write-Host "DNS Status   : OK" -ForegroundColor Green
}
else {
    Write-Host "DNS Status   : FAILED" -ForegroundColor Red
}