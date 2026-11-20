
 
 
 # Check internet connection

 $testConnection = ping www.google.com

  Add-Content -Path "C:\Temp\InternetTest.txt" -Value (Get-Date)

  Add-Content -Path "C:\Temp\InternetTest.txt" -Value $testConnection

  Write-Host "Added internetTest.txt, refer to C:\Temp\InternetTest.txt".

 
 
 }


function fileDirSetup {

    # Creation of Staging Area for files exfiltration

    Write-Host "Creating Staging folder + all evidence folders..."

    if (Test-Path -Path "C:\Temp\Stage") {
    
        "Stage already exists! This script has been ran. Continuing on."
        Write-Host ""
       
    
    } else {
    
        Write-Host "Loading..."
        Write-Host ""
    
    }

    Write-Host ""

    New-Item -Path "C:\Temp\" -Name "Stage" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "installedPrograms" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "networkConnections" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "prefetch" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "processes" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "scheduledTasks" -ItemType "Directory"
  
    New-Item -Path "C:\Temp\Stage\" -Name "secEventLog" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "sysInfo" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "tempDirs" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "usersGroups" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "shellHistory" -ItemType "Directory"

    New-Item -Path "C:\Temp\Stage\" -Name "browserFiles" -ItemType "Directory"

    Write-Host ""

    Write-Host "Outputting created folders..."

    Write-Host ""

    $output = Get-ChildItem -Path "C:\Temp\Stage" -Directory | Format-Table | Out-String

    Write-Host ""
    
    Write-Host "Created folders: $output"

    if ($output -eq "") {
    
        Write-Host "Creation failed, no folders created! Check permissions."
        Write-Host ""
        break
    
    
    } else {
        
        Write-Host "Staging Complete!"
        Write-Host ""
    
    }

}



function autoruns {

    Write-Host "Starting autoruns evidence collection... "

}


function installedPrograms {

    Write-Host "Starting installed programs evidence collection..."
    Write-Host ""


    # Grabbing HKLM\SOFTWARE

    Write-Host "Obtaining HKEY_LOCAL_MACHINE\SOFTWARE...."

    $HKLMSOFTWAREHIVE = Get-ChildItem -Path HKLM:\SOFTWARE

    Write-Host $HKLMSOFTWAREHIVE

    Write-Host ""

    Write-Host "Finished: HKEY_LOCAL_MACHINE\SOFTWARE"

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\installedPrograms\HKLM_SOFTWARE.log" -Value $HKLMSOFTWAREHIVE

    Write-Host "Added to installedPrograms dir under HKLM_SOFTWARE.log"

    Write-Host ""


    # Grabbing HKCU\Software

    Write-Host "Obtaining HKEY_CURRENT_USER\Software...."

    $HKCUSOFTWAREHIVE = Get-ChildItem -Path HKCU:\Software

    Write-Host $HKCUSOFTWAREHIVE

    Write-Host ""

    Write-Host "Finished: HKEY_CURRENT_USER\SOFTWARE"

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\installedPrograms\HKCU_SOFTWARE.log" -Value $HKCUSOFTWAREHIVE

    Write-Host "Added to installedPrograms dir under HKCU_SOFTWARE.log"

    Write-Host ""

    

    # Grabbing HK_USERS\*\Software

    Write-Host "Obtaining HKEY_USERS\*\Software...."

    $HKEYUSERSHIVE = Get-ChildItem -Path "Registry::HKEY_USERS\*\Software\*"

    Write-Host $HKEYUSERSHIVE

    Write-Host ""

    Write-Host "Finished: HKEY_USERS\SOFTWARE"

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\installedPrograms\HKEY_USERS.log" -Value $HKEYUSERSHIVE

    Write-Host "Added to installedPrograms dir under HKEY_USERS.log"

    Write-Host ""



    # Grabbing HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*

    Write-Host "Obtaining DisplayName for HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"

    $paths = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

    foreach ($path in $paths) {
    
        $HKLMUNINSTALL = Get-ChildItem -Path $path | Get-ItemProperty | Select-Object -Property DisplayName, InstallSource
        Add-Content -Path "C:\Temp\Stage\installedPrograms\HKLM_UNINSTALL.log" -Value $HKLMUNINSTALL    
    }

    Write-Host $HKLMUNINSTALL

    Write-Host ""

    Write-Host "Added to installedPrograms dir under HKLM_UNINSTALL.log"

    Write-Host ""

    Write-Host "Finished: DisplayName + InstallSource for HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"

    Write-Host ""

}

function networkConnections {

    Write-Host "Starting network connections evidence collection..."
    Write-Host ""


    # Grabbing all IP Info

    Write-Host "Obtaining all IP Info"

    Write-Host ""

    $IPINFO = Get-NetIPAddress | Format-Table | Out-String

    Write-Host $IPINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\IP_INFO.log" -Value $IPINFO

    Write-Host "Added to networkConnections dir under IP_INFO.log"



    # Grabbing all Network Adapter Info

    Write-Host ""

    Write-Host "Obtaining all Network Adapter Info"

    Write-Host ""

    $ADAPTERINFO = Get-NetAdapter | Format-Table | Out-String

    Write-Host $ADAPTERINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\ADAPTER_INFO.log" -Value $ADAPTERINFO

    Write-Host "Added to networkConnections dir under ADAPTER_INFO.log"



    # Grabbing all Network Route Info

    Write-Host ""

    Write-Host "Obtaining all Network Routing Info"

    Write-Host ""

    $NETROUTEINFO = Get-NetRoute | Format-Table | Out-String

    Write-Host $NETROUTEINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\NETROUTE_INFO.log" -Value $NETROUTEINFO

    Write-Host "Added to networkConnections dir under NETROUTE_INFO.log"



    # Grabbing all Active Network Info

    Write-Host ""

    Write-Host "Obtaining all Active TCP Network Info"

    Write-Host ""

    $ACTIVENETINFO = Get-NetTCPConnection | Format-Table | Out-String

    Write-Host $ACTIVENETINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\ACTIVETCP_INFO.log" -Value $ACTIVENETINFO

    Write-Host "Added to networkConnections dir under ACTIVETCP_INFO.log"



     # Grabbing all Active UDP Info

    Write-Host ""

    Write-Host "Obtaining all Active UDP Info"

    Write-Host ""

    $ACTIVEUDPINFO = Get-NetUDPEndpoint | Format-Table | Out-String

    Write-Host $ACTIVEUDPINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\ACTIVEUDP_INFO.log" -Value $ACTIVEUDPINFO

    Write-Host "Added to networkConnections dir under ACTTIVEUDP_INFO.log"



    # Grabbing all ARP Info

    Write-Host ""

    Write-Host "Obtaining all ARP Info"

    Write-Host ""

    $ARPINFO = Get-NetNeighbor | Format-Table | Out-String

    Write-Host $ARPINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\ARPINFO.log" -Value $ARPINFO

    Write-Host "Added to networkConnections dir under ARP_INFO.log"



    # Grabbing all DNS Info

    Write-Host ""

    Write-Host "Obtaining all DNS Server Info"

    Write-Host ""

    $DNSINFO = Get-DnsClientServerAddress | Format-Table | Out-String

    Write-Host $DNSINFO

    Write-Host ""

    Add-Content -Path "C:\Temp\Stage\networkConnections\DNS_INFO.log" -Value $DNSINFO

    Write-Host "Added to networkConnections dir under DNS_INFO.log"



}


function prefetchFiles {

    Write-Host ""

    Write-Host "Obtaining Prefetch folder..."

    Write-Host ""

    Copy-Item -Path 'C:\Windows\prefetch\*' -Destination "C:\Temp\Stage\prefetch"

    if (Test-Path -Path "C:\Temp\Stage\prefetch\*") {
    
        Write-Host "Prefetch files have been successfully copied to C:\Temp\Stage\prefetch dir."
    
    } else {
    
        Write-Host "Prefetch copy failed."
    
    
    }


}


function processes {

    Write-Host ""

    Write-Host "Obtaining Process information..."

    Write-Host ""


    # Get all Processes via Tasklist

    Write-Host ""

    Write-Host "Obtaining tasklist output"

    Write-Host ""

    $TASKLIST = tasklist | Format-Table | Out-String

    Write-Host $TASKLIST

    Add-Content -Path "C:\Temp\Stage\processes\TASKLIST.log" -Value $TASKLIST

    Write-Host "Added to processes dir under TASKLIST.log"


    # Get all Processes via Tasklist /V

    Write-Host ""

    Write-Host "Obtaining tasklist /V output"

    Write-Host ""

    $TASKLIST = tasklist /V | Format-Table | Out-String

    Write-Host $TASKLISTV

    Add-Content -Path "C:\Temp\Stage\processes\TASKLISTV.log" -Value $TASKLISTV

    Write-Host "Added to processes dir under TASKLISTV.log"



    Write-Host ""

    Write-Host "Obtaining bulk processes"

    Write-Host ""

    $BULK_PRO = Get-Process | Format-Table | Out-String

    Write-Host $BULK_PRO

    Add-Content -Path "C:\Temp\Stage\processes\BULK_PROCESSES.log" -Value $BULK_PRO

    Write-Host "Added to processes dir under BULK_PROCESSES.log"
    

    # Get all Processes + Owner

    Write-Host ""

    Write-Host "Obtaining bulk processes with owners"

    Write-Host ""

    $BULK_PRO_OWN = Get-Process -IncludeUserName | Format-Table | Out-String

    Write-Host $BULK_PRO

    Add-Content -Path "C:\Temp\Stage\processes\BULK_PROCESSES_OWNERS.log" -Value $BULK_PRO_OWN

    Write-Host "Added to processes dir under BULK_PROCESSES_OWNERS.log"



    # Get all Process Extras (Cim)

    Write-Host ""

    Write-Host "Obtaining bulk processes with advanced fields"

    Write-Host ""

    $BULK_PRO_ADV = Get-CimInstance Win32_Process | Select-Object Name, ProcessID, CommandLine, ParentProcessID | Format-Table | Out-String

    Write-Host $BULK_PRO

    Add-Content -Path "C:\Temp\Stage\processes\BULK_PROCESSES_ADV.log" -Value $BULK_PRO_ADV

    Write-Host "Added to processes dir under BULK_PROCESSES_ADV.log"



    # Get all DLL's

    Write-Host ""

    Write-Host "Obtaining bulk DLL's"

    Write-Host ""

    $BULK_PRO_DLL = Get-Process | ForEach-Object { $_.Modules }| Select-Object ModuleName, FileName, Size | Format-Table | Out-String

    Write-Host $BULK_PRO_DLL

    Add-Content -Path "C:\Temp\Stage\processes\BULK_PROCESSES_DLL.log" -Value $BULK_PRO_DLL

    Write-Host "Added to processes dir under BULK_PROCESSES_DLL.log"



    # Get all Services

    Write-Host ""

    Write-Host "Obtaining bulk services"

    Write-Host ""

    $BULK_PRO_SRV = Get-Service | Format-Table | Out-String

    Write-Host $BULK_PRO_SRV

    Add-Content -Path "C:\Temp\Stage\processes\BULK_PROCESSES_SRV.log" -Value $BULK_PRO_SRV

    Write-Host "Added to processes dir under BULK_PROCESSES_SRV.log"

}



function scheduledTasks {

    # Get all Scheduled Tasks

    Write-Host ""

    Write-Host "Obtaining all scheduled tasks"

    Write-Host ""

    $SCH_TASKS = Get-ScheduledTask | Format-Table | Out-String

    Write-Host $SCH_TASKS

    Add-Content -Path "C:\Temp\Stage\scheduledTasks\SCH_TASKS.log" -Value $SCH_TASKS

    Write-Host "Added to scheduledTasks dir under SCH_TASKS.log"


    # Get PowerShell Sceduled Tasks


    Write-Host ""

    Write-Host "Obtaining all PowerShell Scheduled tasks"

    Write-Host ""

    if (Test-Path -Path "C:\Windows\System32\Tasks\Microsoft\WindowsPowershell\ScheduledJobs") {
        
        Write-Host "PowerShell Tasks exist. Extracting..."
        New-Item -Path "C:\Temp\Stage\" -Name "PS_Scheduled_Jobs" -ItemType "Directory" 
        Copy-Item -Path 'C:\System32\Tasks\Microsoft\WindowsPowershell\ScheduledJobs\*' -Destination "C:\Temp\Stage\scheduledTasks"
    
    } else {
    
        Write-Host "PowerShell Tasks do not exist. Continuing..."
    
    
    }


    # Get all Scheduled Tasks in Registry

    Write-Host ""

    Write-Host "Obtaining all scheduled tasks via Registry"

    Write-Host ""

    $SCHTASKSREG = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks" | Format-Table | Out-String
    
    Write-Host $SCHTASKSREG

    Add-Content -Path "C:\Temp\Stage\scheduledTasks\SCH_TASKS_REG.log" -Value $SCHTASKSREG

    Write-Host "Added to scheduledTasks dir under SCH_TASKS_REG.log"
    


}



function secEventLog {

    # Grabbing Two Mins ago SYS logs

    $2MinBegin = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $2MinEnd = (Get-Date).AddMinutes(-2).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host "Obtaining -2 mins SYS    logs..."
    
    Write-Host ""
    
    $2MinLog = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    StartTime = $2MinEnd
    EndTime   = $2MinBegin
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\2min_LOG.log" -Value $2MinLog

    Write-Host "Added to secEventLog dir under 2min_LOG.log"


    # Grabbing Two Mins ago SEC logs

    $2MinBeginSEC = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $2MinEndSEC = (Get-Date).AddMinutes(-2).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host "Obtaining -2 mins SEC logs..."
    
    Write-Host ""
    
    $2MinLogSEC = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $2MinEnd
    EndTime   = $2MinBegin
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\2min_SEC_LOG.log" -Value $2MinLogSEC

    Write-Host "Added to secEventLog dir under 2min_SEC_LOG.log"

    # Grabbing Two Mins ago SEC logs

    $2MinBeginAPP = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $2MinEndAPP = (Get-Date).AddMinutes(-2).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host "Obtaining -2 mins APP logs..."
    
    Write-Host ""
    
    $2MinLogAPP = Get-WinEvent -FilterHashtable @{
    LogName   = 'Application'
    StartTime = $2MinEndAPP
    EndTime   = $2MinBeginAPP
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\2min_APP_LOG.log" -Value $2MinLogAPP

    Write-Host "Added to secEventLog dir under 2min_APP_LOG.log"







    # Grabbing Five Mins ago logs

    $5MinBegin = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $5MinEnd = (Get-Date).AddMinutes(-5).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -5 mins SYS logs..."
    
    Write-Host ""
    
    $5MinLog = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    StartTime = $5MinEnd
    EndTime   = $5MinBegin
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\5min_LOG.log" -Value $5MinLog

    Write-Host "Added to secEventLog dir under 5min_LOG.log"


    # Grabbing Five Mins ago SEC logs

    $5MinBeginSEC = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $5MinEndSEC = (Get-Date).AddMinutes(-5).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -5 mins SEC logs..."
    
    Write-Host ""
    
    $5MinLogSEC = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $5MinEndSEC
    EndTime   = $5MinBeginSEC
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\5min_SEC_LOG.log" -Value $5MinLogSEC

    Write-Host "Added to secEventLog dir under 5min_SEC_LOG.log"


    # Grabbing Five Mins ago logs

    $5MinBeginAPP = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $5MinEndAPP = (Get-Date).AddMinutes(-5).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -5 mins APP logs..."
    
    Write-Host ""
    
    $5MinLogAPP = Get-WinEvent -FilterHashtable @{
    LogName   = 'Application'
    StartTime = $5MinEndAPP
    EndTime   = $5MinBeginAPP
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\5min_APP_LOG.log" -Value $5MinLogAPP

    Write-Host "Added to secEventLog dir under 5min_APP_LOG.log"











    # Grabbing Ten Mins ago logs

    $10MinBegin = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $10MinEnd = (Get-Date).AddMinutes(-10).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -10 mins SYS logs..."
    
    Write-Host ""
    
    $10MinLog = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    StartTime = $10MinEnd
    EndTime   = $10MinBegin
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\10min_LOG.log" -Value $10MinLog

    Write-Host "Added to secEventLog dir under 10min_LOG.log"


    # Grabbing Ten Mins ago logs

    $10MinBeginSEC = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $10MinEndSEC = (Get-Date).AddMinutes(-10).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -10 mins SEC logs..."
    
    Write-Host ""
    
    $10MinLogSEC = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $10MinEndSEC
    EndTime   = $10MinBeginSEC
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\10min_SEC_LOG.log" -Value $10MinLogSEC

    Write-Host "Added to secEventLog dir under 10min_SEC_LOG.log"


    # Grabbing Ten Mins ago logs

    $10MinBeginAPP = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $10MinEndAPP = (Get-Date).AddMinutes(-10).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -10 mins APP logs..."
    
    Write-Host ""
    
    $10MinLogAPP = Get-WinEvent -FilterHashtable @{
    LogName   = 'Application'
    StartTime = $10MinEndAPP
    EndTime   = $10MinBeginAPP
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\10min_APP_LOG.log" -Value $10MinLogAPP

    Write-Host "Added to secEventLog dir under 10min_APP_LOG.log"




    




    # Grabbing Twenty Mins ago logs

    $20MinBegin = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $20MinEnd = (Get-Date).AddMinutes(-20).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -20 mins SYS logs..."
    
    Write-Host ""
    
    $20MinLog = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    StartTime = $20MinEnd
    EndTime   = $20MinBegin
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\20min_LOG.log" -Value $20MinLog

    Write-Host "Added to secEventLog dir under 20min_LOG.log"


    # Grabbing Twenty Mins ago logs

    $20MinBeginSEC = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $20MinEndSEC = (Get-Date).AddMinutes(-20).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -20 mins SEC logs..."
    
    Write-Host ""
    
    $20MinLogSEC = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $20MinEndSEC
    EndTime   = $20MinBeginSEC
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\20min_SEC_LOG.log" -Value $20MinLogSEC

    Write-Host "Added to secEventLog dir under 20min_SEC_LOG.log"


    # Grabbing Twenty Mins ago logs

    $20MinBeginAPP = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $20MinEndAPP = (Get-Date).AddMinutes(-20).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -20 mins APP logs..."
    
    Write-Host ""
    
    $20MinLogAPP = Get-WinEvent -FilterHashtable @{
    LogName   = 'Application'
    StartTime = $20MinEndAPP
    EndTime   = $20MinBeginAPP
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\20min_APP_LOG.log" -Value $20MinLogAPP

    Write-Host "Added to secEventLog dir under 20min_APP_LOG.log"









    # Grabbing Thirty Mins ago logs

    $30MinBegin = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $30MinEnd = (Get-Date).AddMinutes(-30).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -30 mins SYS logs..."
    
    Write-Host ""
    
    $30MinLog = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    StartTime = $30MinEnd
    EndTime   = $30MinBegin
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\30min_LOG.log" -Value $30MinLog

    Write-Host "Added to secEventLog dir under 30min_LOG.log"
    

    # Grabbing Thirty Mins ago logs

    $30MinBeginSEC = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $30MinEndSEC = (Get-Date).AddMinutes(-30).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -30 mins SEC logs..."
    
    Write-Host ""
    
    $30MinLogSEC = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    StartTime = $30MinEndSEC
    EndTime   = $30MinBeginSEC
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\30min_SEC_LOG.log" -Value $30MinLogSEC

    Write-Host "Added to secEventLog dir under 30min_SEC_LOG.log"


    # Grabbing Thirty Mins ago logs

    $30MinBeginAPP = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $30MinEndAPP = (Get-Date).AddMinutes(-30).ToString("yyyy/MM/dd HH:mm:ss")

    Write-Host ""

    Write-Host "Obtaining -30 mins APP logs..."
    
    Write-Host ""
    
    $30MinLogAPP = Get-WinEvent -FilterHashtable @{
    LogName   = 'Application'
    StartTime = $30MinEndAPP
    EndTime   = $30MinBeginAPP
} | Out-String

    Add-Content -Path "C:\Temp\Stage\secEventLog\30min_APP_LOG.log" -Value $30MinLogAPP

    Write-Host "Added to secEventLog dir under 30min_APP_LOG.log"


}


function sysInfo {

    Write-Host "Using systeminfo"

    Write-Host ""

    $SYSTEMINFO = systeminfo | Format-Table | Out-String

    Write-Host $SYSTEMINFO

    Add-Content -Path "C:\Temp\Stage\sysInfo\SYSTEMINFO.log" -Value $SYSTEMINFO


    
    Write-Host "Obtaining CurrentVersion Registry Values.."
    
    Write-Host ""

    $SYSINFOREG = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  | Format-List | Out-String
    
    Write-Host $SYSINFOREG

    Add-Content -Path "C:\Temp\Stage\sysInfo\SYSINFOREG.log" -Value $SYSINFOREG

    Write-Host "Added to sysInfo dir under SYSINFOREG.log"


    
    Write-Host "Obtaining CurrentControlSet USB Registry Values.."
    
    Write-Host ""

    $SYSINFOUSB = Get-ChildItem -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\USBSTOR"  | Format-List | Out-String
    
    Write-Host $SYSINFOUSB

    Write-Host $SYSINFOUSB

    Add-Content -Path "C:\Temp\Stage\sysInfo\SYSINFOUSB.log" -Value $SYSINFOUSB

    Write-Host "Added to sysInfo dir under SYSINFOUSB.log"


}




function tempDirs {

    Write-Host "Obtaining C:\Temp folder info"

    Write-Host ""

    $TMPFOLDERINFO = Get-ChildItem -Path "C:\Temp\" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\sysInfo" -Value $TMPFOLDERINFO

    Write-Host $TMPFOLDERINFO


    Write-Host "Adding C:\Users\*\AppData\Local\Temp"

    Write-Host ""

    $APPDATATMPFOLDERINFO = Get-ChildItem -Path "C:\Users\*\AppData\Local\Temp\*" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\sysInfo" -Value $APPDATATMPFOLDERINFO

    Write-Host $APPDATATMPFOLDERINFO




}


function usersGroups {


    Write-Host "Obtaining User creation time"

    Write-Host ""

    $USRCREATIONTIME = Get-ChildItem -Path "C:\Users\*" | Select-Object Name, CreationTime | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_CREATION_TIME.log" -Value $USRCREATIONTIME

    Write-Host $USRCREATIONTIME


    Write-Host "Obtaining Registry based User info"

    Write-Host ""

    $USRREGINFO = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*" | Get-ItemProperty | Select-Object -Property Sid, ProfileImagePath, LocalProfileLoadTimeHigh, LocalProfileLoadTimeLow, LocalProfileUnloadTimeHigh, LocalProfileUnloadTimeLow | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_REG_INFO.log" -Value $USRREGINFO

    Write-Host $USRREGINFO


    Write-Host "Listing Downloads Dir for all Users"

    Write-Host ""

    $DESKTOP = Get-ChildItem -Path "C:\Users\*\Downloads\*" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_DOWN_INFO.log" -Value $DESKTOP

    Write-Host $DESKTOP


    Write-Host "Listing Docuemnts Dir for all Users"

    Write-Host ""

    $DOCUMENTS = Get-ChildItem -Path "C:\Users\*\Documents\*" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_DOCS_INFO.log" -Value $DOCUMENTS

    Write-Host $DOCUMENTS


    Write-Host "Listing Pictures Dir for all Users"

    Write-Host ""

    $PICTURES = Get-ChildItem -Path "C:\Users\*\Pictures\*" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_PICS_INFO.log" -Value $PICTURES

    Write-Host $PICTURES


    Write-Host "Listing Videos Dir for all Users"

    Write-Host ""

    $VIDEOS = Get-ChildItem -Path "C:\Users\*\Videos\*" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_VIDEOS_INFO.log" -Value $VIDEOS

    Write-Host $VIDEOS


    Write-Host "Listing C:\Users\*\* Dir for all Users"

    Write-Host ""

    $ALL = Get-ChildItem -Path "C:\Users\*\*" | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_ALL_INFO.log" -Value $ALL

    Write-Host $ALL


    
    Write-Host "Obtaining current logged on user"

    Write-Host ""

    $CURRENT = quser | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\USR_CURRENT_INFO.log" -Value $CURRENT

    Write-Host $CURRENT


    Write-Host "Using net.exe to provide user info"

    Write-Host ""

    $NETUSR = net user | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\NETUSR_INFO.log" -Value $NETUSR

    Write-Host $NETUSR


    Write-Host "Using net.exe to provide group info"

    Write-Host ""

    $NETGRP = net localgroup | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\NETGRP_INFO.log" -Value $NETGRP

    Write-Host $NETGRP


    Write-Host "Using whoami to provide user info"

    Write-Host ""

    $WHOAMI = whoami /user | Format-Table | Out-String

    Add-Content -Path "C:\Temp\Stage\usersGroups\WHOAMI.log" -Value $WHOAMI

    Write-Host $WHOAMI

    
    Write-Host "Querying localgroup membership"

    Write-Host ""


   $LOCALGRPUSR = Get-LocalGroup | ForEach-Object {
        $group = $_.Name
        Get-LocalGroupMember -Group $group | Select-Object @{N="GroupName"; E={$group}}, Name, ObjectClass, PrincipalSource | Format-Table | Out-String | Add-Content -Path "C:\Temp\Stage\usersGroups\LOCALGRPMEMBERSHIP.log"
       
    } 


}


function ShellHistory {

    Write-Host "Obtaining Shell History for all possible users"

    Write-Host ""

    $Users = Get-ChildItem "C:\Users" -Directory

    foreach ($User in $Users) {

        $HistoryFile = Join-Path $User.FullName "AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"

        if (Test-Path $HistoryFile) {

            Write-Host "Copying history for $($User.Name)"

            Copy-Item -Path $HistoryFile -Destination "C:\Temp\Stage\ShellHistory\$($User.Name)_ConsoleHost_history.txt" -Force
        }
    }
}



function browserFiles () {

    Write-Host "Grabbing Browser History from Edge..."

    Write-Host ""

    New-Item -Path "C:\Temp\Stage\browserFiles\" -Name "Edge" -ItemType "Directory"

    $path = "C:\Users\*\AppData\Local\Microsoft\Edge\User Data\Default\History"

    Copy-Item -Path $path -Destination "C:\Temp\Stage\browserFiles\Edge\"

    if (Test-Path -Path "C:\Temp\Stage\browserFiles\Edge\History") {
    
        Write-Host "Edge History copy succeeded!"

        Write-Host ""
    
    
    
    } else {
    
    Write-Host "Copy Failed!"

    Write-Host
    
    
    }

    Write-Host "Grabbing Browser History from Chrome..."

    Write-Host ""

    New-Item -Path "C:\Temp\Stage\browserFiles\" -Name "Chrome" -ItemType "Directory"

    $path = "C:\Users\*\AppData\Local\Google\Chrome\User Data\Default\History"

    Copy-Item -Path $path -Destination "C:\Temp\Stage\browserFiles\Chrome\"

    if (Test-Path -Path "C:\Temp\Stage\browserFiles\Chrome\History") {
    
        Write-Host "Chrome History copy succeeded!"

        Write-Host ""
    
    
    
    } else {
    
    Write-Host "Copy Failed!"

    Write-Host
    
    
    }




}


fileDirSetup
installedPrograms
networkConnections
prefetchFiles
processes
scheduledTasks
secEventLog
sysInfo
tempDirs
usersGroups
shellHistory
fileDirSetup
browserFiles