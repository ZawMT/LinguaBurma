# Creating a basic react-native app using Docker
    The app is created and run in Docker.

## Steps to create and run the app in Docker
### Prerequesite:
    Environment is ready to use Docker. Docker must be up and running.

    Do not run the command right away! Before trying each step, read the full info first. 
### Step 1:
    Create the docker image using the command below. Use the content of Dockerfile_01 as / in the Dockerfile.
```
    docker-compose build
```
    Only the image is created. It is not launched to run as a container yet.
    Check and confirm that the iamge is created, and then install expo
### Step 2:
    Then create the app by running the command "npx create-expo-app --template blank" in the image as follows:
```
    docker run -it -v ./:/usr/src/app/ rn_app:latest npx expo install react-dom react-native-web @expo/metro-runtime
```
    The current project directory is mapped to '/usr/src/app' of the image as well, so the files can be accessed in the host.
    Logically the application should be able to call by running "npm run --web" in the container.
    But first, we need to run this: npx expo install react-dom react-native-web @expo/metro-runtime.
    To run that command, the working directory should be the newly created project folder.
    So, firstly, delete the current image and copy the content of Dockerfile_02 into the Dockerfile.
    And then recreate the docker image as in the following step.
### Step 3: 
```
    docker-compose build --no-cache rn_app  
```
    This will recreate a new container according to the Dockerfile and docker-compose.yml. However, the mapped volume (and the content - the generated files) will still be there.
    Now the docker container can be launched:
```
    docker-compose up
```
    Then go to http://localhost:8081
    You should be able to see a line saying this in the browser:
    Open up App.js to start working on your app!
### Step 4:
    Just to confirm the handshakes, try changing App.js in local, just by adding some text like:
```
    <Text>Running Recat Native in Docker!!!</Text>
```
    It should be reflected accordingly in browser.