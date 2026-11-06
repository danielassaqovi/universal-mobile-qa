FROM ghcr.io/cirruslabs/flutter:stable
RUN apt-get update && apt-get install -y adb openjdk-17-jdk docker-compose-plugin && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY pubspec.yaml ./
RUN flutter pub get
COPY . .
ENTRYPOINT ["dart","run","bin/mobileqa.dart"]
