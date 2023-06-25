#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Protokollierung der Benutzerinformationen
# Datum: 02.06.2023
# Version: 1.2
# Bemerkungen: Dieses Skript protokolliert das Passwortalter, das Datum der letzten Anmeldung und die Anzahl der Logins für jeden Benutzer.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Konfiguration
$logFilePath = "C:\github\PS-AD_CoWa\logfiles\user_info.log"

# Benutzerinformationen abrufen
$users = Get-ADUser -Filter *

# Benutzerinformationen protokollieren
$userData = @()
foreach ($user in $users) {
    $passwordLastSet = $user.PasswordLastSet
    if ($passwordLastSet) {
        $passwordAge = (Get-Date) - $passwordLastSet
        $passwordAgeDays = $passwordAge.Days
    }
    else {
        $passwordAgeDays = "N/A"
    }

    $lastLogonDate = $user.LastLogonDate
    $logonCount = $user.LogonCount

    $userData += [PSCustomObject]@{
        "Benutzername" = $user.SamAccountName
        "Passwortalter" = $passwordAgeDays
        "Letzte Anmeldung" = $lastLogonDate
        "Anzahl der Logins" = $logonCount
    }
}

# Tabelle für die Benutzerinformationen formatieren
$table = $userData | Sort-Object "Benutzername" | Format-Table -AutoSize | Out-String

# Protokollierung der Benutzerinformationen
$logMessage = @"
$('-' * 80)
Datum und Uhrzeit: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Passwortalter, Datum der letzten Anmeldung und Anzahl der Logins für jeden Benutzer:

$table
"@

# Protokolldatei aktualisieren
Add-Content -Path $logFilePath -Value $logMessage
