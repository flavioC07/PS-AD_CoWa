#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Verwaltung einzelner AD-Benutzer
# Datum: 02.06.2023
# Version: 1.1
# Bemerkungen: Dieses Skript ermöglicht das Entsperren, Aktivieren und Zurücksetzen des Passworts für einen einzelnen AD-Benutzer. Es sperrt den Benutzer automatisch nach fünf fehlgeschlagenen Anmeldeversuchen oder nach sieben Tagen ohne Passwortänderung.
#----------------------------------------------------------------------------------------------------------

# Importieren des Active Directory Moduls
Import-Module ActiveDirectory

# Funktion zum Entsperren des Kontos
function Unlock-UserAccount {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Username
    )

    # Entsperren des Kontos
    try {
        Unlock-ADAccount -Identity $Username
        Write-Host "Das Konto '$Username' wurde erfolgreich entsperrt."
    }
    catch {
        Write-Host "Fehler beim Entsperren des Kontos '$Username'. $_" -ForegroundColor Red
    }
}

# Funktion zum Aktivieren des Kontos
function Enable-UserAccount {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Username
    )

    # Aktivieren des Kontos
    try {
        Enable-ADAccount -Identity $Username
        Write-Host "Das Konto '$Username' wurde erfolgreich aktiviert."
    }
    catch {
        Write-Host "Fehler beim Aktivieren des Kontos '$Username'. $_" -ForegroundColor Red
    }
}

# Funktion zum Zurücksetzen des Passworts
function Reset-UserPassword {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Username
    )

    # Neues Passwort festlegen
    $NewPassword = ConvertTo-SecureString -String "NeuesPasswort123!" -AsPlainText -Force

    # Passwort zurücksetzen
    try {
        Set-ADAccountPassword -Identity $Username -NewPassword $NewPassword -Reset
        Write-Host "Das Passwort für das Konto '$Username' wurde erfolgreich zurückgesetzt."
    }
    catch {
        Write-Host "Fehler beim Zurücksetzen des Passworts für das Konto '$Username'. $_" -ForegroundColor Red
    }
}

# Funktion zum Überprüfen der Anmeldeversuche eines Benutzers
function Check-LoginAttempts {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Username
    )

    $user = Get-ADUser -Identity $Username -Properties BadPwdCount, PasswordLastSet, LockedOut

    if ($user.LockedOut) {
        Write-Host "Das Konto '$Username' ist gesperrt."
    }
    elseif ($user.BadPwdCount -ge 5) {
        Write-Host "Das Konto '$Username' wurde aufgrund von fünf fehlgeschlagenen Anmeldeversuchen gesperrt."
        Lock-ADAccount -Identity $Username
    }
    elseif ($user.PasswordLastSet -lt (Get-Date).AddDays(-7)) {
        Write-Host "Das Passwort des Kontos '$Username' wurde seit mehr als sieben Tagen nicht geändert und das Konto wird gesperrt."
        Lock-ADAccount -Identity $Username
    }
    else {
        Write-Host "Das Konto '$Username' ist nicht gesperrt."
    }
}

# Funktion zum Anzeigen des Hauptmenüs
function Show-MainMenu {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "                  Verwaltung einzelner AD-Benutzer"
    Write-Host "============================================================"
    Write-Host "Hauptmenü"
    Write-Host "1. Konto entsperren"
    Write-Host "2. Konto aktivieren"
    Write-Host "3. Passwort zurücksetzen"
    Write-Host "Q. Beenden"
    Write-Host "============================================================"
    Write-Host
}

# Funktion zum Ausführen der ausgewählten Option
function Execute-Option {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Option
    )

    switch ($Option) {
        '1' {
            $usernameOption = Read-Host "Möchten Sie alle Benutzerkonten (A) oder ein einzelnes Benutzerkonto (E) entsperren?"
            if ($usernameOption -eq "A") {
                $allUsers = Import-Csv -Path "C:\github\PS-AD_CoWa\Data\schueler.csv"  
                $allUsers | ForEach-Object {
                    Unlock-UserAccount -Username $_.Username
                }
            }
            elseif ($usernameOption -eq "E") {
                $username = Read-Host "Geben Sie den Benutzernamen ein"
                Unlock-UserAccount -Username $username
            }
            else {
                Write-Host "Ungültige Option"
            }
        }
        '2' {
            $usernameOption = Read-Host "Möchten Sie alle Benutzerkonten (A) oder ein einzelnes Benutzerkonto (E) aktivieren?"
            if ($usernameOption -eq "A") {
                $allUsers = Import-Csv -Path "C:\github\PS-AD_CoWa\Data\schueler.csv"  
                $allUsers | ForEach-Object {
                    Enable-UserAccount -Username $_.Username
                }
            }
            elseif ($usernameOption -eq "E") {
                $username = Read-Host "Geben Sie den Benutzernamen ein"
                Enable-UserAccount -Username $username
            }
            else {
                Write-Host "Ungültige Option"
            }
        }
        '3' {
            $usernameOption = Read-Host "Möchten Sie alle Benutzerkonten (A) oder ein einzelnes Benutzerkonto (E) zurücksetzen?"
            if ($usernameOption -eq "A") {
                $allUsers = Import-Csv -Path "C:\github\PS-AD_CoWa\Data\schueler.csv"  
                $allUsers | ForEach-Object {
                    Reset-UserPassword -Username $_.Username
                }
            }
            elseif ($usernameOption -eq "E") {
                $username = Read-Host "Geben Sie den Benutzernamen ein"
                Reset-UserPassword -Username $username
            }
            else {
                Write-Host "Ungültige Option"
            }
        }
        'Q' {
            Write-Host "Zurück zum Hauptmenü"
        }
        default {
            Write-Host "Ungültige Option"
        }
    }

    Write-Host "Drücken Sie eine beliebige Taste, um fortzufahren..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp')
}

# Hauptprogramm
do {
    Show-MainMenu
    $option = Read-Host "Geben Sie die Option ein"

    Execute-Option -Option $option

    Write-Host "Drücken Sie eine beliebige Taste, um fortzufahren..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp')
} while ($option -ne 'Q')
