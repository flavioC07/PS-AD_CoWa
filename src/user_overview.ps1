#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Übersicht über alle AD-Benutzer anzeigen
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript gibt eine detaillierte Übersicht über alle AD-Benutzer aus. Es zeigt Benutzer
# an, für die kein Passwort gesetzt ist, deren Passwort nie abläuft, sowie deaktivierte/gesperrte Benutzer.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Benutzerinformationen abrufen
$users = Get-ADUser -Filter *

# Benutzer ohne Passwort
$usersWithoutPassword = $users | Where-Object { $_.PasswordNeverExpires -eq $false -and $_.PasswordLastSet -eq $null }

# Benutzer mit Passwort, das nie abläuft
$usersWithNonExpiringPassword = $users | Where-Object { $_.PasswordNeverExpires -eq $true }

# Deaktivierte/gesperrte Benutzer
$disabledUsers = $users | Where-Object { $_.Enabled -eq $false }

# Ausgabe der Benutzerübersicht
Write-Host "Übersicht über alle AD-Benutzer:"
Write-Host "---------------------------------"

# Spaltenüberschriften für die Benutzerübersicht
$columnHeaders = "Name", "SamAccountName", "Beschreibung"
$tableData = @()

# Benutzer ohne Passwort
Write-Host "Benutzer ohne Passwort:"
$usersWithoutPassword | ForEach-Object {
    $userData = [ordered]@{
        "Name" = $_.Name
        "SamAccountName" = $_.SamAccountName
        "Beschreibung" = "Kein Passwort gesetzt"
    }
    $tableData += New-Object -TypeName PSObject -Property $userData
}
$usersWithoutPassword | Format-Table Name, SamAccountName

Write-Host ""

# Benutzer mit Passwort, das nie abläuft
Write-Host "Benutzer mit Passwort, das nie abläuft:"
$usersWithNonExpiringPassword | ForEach-Object {
    $userData = [ordered]@{
        "Name" = $_.Name
        "SamAccountName" = $_.SamAccountName
        "Beschreibung" = "Passwort läuft nie ab"
    }
    $tableData += New-Object -TypeName PSObject -Property $userData
}
$usersWithNonExpiringPassword | Format-Table Name, SamAccountName

Write-Host ""

# Deaktivierte/gesperrte Benutzer
Write-Host "Deaktivierte/gesperrte Benutzer:"
$disabledUsers | ForEach-Object {
    $userData = [ordered]@{
        "Name" = $_.Name
        "SamAccountName" = $_.SamAccountName
        "Beschreibung" = "Deaktiviert/Gesperrt"
    }
    $tableData += New-Object -TypeName PSObject -Property $userData
}
$disabledUsers | Format-Table Name, SamAccountName

# Logfile erstellen und Benutzerübersicht speichern
$logFilePath = "C:\github\PS-AD_CoWa\logfiles\user_overview.log"
$tableData | Select-Object Name, SamAccountName, Beschreibung | Format-Table | Out-File -FilePath $logFilePath

Write-Host ""
Write-Host "Die Benutzerübersicht wurde im Logfile 'user_overview.log' gespeichert."

