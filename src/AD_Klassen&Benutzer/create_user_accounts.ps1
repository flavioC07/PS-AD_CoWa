#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Erstellen/Deaktivieren der AD-Accounts für alle Lernenden des BZT Frauenfeld gemäß csv-Datei
# Datum: 02.06.2023
# Version: 1.4
# Bemerkungen: Dieses Skript automatisiert den Prozess des Erstellens und Deaktivierens von AD-Benutzerkonten
# für Lernende des BZT Frauenfeld anhand einer csv-Datei.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfade und Dateinamen definieren
$csvFile = "C:\github\PS-AD_CoWa\Data\schueler.csv"

# gesetztes PW
$Initpw = "NeuesPasswort123!" | ConvertTo-SecureString -AsPlainText -Force

# Ziel-OU festlegen
$targetOU = "OU=Lernende,OU=BZTF,DC=conte,DC=local"

# Überprüfe, ob die csv-Datei vorhanden ist
if (Test-Path $csvFile) {
    # Lese die csv-Datei ein und erstelle die Benutzerkonten
    $users = Import-Csv -Path $csvFile -Delimiter ";" | foreach{
        $lastname = $_.Name
        $firstname = $_.Vorname
        $username = $_.Benutzername -replace '\.', '_'
        $class = $_.Klasse
        $class2 = $_.Klasse2  # Für BM Schüler

           # Wenn Benutzername groesser als 20 Zeichen, dann
           if ($username.length -gt 20) {
            # Benutzername wird gekuerzt auf die ersten 20 Zeichen
            $username = $username.Remove(20)
            
        }

        # Wenn der Benutzer $username noch nicht vorhanden ist, erstelle ihn
        if (-not (Get-ADUser -Filter "SamAccountName -eq '$username'")) {
            $newUserParams = @{
                Name = "$firstname $lastname"
                GivenName = $firstname
                Surname = $lastname
                SamAccountName = $username
                UserPrincipalName = "$username@conte.local"
                AccountPassword = $Initpw
                Enabled = $true
                Path = $targetOU
            }

            # Benutzer erstellen
            New-ADUser @newUserParams

           
        }
    }
}
