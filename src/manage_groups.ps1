#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Erstellen/Löschen der AD-Gruppen pro Klasse
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript automatisiert den Prozess des Erstellens und Löschens von AD-Gruppen pro Klasse.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfade und Dateinamen definieren
$csvFile = "C:\github\PS-AD_CoWa\Data\schueler.csv"
$logFile = "C:\github\PS-AD_CoWa\logfiles\taegliches_protokoll.log"

# Überprüfe, ob die CSV-Datei vorhanden ist
if (Test-Path $csvFile) {
    # Lese die CSV-Datei ein und erstelle/lösche die Gruppen
    $users = Import-Csv -Path $csvFile -Delimiter ";" | foreach{
        $className = $_.Klasse
        $groupPath = "OU=Lernende,OU=BZTF,DC=conte,DC=local"  
        $action = $_.Action

        if ($action -eq "Create") {
            # Überprüfe, ob die Gruppe bereits existiert
            if (Get-ADGroup -Filter {Name -eq $className}) {
                Write-Host "Fehler: Die Gruppe '$className' existiert bereits."
                Add-Content -Path $logFile -Value "Fehler: Die Gruppe '$className' existiert bereits."
            } else {
                # Erstelle die Gruppe
                $groupParams = @{
                    Name = $className
                    Path = $groupPath
                    GroupCategory = "Security"
                    GroupScope = "Global"
                }

                $newGroup = New-ADGroup @groupParams
                Write-Host "Die Gruppe '$className' wurde erfolgreich erstellt."
                Add-Content -Path $logFile -Value "Die Gruppe '$className' wurde erfolgreich erstellt."
            }
        } elseif ($action -eq "Delete") {
            # Überprüfe, ob die Gruppe existiert
            $group = Get-ADGroup -Filter {Name -eq $className}

            if ($group) {
                # Lösche die Gruppe
                Remove-ADGroup -Identity $group -Confirm:$false
                Write-Host "Die Gruppe '$className' wurde erfolgreich gelöscht."
                Add-Content -Path $logFile -Value "Die Gruppe '$className' wurde erfolgreich gelöscht."
            } else {
                Write-Host "Fehler: Die Gruppe '$className' existiert nicht."
                Add-Content -Path $logFile -Value "Fehler: Die Gruppe '$className' existiert nicht."
            }
        }
    }
} else {
    Write-Host "Fehler: Die CSV-Datei '$csvFile' wurde nicht gefunden."
    Add-Content -Path $logFile -Value "Fehler: Die CSV-Datei '$csvFile' wurde nicht gefunden."
}
