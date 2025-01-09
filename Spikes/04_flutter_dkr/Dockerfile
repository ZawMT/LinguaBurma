FROM ubuntu:latest

# Switch to the root user to install packages
USER root

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk \
wget apt-transport-https ca-certificates software-properties-common fontconfig \
ca-certificates fontconfig libx11-dev libx11-6 libxcomposite1 libxdamage1 libxrandr2 \
libgl1 libnss3 libxtst6 libxss1 clang cmake ninja-build pkg-config libayatana-appindicator3-1 libgtk-3-dev

# Download the Google Chrome package
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install Google Chrome
RUN apt-get update && apt-get install -y \
    ./google-chrome-stable_current_amd64.deb

# Clean up unnecessary files
RUN rm google-chrome-stable_current_amd64.deb

# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer


# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
RUN unzip cmdline-tools.zip && rm cmdline-tools.zip
RUN mkdir -p Android/sdk/cmdline-tools/latest/
RUN mv cmdline-tools/* Android/sdk/cmdline-tools/latest/
RUN cd Android/sdk/cmdline-tools/latest/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/cmdline-tools/latest/bin && ./sdkmanager "build-tools;29.0.2" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor

# Expose port for Flutter web (optional)
EXPOSE 8080

# Set the default command to run flutter in Docker container
CMD ["bash"]