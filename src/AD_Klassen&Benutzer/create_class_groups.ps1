#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Erstellen und Verwalten von AD-Gruppen für Klassen
# Datum: 18.06.2023
# Version: 2.0
# Bemerkungen: Dieses Skript ermöglicht das Erstellen und Verwalten von AD-Gruppen für verschiedene Klassen.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Setze den Pfad zur CSV-Datei
$csvFile = "C:\github\PS-AD_CoWa\Data\schueler.csv"

# Setze die Ziel-OU für die Klassengruppen
$ouKlassengruppen = "OU=Klassengruppen,OU=BZTF,DC=conte,DC=local"

# Setze die Ziel-OU für die Lernenden
$ouLernende = "OU=Lernende,OU=BZTF,DC=conte,DC=local"

# Lese die Klassenliste aus der CSV-Datei
$classList = Import-Csv -Path $csvFile -Delimiter ";"

# Auswahl: Klassen erstellen oder löschen
$choice = Read-Host "Möchten Sie Klassen erstellen (C) oder Klassen löschen (L)? (C/L)"

if ($choice -eq "C") {
    # Klassen erstellen
    foreach ($class in $classList) {
        $className = $class.Klasse
        $class2Name = $class.Klasse2
        
        if ($className -ne "") {
            # Überprüfe, ob die Klasse bereits existiert
            $existingGroup = Get-ADGroup -Filter {Name -eq $className} -SearchBase $ouKlassengruppen
        
            if ($existingGroup) {
                Write-Host "Die Gruppe für die Klasse '$className' existiert bereits."
            } else {
                # Erstelle die Gruppe für die Klasse
                $newGroup = New-ADGroup -Name $className -GroupCategory Security -GroupScope Global -Path $ouKlassengruppen -PassThru
                Write-Host "Die Gruppe für die Klasse '$className' wurde erfolgreich erstellt."
            }
        
          
        }
        
        if ($class2Name -ne "" -and $class2Name -ne $className) {
            # Überprüfe, ob die zweite Klasse bereits existiert
            $existingGroup2 = Get-ADGroup -Filter {Name -eq $class2Name} -SearchBase $ouKlassengruppen
        
            if ($existingGroup2) {
                Write-Host "Die Gruppe für die Klasse '$class2Name' existiert bereits."
            } else {
                # Erstelle die Gruppe für die zweite Klasse (falls vorhanden)
                $newGroup2 = New-ADGroup -Name $class2Name -GroupCategory Security -GroupScope Global -Path $ouKlassengruppen -PassThru
                Write-Host "Die Gruppe für die Klasse '$class2Name' wurde erfolgreich erstellt."
            }
        
            # Füge die entsprechenden Benutzer zur zweiten Klasse hinzu
            if ($newGroup2) {
                $members2 = Get-ADUser -Filter {Klasse -eq $class2Name -or Klasse2 -eq $class2Name} -SearchBase $ouLernende
                foreach ($member2 in $members2) {
                    Add-ADGroupMember -Identity $newGroup2 -Members $member2
                    Write-Host "Der Benutzer '$($member2.Name)' wurde zur Klasse '$class2Name' hinzugefügt."
                }
                
            }
        }
    }
} elseif ($choice -eq "L") {
    # Klassen löschen
$classToDelete = Read-Host "Geben Sie den Namen der zu löschenden Klasse ein (oder * für alle Klassen):"

if ($classToDelete -eq "*") {
    $groupsToDelete = Get-ADGroup -Filter * -SearchBase $ouKlassengruppen
    foreach ($group in $groupsToDelete) {
        $groupName = $group.Name
        $members = Get-ADGroupMember -Identity $group
        foreach ($member in $members) {
            Remove-ADGroupMember -Identity $groupName -Members $member -Confirm:$false
        }
        Remove-ADGroup -Identity $groupName -Confirm:$false
        Write-Host "Die Gruppe '$groupName' wurde erfolgreich gelöscht."
    }
} elseif ($classToDelete) {
    $groupToDelete = Get-ADGroup -Filter {Name -eq $classToDelete} -SearchBase $ouKlassengruppen

    if ($groupToDelete) {
        $groupName = $groupToDelete.Name
        $members = Get-ADGroupMember -Identity $groupToDelete
        foreach ($member in $members) {
            Remove-ADGroupMember -Identity $groupName -Members $member -Confirm:$false
        }
        Remove-ADGroup -Identity $groupName -Confirm:$false
        Write-Host "Die Gruppe '$groupName' wurde erfolgreich gelöscht."
    } else {
        Write-Host "Die Gruppe für die Klasse '$classToDelete' existiert nicht."
    }
}

} else {
    Write-Host "Ungültige Auswahl."
}
