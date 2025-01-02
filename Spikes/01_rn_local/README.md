# Creating a basic react-native app
    The app is created and run locallaly.

## Steps to create and run the app
### Prerequesite:
    Environment is ready to run npm / npx as required

    Do not run the command right away! Before trying each step, read the full info first. 
### Step 1:
```
    npx create-expo-app --template blank
```
    There might be a prompt asking to install create-expo-app@3.2.0. If so, just say yes by typing "y".
    For app name, default name "my-app" is used.
    A message will finally show up saying that the app is ready and how it can be run for different environment.
### Step 2:
```
    npm run web
```
    This command will lookcause the error like "package.json" cannot be found because the system is looking for the file in "folder", but all the generated files are in "folder/my-app". So move all the files from "folder/my-app" to "folder".
    Then running this might prompt some packages to install as shown in the next step.
### Step 3: 
```
    npx expo install react-dom react-native-web @expo/metro-runtime
```
    After installing this, try to run again:
```
    npm run web
```
    In Mac environment, there might be a warning like:
    Your macOS system limit does not allow enough watchers for Metro, install Watchman instead. Learn more: https://facebook.github.io/watchman/docs/install
    If it is the case, then install watchman: 
```
    brew install watchman
```
    After that you might need to restart the IDE to take effect. Then try again </>npm run web</>
    You should be able to see a line saying this in the browser:
    Open up App.js to start working on your app!
### Step 4:
    Just to confirm the handshakes, try changing App.js, just by adding some text like:
```
    <Text>This is my Hello World in RN!!!</Text>
```
    It should be reflected accordingly in browser.