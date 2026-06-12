# 🚀 Guide d'Installation - Khayr Siyam

## 📋 **Prérequis**

### **1. Installer Flutter**
1. **Téléchargez Flutter** depuis [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. **Extrayez** le fichier dans `C:\flutter`
3. **Ajoutez Flutter au PATH** :
   - Ouvrez les **Paramètres système** → **Variables d'environnement**
   - Dans **Variables système**, trouvez **Path** et cliquez **Modifier**
   - Cliquez **Nouveau** et ajoutez : `C:\flutter\bin`
   - Cliquez **OK** pour fermer toutes les fenêtres

### **2. Installer Android Studio (Recommandé)**
1. **Téléchargez** [Android Studio](https://developer.android.com/studio)
2. **Installez** avec les paramètres par défaut
3. **Ouvrez Android Studio** et suivez l'assistant d'installation
4. **Installez le plugin Flutter** :
   - File → Settings → Plugins
   - Recherchez "Flutter" et installez-le
   - Redémarrez Android Studio

### **3. Installer VS Code (Alternative)**
1. **Téléchargez** [VS Code](https://code.visualstudio.com/)
2. **Installez l'extension Flutter** :
   - Ouvrez VS Code
   - Allez dans Extensions (Ctrl+Shift+X)
   - Recherchez "Flutter" et installez l'extension officielle

## 🔧 **Configuration du projet**

### **1. Vérifier l'installation Flutter**
Ouvrez un **nouveau terminal** et exécutez :
```bash
flutter doctor
```

Vous devriez voir quelque chose comme :
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows [Version 10.x.x])
[✓] Windows Version (Installed version of Windows is version 10 or higher)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
[✓] Chrome - develop for the web (Chrome is installed)
[✓] Visual Studio - develop for Windows (Visual Studio Community 2022 17.0.0)
[✓] VS Code (version 1.x.x)
[✓] Connected device (3 available)
[✓] Network resources

• No issues found!
```

### **2. Naviguer vers le projet**
```bash
cd "C:\Users\abdzp\OneDrive\Documents\Khayr_Siyam\Application"
```

### **3. Installer les dépendances**
```bash
flutter pub get
```

## 📱 **Lancer l'application**

### **Option 1 : Avec un émulateur Android**
1. **Ouvrez Android Studio**
2. **Ouvrez AVD Manager** (Tools → AVD Manager)
3. **Créez un émulateur** si vous n'en avez pas
4. **Démarrez l'émulateur**
5. **Dans le terminal** :
```bash
flutter run
```

### **Option 2 : Avec votre téléphone Android**
1. **Activez le mode développeur** sur votre téléphone :
   - Paramètres → À propos du téléphone
   - Tapez 7 fois sur "Numéro de build"
2. **Activez le débogage USB** :
   - Paramètres → Options pour les développeurs
   - Activez "Débogage USB"
3. **Connectez votre téléphone** via USB
4. **Autorisez le débogage** sur votre téléphone
5. **Dans le terminal** :
```bash
flutter run
```

### **Option 3 : Dans le navigateur web**
```bash
flutter run -d chrome
```

## 🎯 **Voir la nouvelle section Hadiths**

Une fois l'application lancée, vous verrez :

1. **4 onglets** en haut de l'écran :
   - 🏠 **Accueil** - Vue d'ensemble
   - 📅 **Calendrier** - Calendrier des jours de jeûne
   - 📖 **Hadiths** - **NOUVEAU !** Section des Hadiths
   - ⚙️ **Paramètres** - Configuration

2. **Cliquez sur "Hadiths"** pour voir :
   - 📚 **Les mérites du jeûne**
   - 📅 **Les jours de jeûne recommandés**
   - ⭐ **Les jours spéciaux**
   - ⚠️ **Les jours interdits**
   - 🙏 **Les invocations du jeûne**

3. **Cliquez sur chaque catégorie** pour voir les Hadiths détaillés avec :
   - 💡 **Explications pédagogiques**
   - 📜 **Textes complets des Hadiths**
   - 📖 **Références authentiques**

## 🔍 **Dépannage**

### **Erreur "flutter not found"**
- Redémarrez votre terminal après avoir ajouté Flutter au PATH
- Vérifiez que le chemin `C:\flutter\bin` est bien dans les variables d'environnement

### **Erreur de dépendances**
```bash
flutter clean
flutter pub get
flutter run
```

### **Erreur d'émulateur**
- Vérifiez que l'émulateur est bien démarré
- Essayez de redémarrer l'émulateur
- Utilisez `flutter devices` pour voir les appareils disponibles

### **Erreur de compilation**
- Vérifiez que vous avez la bonne version de Flutter : `flutter --version`
- Assurez-vous que tous les fichiers sont présents dans le dossier Application

## 📞 **Support**

Si vous rencontrez des problèmes :
1. **Vérifiez** que Flutter est bien installé : `flutter doctor`
2. **Consultez** la documentation Flutter : [flutter.dev](https://flutter.dev/docs)
3. **Recherchez** sur Stack Overflow pour des solutions spécifiques

---

## 🎉 **Félicitations !**

Une fois l'application lancée, vous pourrez explorer :
- ✅ **Interface moderne** avec animations fluides
- ✅ **Section Hadiths complète** avec tous les Hadiths que vous avez fournis
- ✅ **Support multilingue** (Français, Arabe, Anglais)
- ✅ **Design responsive** adapté à tous les écrans
- ✅ **Navigation intuitive** entre les différentes sections

**Bonne exploration de votre application Khayr Siyam !** 🕌 