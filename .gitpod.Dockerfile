FROM gitpod/workspace-full

# Install Java
RUN sudo apt-get update && sudo apt-get install -y openjdk-11-jdk

# Install Android SDK Command Line Tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip -O /tmp/cmdline-tools.zip && \
    sudo mkdir -p /usr/local/android-sdk/cmdline-tools && \
    sudo unzip /tmp/cmdline-tools.zip -d /usr/local/android-sdk/cmdline-tools && \
    sudo mv /usr/local/android-sdk/cmdline-tools/cmdline-tools /usr/local/android-sdk/cmdline-tools/latest

# Set environment variables for Android SDK
ENV ANDROID_HOME=/usr/local/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /workspace/flutter && \
    echo 'export PATH="$PATH:/workspace/flutter/bin"' >> /home/gitpod/.bashrc && \
    /workspace/flutter/bin/flutter precache

# Accept Android SDK licenses
RUN yes | /workspace/flutter/bin/flutter doctor --android-licenses

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb

# Set Chrome environment variable
ENV CHROME_EXECUTABLE=/usr/bin/google-chrome

# Install GTK 3.0 Libraries
RUN sudo apt-get install -y libgtk-3-dev
