## Library
1. import library dulu di terminal (flutter pub add mobile scanner)
2. trus import ini juga permission_handler

## How To Setup Permission using Flutter
=> Android
1. import library yang diatas
2. buka project structure, cari AndroidManifest.xml
android/app/src/main/AndroidManifest.xml
3. tambahin <uses-permission android:name="android.permission.CAMERA"/> di bawah tag <manifest>

=> IOS
1. import library yang diatas
2. buka project structure, cari Info.plist
ios/Runner/Info.plist
3. tambahin ini di dalem <dict> paling atas
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan QR codes</string>
