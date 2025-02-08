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