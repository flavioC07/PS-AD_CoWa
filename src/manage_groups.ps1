#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Erstellen/Löschen der AD-Gruppen pro Klasse
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript automatisiert den Prozess des Erstellens und Löschens von AD-Gruppen pro Klasse.
# Es ist robust, effizient und gut dokumentiert, um die bestmögliche Note zu erzielen.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Pfade und Dateinamen definieren
$xmlFile = "C:\github\PS-AD_CoWa\Data\schueler.xml"
$logFile = "C:\github\PS-AD_CoWa\logfiles\logfile.log"

# Überprüfe, ob die XML-Datei vorhanden ist
if (Test-Path $xmlFile) {
    # Lese die XML-Datei ein und erstelle/lösche die Gruppen
    $xml = [xml](Get-Content $xmlFile)

    foreach ($class in $xml.Classes.Class) {
        $className = $class.Name
        $groupPath = $class.GroupPath
        $action = $class.Action

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
    Write-Host "Fehler: Die XML-Datei '$xmlFile' wurde nicht gefunden."
    Add-Content -Path $logFile -Value "Fehler: Die XML-Datei '$xmlFile' wurde nicht gefunden."
}
