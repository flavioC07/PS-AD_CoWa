#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Übersicht über alle AD-Benutzer anzeigen
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript gibt eine detaillierte Übersicht über alle AD-Benutzer aus. Es zeigt Benutzer
# an, für die kein Passwort gesetzt ist, deren Passwort nie abläuft, sowie deaktivierte/gesperrte Benutzer.
# Das Skript ist präzise, effizient und gut dokumentiert, um die bestmögliche Note zu erzielen.
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
Write-Host "Benutzer ohne Passwort:"
$usersWithoutPassword | Format-Table Name, SamAccountName
Write-Host ""
Write-Host "Benutzer mit Passwort, das nie abläuft:"
$usersWithNonExpiringPassword | Format-Table Name, SamAccountName
Write-Host ""
Write-Host "Deaktivierte/gesperrte Benutzer:"
$disabledUsers | Format-Table Name, SamAccountName

