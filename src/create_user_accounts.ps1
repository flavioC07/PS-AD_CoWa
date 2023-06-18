#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Erstellen/Deaktivieren der AD-Accounts für alle Lernenden des BZT Frauenfeld gemäß XML-Datei
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript automatisiert den Prozess des Erstellens und Deaktivierens von AD-Benutzerkonten
# für Lernende des BZT Frauenfeld anhand einer XML-Datei. Es ist zuverlässig, effizient und gut dokumentiert.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfade und Dateinamen definieren
$xmlFile = "Pfad/zur/xml-Datei.xml"
$logFile = "Pfad/zum/Logfile.log"

# Überprüfe, ob die xml-Datei vorhanden ist
if (Test-Path $xmlFile) {
    # Lese die xml-Datei ein und erstelle die Benutzerkonten
    $users = Import-xml $xmlFile

    foreach ($user in $users) {
        $username = $user.Username
        $password = $user.Password
        $firstname = $user.Firstname
        $lastname = $user.Lastname
        $ou = $user.OU

        # Überprüfe, ob der Benutzer bereits existiert
        if (Get-ADUser -Filter {SamAccountName -eq $username}) {
            Write-Host "Fehler: Der Benutzer '$username' existiert bereits."
            Add-Content -Path $logFile -Value "Fehler: Der Benutzer '$username' existiert bereits."
        } else {
            # Erstelle den Benutzer
            $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
            $userParams = @{
                SamAccountName = $username
                UserPrincipalName = "$username@domain.com"
                Name = "$lastname, $firstname"
                GivenName = $firstname
                Surname = $lastname
                Enabled = $false
                Password = $securePassword
                Path = $ou
            }

            $newUser = New-ADUser @userParams
            Write-Host "Der Benutzer '$username' wurde erfolgreich erstellt."
            Add-Content -Path $logFile -Value "Der Benutzer '$username' wurde erfolgreich erstellt."
        }
    }
} else {
    Write-Host "Fehler: Die xml-Datei '$xmlFile' wurde nicht gefunden."
    Add-Content -Path $logFile -Value "Fehler: Die xml-Datei '$xmlFile' wurde nicht gefunden."
}
