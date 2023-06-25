#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Löschen aller Benutzer in der OU "BZTF > Lernende"
# Datum: 18.06.2023
# Version: 1.1
# Bemerkungen: Dieses Skript automatisiert den Prozess des Löschens aller Benutzer in der OU "BZTF > Lernende".
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Setze die Ziel-OU
$ou = "OU=Lernende,OU=BZTF,DC=conte,DC=local"

# Lese alle Benutzer in der Ziel-OU
$users = Get-ADUser -SearchBase $ou -Filter *

if ($users.Count -eq 0) {
    Write-Host "Es wurden keine Benutzer in der OU gefunden."
} else {
    Write-Host "Folgende Benutzer werden gelöscht:"

    foreach ($user in $users) {
        $username = $user.SamAccountName
        $name = $user.Name

        Write-Host "Benutzername: $username, Name: $name"

        # Benutzer löschen
        Remove-ADUser -Identity $user -Confirm:$false
    }

    Write-Host "Alle Benutzer wurden erfolgreich gelöscht."
}
