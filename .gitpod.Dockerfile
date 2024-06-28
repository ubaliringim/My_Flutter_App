FROM gitpod/workspace-full

# Install Android SDK
RUN sudo apt-get update && sudo apt-get install -y openjdk-11-jdk
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip -O /tmp/cmdline-tools.zip
RUN unzip /tmp/cmdline-tools.zip -d $ANDROID_HOME/cmdline-tools
RUN mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest

# Install Flutter dependencies
RUN sudo apt-get install -y lib32stdc++6

# Set environment variables
ENV PATH=$PATH:/workspace/flutter/bin
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH=$PATH:$ANDROID_HOME/tools
ENV PATH=$PATH:$ANDROID_HOME/tools/bin
ENV PATH=$PATH:$ANDROID_HOME/platform-tools

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /workspace/flutter
RUN /workspace/flutter/bin/flutter precache

# Accept Android SDK licenses
RUN yes | /workspace/flutter/bin/flutter doctor --android-licenses
