# 📱 Guide de Publication - Google Play Store

## 🎯 **Préparer l'Application pour la Production**

### **1. Configuration de l'Application**

#### **A. Modifier pubspec.yaml**
```yaml
name: khayr_siyam
description: Application de jeûne islamique avec calendrier et hadiths
publish_to: 'none'  # Changez en 'none' pour le Play Store
version: 1.0.0+1    # Version de l'app
```

#### **B. Créer l'icône de l'application**
- **Taille requise** : 512x512 pixels (PNG)
- **Couleurs recommandées** : Vert islamique (#1E88E5, #4CAF50)
- **Design** : Icône de mosquée ou de calendrier islamique
- **Placez l'icône** dans `assets/icons/app_icon.png`

#### **C. Créer le splash screen**
- **Taille** : 1024x1024 pixels
- **Design** : Logo de l'app avec fond dégradé
- **Placez** dans `assets/images/splash.png`

### **2. Configuration Android**

#### **A. Modifier android/app/build.gradle**
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.votreentreprise.khayr_siyam"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

#### **B. Créer la clé de signature**
```bash
keytool -genkey -v -keystore khayr_siyam.keystore -alias khayr_siyam -keyalg RSA -keysize 2048 -validity 10000
```

#### **C. Configurer la signature dans android/key.properties**
```properties
storePassword=votre_mot_de_passe
keyPassword=votre_mot_de_passe
keyAlias=khayr_siyam
storeFile=../khayr_siyam.keystore
```

### **3. Optimisations pour la Production**

#### **A. Ajouter les permissions dans android/app/src/main/AndroidManifest.xml**
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

#### **B. Créer le fichier proguard-rules.pro**
```pro
-keep class com.example.khayr_siyam.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
```

#### **C. Optimiser les images**
- **Compresser** toutes les images
- **Utiliser** des formats optimisés (WebP)
- **Réduire** la taille des assets

---

## 🏪 **Créer le Compte Google Play Console**

### **1. Inscription**
1. **Allez** sur [play.google.com/console](https://play.google.com/console)
2. **Créez** un compte Google si nécessaire
3. **Payez** les frais d'inscription (25$ USD, une seule fois)
4. **Complétez** votre profil développeur

### **2. Informations Requises**
- **Nom légal** et adresse
- **Informations bancaires** pour les paiements
- **Numéro de téléphone** vérifié
- **Adresse email** professionnelle

---

## 📋 **Préparer les Métadonnées**

### **1. Informations de l'Application**

#### **A. Titre de l'application**
- **Français** : "Khayr Siyam - Jeûne Islamique"
- **Anglais** : "Khayr Siyam - Islamic Fasting"
- **Arabe** : "خير صيام - الصيام الإسلامي"

#### **B. Description courte (80 caractères max)**
- **Français** : "Calendrier de jeûne islamique avec Hadiths"
- **Anglais** : "Islamic fasting calendar with Hadiths"
- **Arabe** : "تقويم الصيام الإسلامي مع الأحاديث"

#### **C. Description complète**
```
🕌 Khayr Siyam - Votre compagnon pour le jeûne islamique

📅 CALENDRIER COMPLET
• Calcul automatique des dates hijri
• Jours de jeûne recommandés (lundi/jeudi, vendredi)
• Jours blancs (13, 14, 15 de chaque mois)
• Jours spéciaux (Arafat, Achoura, Shawwal)
• Jours interdits (Eid, Tachriq)

📖 HADITHS PROPHÉTIQUES
• Plus de 15 Hadiths authentiques
• Explications pédagogiques
• Références complètes (Boukhari, Mouslim, etc.)
• Organisés par catégories

🌍 SUPPORT MULTILINGUE
• Français, Arabe, Anglais
• Interface adaptée à chaque langue
• Support RTL pour l'arabe

⚙️ FONCTIONNALITÉS
• Thèmes clair/sombre
• Notifications personnalisables
• Interface moderne et intuitive
• Animations fluides
• Mode hors ligne

🎯 POUR QUI ?
• Musulmans pratiquants
• Étudiants en sciences islamiques
• Familles musulmanes
• Nouveaux convertis

📱 CARACTÉRISTIQUES
• Design Material 3 moderne
• Navigation intuitive
• Calculs précis des dates
• Informations fiables et authentiques

Téléchargez Khayr Siyam et améliorez votre pratique du jeûne avec les enseignements prophétiques !
```

### **2. Mots-clés**
```
jeûne islamique, ramadan, hadith, calendrier musulman, jours blancs, arafat, achoura, shawwal, dhul hijjah, sunna, prophète, islam, musulman, prière, adoration, spiritualité, hijri, calendrier lunaire
```

### **3. Catégorie**
- **Catégorie principale** : Lifestyle
- **Catégorie secondaire** : Education

---

## 🖼️ **Assets Visuels Requis**

### **1. Icônes et Images**
- **Icône haute résolution** : 512x512 px
- **Icône Play Store** : 512x512 px
- **Capture d'écran téléphone** : 1080x1920 px (minimum 2)
- **Capture d'écran tablette** : 1200x1920 px (optionnel)
- **Bannière** : 1024x500 px

### **2. Contenu des Captures d'Écran**
1. **Page d'accueil** avec le prochain jour de jeûne
2. **Section Hadiths** avec une catégorie ouverte
3. **Calendrier** avec des jours marqués
4. **Page de détail** d'un jour de jeûne
5. **Paramètres** avec les options

### **3. Vidéo de Présentation (Optionnel mais Recommandé)**
- **Durée** : 30-60 secondes
- **Format** : MP4
- **Résolution** : 1920x1080
- **Contenu** : Démonstration des fonctionnalités principales

---

## 🔧 **Build de Production**

### **1. Build APK/AAB**
```bash
# Dans le dossier Application
flutter build appbundle --release
```

### **2. Tester l'APK**
```bash
flutter build apk --release
flutter install
```

### **3. Vérifications Avant Publication**
- [ ] L'application se lance sans erreur
- [ ] Toutes les fonctionnalités marchent
- [ ] Les notifications fonctionnent
- [ ] Le design est cohérent
- [ ] Les traductions sont complètes
- [ ] Les performances sont bonnes

---

## 📤 **Publication sur le Play Store**

### **1. Créer une Nouvelle Application**
1. **Connectez-vous** à Google Play Console
2. **Cliquez** "Créer une application"
3. **Choisissez** "Application"
4. **Remplissez** les informations de base

### **2. Remplir les Informations**
1. **Informations de l'application**
2. **Métadonnées** (titre, description, mots-clés)
3. **Assets** (icônes, captures d'écran)
4. **Classification** (catégorie, contenu)
5. **Prix et distribution**

### **3. Télécharger l'AAB**
1. **Allez** dans "Production"
2. **Cliquez** "Créer une nouvelle version"
3. **Téléchargez** votre fichier .aab
4. **Ajoutez** les notes de version

### **4. Révision et Publication**
1. **Soumettez** pour révision
2. **Attendez** 1-3 jours pour l'approbation
3. **L'application** sera publiée automatiquement

---

## ⚠️ **Points Importants**

### **1. Conformité**
- **Respecter** les politiques Google Play
- **Éviter** le contenu religieux controversé
- **Utiliser** des descriptions appropriées
- **Respecter** les droits d'auteur

### **2. SEO et Visibilité**
- **Mots-clés** pertinents dans le titre et la description
- **Captures d'écran** attrayantes
- **Description** détaillée et engageante
- **Catégorisation** appropriée

### **3. Support Utilisateur**
- **Email** de support dans la description
- **FAQ** ou guide d'utilisation
- **Réponses** rapides aux commentaires
- **Mises à jour** régulières

---

## 📊 **Après la Publication**

### **1. Suivi des Performances**
- **Analytics** dans Google Play Console
- **Commentaires** et notes
- **Téléchargements** et installations
- **Rétention** des utilisateurs

### **2. Mises à Jour**
- **Corrections de bugs**
- **Nouvelles fonctionnalités**
- **Améliorations** de performance
- **Nouveaux Hadiths**

### **3. Marketing**
- **Réseaux sociaux** (Instagram, Facebook)
- **Communautés** musulmanes en ligne
- **Blogs** et sites islamiques
- **Influenceurs** religieux

---

## 💰 **Monétisation (Optionnel)**

### **1. Publicités**
- **AdMob** pour les bannières
- **Publicités interstitielles**
- **Publicités récompensées**

### **2. Version Premium**
- **Fonctionnalités avancées**
- **Sans publicités**
- **Contenu exclusif**
- **Support prioritaire**

### **3. Dons**
- **Intégration** de dons pour la mosquée
- **Collecte** pour des projets islamiques
- **Support** du développement

---

## 🎯 **Checklist Finale**

### **Avant la Publication**
- [ ] Application testée et fonctionnelle
- [ ] Icône et assets créés
- [ ] Métadonnées rédigées
- [ ] AAB généré
- [ ] Compte Play Console créé
- [ ] Frais d'inscription payés

### **Après la Publication**
- [ ] Application approuvée
- [ ] Page de l'app optimisée
- [ ] Support utilisateur configuré
- [ ] Plan de mises à jour établi
- [ ] Stratégie marketing définie

---

**🚀 Votre application Khayr Siyam sera bientôt disponible sur le Google Play Store !**

*N'oubliez pas : La qualité et l'authenticité du contenu islamique sont essentielles pour gagner la confiance de la communauté musulmane.* 