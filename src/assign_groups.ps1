#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Zuweisung der AD Gruppen
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript automatisiert den Prozess des Erstellens und Deaktivierens von AD-Benutzerkonten
# für Lernende des BZT Frauenfeld anhand einer csv-Datei.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfade und Dateinamen definieren
$csvFile = "C:\github\PS-AD_CoWa\Data\schueler.csv"
$statistikFile = "C:\github\PS-AD_CoWa\logfiles\statistik_user.log"

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
        $group = $class
        Add-ADGroupMember -Identity $group -Members $username

       
    }
}
