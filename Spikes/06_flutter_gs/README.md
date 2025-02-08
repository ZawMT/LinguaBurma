# Creating a flutter app to test Google sign in

## Steps to create an app which can log in using Google sign in
    Do not run the command right away! Before trying each step, read the full info first. 

### Step 1: Creating a flutter app
    Prerequisite: Environment should be readily set up to use 'flutter'
```
    flutter create gg_signin
```
    The first commit up to this change are just uploading the generated codes from the command above, apart from some additions in the gitignore not to save the files which are not currently interested files including, but not limited to, including the ones related to linux or macos. No other custom / self-written codes are included.
    This generated codes are ready to run. User can 'cd gg_signin' and then can try running the app by the following command:
```
    flutter run
```
    The available environemnts will be listend and use one of those to run the app. The app is just a flutter sample app.

### Step 2: Generating the key
    Prerequisite: JDK set up to run 'keytool' command
    A key file will be needed in this process of setting up to sign in using Google. Therefore, the file is generated using the following command.    
    For Mac / Linux:
```
    keytool -genkey -v -keystore ~/gg_signin.jks -keyalg RSA -keysize 2048 -validity 10000 -alias gg_signin
```
    In the command above, the parameter '~/gg_signin.jks' is the keyfile's name, and 'gg_signin' is the alias name, the same as '%userprofile%\gg_signin.jks' and 'gg_signin' are in the following.

    For Windows:
```
    keytool -genkey -v -keystore %userprofile%\gg_signin.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias gg_signin
```
    Then this generated file is put under 'gg_signin/android/app'.

### Step 3: Preparing in Google
    To be able to log in using Google sign-in, some setups are to be done in Google as well. 
    First, go to https://console.cloud.google.com/ and create a project.
    Then, we can create 'OAuth Client ID'. 
    Google might request to 'Configure Consent' first. Then this configuration must be done by providing the Application information as required and 'Audience' as 'External'.
    After this configuration, adding 'OAuth Client ID' should be doable. 
    *** Any issue with a sort of looping or being stuck up in this screen (i.e. Consent Configuration is done, but OAuth Client ID is still asking to do Consent Configuration again and again so it is not possible to proceed to adding OAuth Client ID), just try a few refreshing. 

    In creating OAuth Client ID, choose the Application type. For this example, it is 'Android'.
    *** It is important to fill up two following information: 'Package name' and 'SHA-1 certificate fingerprint'
    1: For 'Package name', use the name space in the generated code which is 'com.example.gg_signin'
    2: For 'SHA-1 certificate fingerprint', the following command is provided in the Google: 
```    
    keytool -keystore path-to-debug-or-production-keystore -list -v
```
    'path-to-debug-or-production-keystore' is 'android/app'. The safest way is to 'cd' into that folder first and run that command. So after doing 'cd', it will just be like:
```    
    keytool -keystore gg_signin.jks -list -v
```
    This command will result some info as output. Copy the 'SHA1' section which looks like:
    00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD:EE:FF:01:23:45:67
    Copy this string and fill it in Google 'SHA-1 certificate fingerprint', and create.

### Step 4: Link up the info
    All the information set up in Step 2 and 3 will be linked up by adding the following in the 'android/app/build.gradle'
```    
    signingConfigs {
        debug {
            keyAlias = 'gg_signin'
            keyPassword = 'gg_signin'
            storeFile = file('gg_signin.jks')
            storePassword = 'gg_signin'
        }
    }
```    
