@echo off
echo ========================================
echo    KHAYR SIYAM - BUILD APK/AAB
echo ========================================
echo.

echo [1/4] Nettoyage du projet...
flutter clean
echo.

echo [2/4] Récupération des dépendances...
flutter pub get
echo.

echo [3/4] Construction de l'APK de debug...
flutter build apk --debug
echo.

echo [4/4] Construction de l'APK de release...
flutter build apk --release
echo.

echo ========================================
echo    CONSTRUCTION TERMINÉE !
echo ========================================
echo.
echo APK Debug: build/app/outputs/flutter-apk/app-debug.apk
echo APK Release: build/app/outputs/flutter-apk/app-release.apk
echo.
echo Pour installer sur votre téléphone:
echo 1. Activez le mode développeur sur votre téléphone
echo 2. Activez le débogage USB
echo 3. Connectez votre téléphone via USB
echo 4. Exécutez: flutter install
echo.
pause 