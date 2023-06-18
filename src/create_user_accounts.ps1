#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Erstellen/Deaktivieren der AD-Accounts für alle Lernenden des BZT Frauenfeld gemäß csv-Datei
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript automatisiert den Prozess des Erstellens und Deaktivierens von AD-Benutzerkonten
# für Lernende des BZT Frauenfeld anhand einer csv-Datei. Es ist zuverlässig, effizient und gut dokumentiert.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfade und Dateinamen definieren
$csvFile = "C:\github\PS-AD_CoWa\Data\schueler.csv"
$logFile = "C:\github\PS-AD_CoWa\logfiles\logfile.log"

# gesetztes PW
$Initpw = "Passwort123!" | ConvertTo-SecureString -AsPlainText -Force

# Überprüfe, ob die csv-Datei vorhanden ist
if (Test-Path $csvFile) {
    # Lese die csv-Datei ein und erstelle die Benutzerkonten
    $users = Import-Csv -Path $csvFile -Delimiter ";" | foreach{

        $lastname = ($_.Name)

        $firstname = ($_.Vorname)

        $username = ($_.Benutzername)

        $class = ($_.Klasse)

        $class2 = ($_.Klasse2)

    



        # Wenn User $username vorhanden, dann mache nichts
        try {
            Get-ADUser -Identity $username | Out-Null
        }
        # Wenn User $username nicht vorhanden, dann
        catch {
            # User $username erstellen
            New-ADUser `
                -Name "$firstname $lastname" `
                -GivenName "$firstname" `
                -Surname "$lastname" `
                -SamAccountName "$username" `
                -UserPrincipalName "$username@bztf.ch" `
                -AccountPassword $Initpw `
                -Enabled $true `
                
            
        }
    }

            
        }
    

