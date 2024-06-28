image:
  file: .gitpod.Dockerfile

tasks:
  - name: Install Flutter
    init: |
      git clone https://github.com/flutter/flutter.git -b stable --depth 1 /workspace/flutter
      echo 'export PATH="$PATH:/workspace/flutter/bin"' >> ~/.bashrc
      source ~/.bashrc
      flutter precache

  - name: Install Android SDK
    init: |
      sudo apt-get update
      sudo apt-get install -y openjdk-11-jdk
      wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip -O /tmp/cmdline-tools.zip
      sudo mkdir -p /usr/local/android-sdk/cmdline-tools
      sudo unzip /tmp/cmdline-tools.zip -d /usr/local/android-sdk/cmdline-tools
      sudo mv /usr/local/android-sdk/cmdline-tools/cmdline-tools /usr/local/android-sdk/cmdline-tools/latest
      echo 'export ANDROID_HOME=/usr/local/android-sdk' >> ~/.bashrc
      echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.bashrc
      echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.bashrc
      echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.bashrc
      echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc
      source ~/.bashrc
      yes | flutter doctor --android-licenses

  - name: Verify Flutter Installation
    command: flutter doctor

ports:
  - port: 3000
    onOpen: open-preview

vscode:
  extensions:
    - Dart-Code.flutter
