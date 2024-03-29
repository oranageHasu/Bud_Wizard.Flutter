# Stage 1 "build stage", this is used for building the front end
FROM ubuntu:18.04 as build-stage

ARG BASE_URL="https://localhost:9000/api/v1/"

# Specifiy some Flutter environment paths
ENV PATH=/opt/flutter/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/flutter/.pub-cache/bin

# Install/update Ubuntu essentials required to install Flutter
RUN apt-get update && \
    apt-get install -y \
        xz-utils \
        git \
        openssh-client \
        curl && \
    apt-get upgrade -y && \
    rm -rf /var/cache/apt

# Download and install Flutter + essential tools
RUN curl -L https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_1.24.0-10.2.pre-beta.tar.xz | tar -C /opt -xJ
RUN apt-get install -y lib32stdc++6
RUN apt-get install unzip

# Set the working directory
WORKDIR /app

# Copy over the Flutter project
COPY ./ ./

# Upgrade Flutter
RUN flutter doctor
#RUN flutter upgrade
RUN flutter packages pub global activate webdev
RUN flutter packages upgrade

# Make sure flutter is configured for web (it was in beta at the time of writing this Dockerfile)
RUN flutter config --enable-web

# Get all Flutter dependencies for this project
RUN flutter pub get

# This builds the pubspec.dart file which is located within our app source code and located here: /lib/src/pubspec.dart
# This file allows us to infer information about a Flutter Web App (web apps are a special case compared to mobile apps)
RUN flutter pub run build_runner build

# Build the Flutter app as a Web App
RUN flutter build web --dart-define=BASE_URL=$BASE_URL

# Stage 2 Nginx
# This is a Nginx docker image with Brotli/ModSecurity/OWASP ModSecurity Core Rule Set (CRS)
# See: https://hub.docker.com/r/krish512/modsecurity/
FROM krish512/modsecurity

WORKDIR /root/

ARG CERTIFICATEFILE="localhost.crt"
ARG CERTIFICATEKEY="localhost.key"
ARG NGINXCONF="nginx.conf"

# Expose ports for Flutter
EXPOSE 9001

# Copy the ES5 bundle from the build stage to Nginx
COPY --from=build-stage /app/build/web /usr/share/nginx/html

# Copy the nginx configuration file provided in the Dominic project itself
COPY --from=build-stage /app/$NGINXCONF /etc/nginx/conf.d/default.conf

# Copy the SSL Certificate provided within the Dominic project itself
COPY --from=build-stage /app/$CERTIFICATEFILE /etc/nginx/ssl/$CERTIFICATEFILE

# Copy the SSL Key provided within the Dominic project itself
COPY --from=build-stage /app/$CERTIFICATEKEY /etc/nginx/ssl/$CERTIFICATEKEY

# Copy the Diffie-Hellman certificate (for TLS) provided within the Dominic project itself
COPY --from=build-stage /app/dhparams.pem /etc/nginx/ssl/dhparams.pem