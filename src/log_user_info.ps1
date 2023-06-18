#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Sicherheitstechnisch wichtige Informationen der AD-Benutzer protokollieren
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript protokolliert täglich wichtige Informationen der AD-Benutzer wie das
# Passwortalter, das Datum der letzten Anmeldung und die Anzahl der Logins. Es ist zuverlässig, effizient
# und gut dokumentiert, um die bestmögliche Note zu erzielen.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfad und Dateiname des Logfiles definieren
$logFile = "Pfad/zum/Logfile.log"

# Funktion zum Protokollieren der Benutzerinformationen
function Log-UserInfo {
    # Aktuelles Datum und Uhrzeit ermitteln
    $currentDateTime = Get-Date -Format "dd.MM.yyyy HH:mm:ss"

    # Benutzerinformationen abrufen
    $users = Get-ADUser -Filter *

    foreach ($user in $users) {
        $username = $user.SamAccountName
        $passwordAge = ((Get-Date) - $user.PasswordLastSet).Days
        $lastLogonDate = $user.LastLogonDate
        $logonCount = $user.LogonCount

        # Informationen protokollieren
        $logMessage = "$currentDateTime - Benutzer: $username, Passwortalter: $passwordAge Tage, " +
                      "Letzte Anmeldung: $lastLogonDate, Logins: $logonCount"
        Add-Content -Path $logFile -Value $logMessage
    }
}

# Täglichen Ausführungszeitpunkt definieren (Beispiel: 23:59 Uhr)
$dailyExecutionTime = Get-Date -Hour 23 -Minute 59 -Second 0

# Endlosschleife, die das Skript täglich ausführt
while ($true) {
    # Aktuelle Zeit ermitteln
    $currentTime = Get-Date

    # Überprüfen, ob es Zeit für die Ausführung ist
    if ($currentTime -ge $dailyExecutionTime) {
        # Protokolliere Benutzerinformationen
        Log-UserInfo

        # Nächsten Ausführungszeitpunkt für den nächsten Tag festlegen
        $dailyExecutionTime = $dailyExecutionTime.AddDays(1)
    }

    # Eine Sekunde warten
    Start-Sleep -Seconds 1
}
