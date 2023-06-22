#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Benutzerkonten deaktivieren
# Datum: 18.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript ermöglicht das Deaktivieren von Benutzerkonten in der OU "BZTF > Lernende".
#----------------------------------------------------------------------------------------------------------

# Laden der erforderlichen Module
Import-Module ActiveDirectory

# Ziel-OU definieren
$ouPath = "OU=Lernende,OU=BZTF,DC=conte,DC=local"

# Funktion zum Deaktivieren der Benutzerkonten
function Deactivate-UserAccounts {
    # Benutzer in der OU "BZTF > Lernende" abrufen
    $users = Get-ADUser -Filter * -SearchBase $ouPath

    if ($users) {
        Write-Host "Folgende Benutzerkonten in der OU '$ouPath' werden deaktiviert:"

        foreach ($user in $users) {
            $username = $user.SamAccountName
            Write-Host "- $username"
            
            # Benutzerkonto deaktivieren
            Disable-ADAccount -Identity $username
        }

        Write-Host "Deaktivierung der Benutzerkonten abgeschlossen."
    } else {
        Write-Host "Es wurden keine Benutzerkonten in der OU '$ouPath' gefunden."
    }

    Pause
}

# Hauptprogramm
Deactivate-UserAccounts
