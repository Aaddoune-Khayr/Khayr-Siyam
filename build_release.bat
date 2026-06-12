@echo off
echo ========================================
echo    BUILD KHAYR SIYAM - PRODUCTION
echo ========================================

echo.
echo [1/5] Nettoyage du projet...
flutter clean

echo.
echo [2/5] Récupération des dépendances...
flutter pub get

echo.
echo [3/5] Test de l'application...
flutter test

echo.
echo [4/5] Build APK de test...
flutter build apk --release

echo.
echo [5/5] Build AAB pour Play Store...
flutter build appbundle --release

echo.
echo ========================================
echo    BUILD TERMINÉ AVEC SUCCÈS !
echo ========================================
echo.
echo Fichiers générés :
echo - APK: build/app/outputs/flutter-apk/app-release.apk
echo - AAB: build/app/outputs/bundle/release/app-release.aab
echo.
echo Prochaines étapes :
echo 1. Tester l'APK sur un appareil
echo 2. Télécharger l'AAB sur Google Play Console
echo 3. Remplir les métadonnées
echo 4. Soumettre pour révision
echo.

flutter doctor

pause 