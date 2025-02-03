# About this spike
This spike will create just a Hello World app using Flutter.

## How to create and run the containers
To create the app, the environment need to be set up accordingly such as Flutter, Android Studio, etc. 
Then the codes in the folder are created by using the following command. 
However, to try this spike, the codes are readily generated, so you can use those codes right away (i.e. no need to generate the codes again)
```
flutter create hello_world
```

### Step 1 - Check the readiness
Check the readiness of the environment running the following command.
```
    flutter doctor
```
Since this spike is just to try out for Android, any error or warning output under the topic "Xcode" can be ignore.
If there is any issues here, it needs to fix those first.

### Step 2 - Running the app
To run the app, first, we need to list the available devices to run the app on. 
To check what are the available devices to run the app, run the following command.
```
flutter devices
```
At least, chrome should be in the output provided that Google Chrome is installed.
Then app can be run as:
```
flutter run -d chrome
```

### Step 3 - Using emulators
If there are available emulators, app can be run there as well. First check what are the available emulators.
```
flutter emulators
```
Emulators will be listed and the targeted emulator can be started as follow (if not started yet)
```
flutter run -d EMULATOR-ID
```
After running this, when the device has fully started, the output of "flutter devices" should list this emulator with an RUNNING-EMULAOR-ID.
Then, the app can run on this emulator in a similar way like:
```
flutter run -d RUNNING-EMULATOR-ID
```
This can take quite long (depedning on the performance of the development IDE)

### Step 4 - Using physical device
If running on a physical device is desirable, set up the Android device for Developer / USB Debugging.
After that, the list of devices given by "flutter devices" will include an ID for this physical device.
Then run the app there in a similar way above.
This can be relatively faster than an emulator.