FROM gitpod/workspace-full

# Install Java
RUN sudo apt-get update && sudo apt-get install -y openjdk-11-jdk

# Install Android SDK Command Line Tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip -O /tmp/cmdline-tools.zip && \
    sudo mkdir -p /usr/local/android-sdk/cmdline-tools && \
    sudo unzip /tmp/cmdline-tools.zip -d /usr/local/android-sdk/cmdline-tools && \
    sudo mv /usr/local/android-sdk/cmdline-tools/cmdline-tools /usr/local/android-sdk/cmdline-tools/latest

# Set environment variables for Android SDK
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $ANDROID_HOME/cmdline-tools/latest/bin:$PATH
ENV PATH $ANDROID_HOME/platform-tools:$PATH

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /workspace/flutter && \
    echo 'export PATH="$PATH:/workspace/flutter/bin"' >> /home/gitpod/.bashrc && \
    /workspace/flutter/bin/flutter precache

# Accept Android SDK licenses
RUN yes | /workspace/flutter/bin/flutter doctor --android-licenses
