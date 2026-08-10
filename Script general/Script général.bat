@echo off
color 2
::lance le script en administrateur
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Ce script necessite les droits administrateur.
    echo Relance en administrateur...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls

:menu
cls
echo ====================================
echo           MENU PRINCIPAL
echo ====================================
echo 1. Menu solutions
echo 2. Mode technicien
echo 3. Quitter
echo ====================================

set /p choix=Faites votre choix (1-3) : 

if "%choix%"=="1" goto solutions
if "%choix%"=="2" goto menutech1
if "%choix%"=="3" goto fin

echo Choix invalide, reessayez.
timeout /t 2 >nul
goto menu


:solutions
cls
echo ====================================
echo           Menu Solutions
echo ====================================
echo 1. Nettoyage cache
echo 2. Correction acces rapide explorateur
echo 3. Visioneuse 
echo 4. Analyse et reparation système
echo 5. Reinitialisation reseau
echo 9. Retour
echo ====================================

set /p choix=Faites votre choix (1-9) : 

if "%choix%"=="1" goto option1
if "%choix%"=="2" goto option2
if "%choix%"=="3" goto option3
if "%choix%"=="4" goto option4
if "%choix%"=="5" goto option5
if "%choix%"=="9" goto menu

echo Choix invalide, reessayez.
timeout /t 2 >nul
goto menu


:option1
cls
echo Set objShell = CreateObject("WScript.Shell") > "%temp%\popup.vbs"
echo intAns = objShell.Popup("Voulez-vous vraiment nettoyer l ordinateur? (cela ne supprime que les fichiers temporaires)", 0, "Nettoyage Ordinateur", 4 + 32) >> "%temp%\popup.vbs"
echo WScript.Echo intAns >> "%temp%\popup.vbs"


:: Récupérer le choix de l'utilisateur
for /f %%a in ('cscript //nologo "%temp%\popup.vbs"') do set choix=%%a

:: supprime le fichier temporaire qui stock la réponse oui ou non
del "%temp%\popup.vbs"

:: détermine ou aller après avoir choisis oui ou non
if %choix%==6 goto action_oui
if %choix%==7 goto action_non

:action_oui
cls
echo Nettoyage des fichiers temporaires et reparation de windows...
::nettoie les fichiers temporraires du %temp%
del /q /s /f "%temp%\*" >nul 2>&1
for /d %%p in ("%temp%\*") do rd /s /q "%%p" >nul 2>&1
cleanmgr /sagerun:1
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('tu dois un cafe a Mathieu', 'TAXE CAFE')"
pause
goto menu

:action_non
cls
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('paye quand meme ton cafe a mathieu', 'TAXE CAFE')"
goto menu
exit

::option2
:: il faut trouver une utilitée pour rajouter les favoris ou un accès rapide aux applications


:option2
cls
del /F /Q %APPDATA%\Microsoft\Windows\Recent\*
echo 1/3
Pause

del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*
echo 2/3
Pause

del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*
echo 3/3
goto menu

:option3
cls
echo ===============================================
echo                VISIONEUSE WINDOWS
echo ===============================================
echo                   //ATTENTION\\
echo Pour executer ce script vous devez avoir les 
echo suivants dans le dossier C:\Temp
echo.
echo - Activer_Visionneuse_de_photos_Windows.reg
echo - Desactiver_Visionneuse_de_photos_Windows.reg
echo ===============================================

set /p choix=Avez-vous les fichiers dans le meme dossier? (y/n): 

if "%choix%"=="y" goto choix_y
if "%choix%"=="n" goto choix_n

echo Choix invalide, reessayez.
timeout /t 2 >nul
goto option4

:option4
cls
title Verification Systeme
echo Verification des fichiers systeme (SFC)...
sfc /scannow
echo Analyse de l'image du systeme (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto solutions

:option5
cls
title Reset Reseau
echo Liberation de l'adresse IP...
ipconfig /release
echo Renouvellement de l'adresse IP...
ipconfig /renew
echo Vidage du cache DNS...
ipconfig /flushdns
echo Reinitialisation Winsock...
netsh winsock reset
echo Redmarrez le PC pour finaliser.
pause
goto solutions

:choix_y
cls
echo ===============================================
echo                VISIONEUSE WINDOWS
echo ===============================================
echo Quel action voulez-vous faire?
echo
echo 1. Activer la visionneuse windows
echo 2. Desactiver la visionneuse windows
echo ===============================================
set /p choix=Faites votre choix (1-2) : 

if "%choix%"=="1" goto activer
if "%choix%"=="2" goto desactiver

echo Choix invalide, reessayez.
timeout /t 2 >nul
goto choix_y

:Activer
cls
start C:\Temp\Activer_Visionneuse_de_photos_Windows.reg
echo l'activation a bien ete faite
pause
goto solutions

:Desactiver
cls
start C:\Temp\Desactiver_Visionneuse_de_photos_Windows.reg
echo la desactivation a bien ete faite
pause
goto solutions

:choix_n
echo merci de deposer les fichiers dans le dossier C:\Temp et relancer le script
pause
goto solutions

:menutech1
cls
echo ====================================
echo           Mode technicien
echo               Page 1
echo ====================================
echo 1. Ouvrir le gestionaire de peripherique
echo 2. Ouvrir le registre
echo 3. Ouvrir les certificats
echo 4. Ouvrir l observateur d elements
echo 5. Ouvrir le gestionnaire de taches
echo 6. Ouvrir le gestionnaire de disque
echo 7. Ouvrir le CMD
echo 8. Page 2
echo 9. Menu principale
echo ====================================

set /p choix=Faites votre choix (1-9) : 

if "%choix%"=="1" goto app1
if "%choix%"=="2" goto app2
if "%choix%"=="3" goto app3
if "%choix%"=="4" goto app4
if "%choix%"=="5" goto app5
if "%choix%"=="6" goto app6
if "%choix%"=="7" goto app7
if "%choix%"=="8" goto menutech2
if "%choix%"=="9" goto menu

echo Choix invalide, reessayez.
timeout /t 2 >nul
goto menutech1

:app1
cls
start devmgmt.msc
goto menutech1

:app2
cls
start regedit
goto menutech1

:app3
cls
start certmgr.msc
goto menutech1

:app4
cls
start eventvwr.msc
goto menutech1

:app5
cls
start taskmgr
goto option5

:app6
cls
start diskmgmt.msc
goto menutech1

:app7
cls
start cmd.exe
goto menutech1

:menutech2
cls
echo ====================================
echo           Mode technicien
echo               Page 2
echo ====================================
echo 1. Ouvrir le panneau de configuration
echo 8. Page 1
echo 9. Menu principale
echo ====================================

set /p choix=Faites votre choix (1-9) : 

if "%choix%"=="1" goto app1.1
if "%choix%"=="8" goto option5
if "%choix%"=="9" goto menu

echo Choix invalide, reessayez.
timeout /t 2 >nul
goto page2

:app1.1
cls
start control
goto menutech2

:fin
exit
