#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Protokollierung der Benutzerinformationen
# Datum: 02.06.2023
# Version: 1.4
# Bemerkungen: Dieses Skript protokolliert das Passwortalter, das Datum der letzten Anmeldung und die Anzahl der Logins für jeden Benutzer.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Konfiguration
$logFilePath = "C:\github\PS-AD_CoWa\logfiles\user_info.log"

# Setze die Ziel-OU für die Lernenden
$ouLernende = "OU=Lernende,OU=BZTF,DC=conte,DC=local"

# Benutzerinformationen abrufen
$users = Get-ADUser -Filter * -SearchBase "OU=Lernende,OU=BZTF,DC=conte,DC=local" -properties *

# Benutzerinformationen protokollieren
$userData = @()
foreach ($user in $users) {
    $passwordLastSet = $user.PasswordLastSet
    if ($passwordLastSet) {
        $passwordAge = (Get-Date) - $passwordLastSet
        $passwordAgeDays = "{0} Tage, {1} Stunden, {2} Minuten, {3} Sekunden" -f $passwordAge.Days, $passwordAge.Hours, $passwordAge.Minutes, $passwordAge.Seconds

    }
    else {
        $passwordAgeDays = "N/A"
    }

    # Eigenschaften aus dem AD abrufen
    $lastLogon = $user.LastLogonDate
    $logonCount = $user.logonCount

    $userData += [PSCustomObject]@{
        "Benutzername" = $user.SamAccountName
        "Passwortalter" = $passwordAgeDays
        "Letzte Anmeldung" = $lastLogon
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

# Logfile leeren und Protokolldatei aktualisieren
Clear-Content -Path $logFilePath
Add-Content -Path $logFilePath -Value $logMessage
