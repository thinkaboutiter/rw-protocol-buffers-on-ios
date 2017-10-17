#!/bin/bash

# Functions

# Pip is a package management system used to install and manage software packages written in Python.
installPip() {
  hasPip=$( pip --version )
  if (( $? == 0 )); then # Check if pip is already installed.
    echo "pip already exist"
  else
    echo "...Enter Admin Password if Needed..."
    sudo easy_install pip # Install pip
  fi
}

# Use pip command to install the Flask framework. Flask is a microframwork that you will use to build a local server for simple GET/POST Requests.
installFlask() {
  hasPip=$( flask --help )
  if (( $? == 0 )); then # Check to see if flask is installed
    echo "flask already exists"
  else
    echo "...Enter Admin Password if Needed..."
    sudo pip install Flask # Install Flask
  fi
}

# Check to see if python's protocol buffer module is installed
installPythonProtobufModule() {
  hasModule=$( python -c "import google.protobuf" )
  if (( $? == 0)); then
    echo "Module already exists"
  else
    echo "May need to enter admin password to install python protobuf module."
    sudo -H pip install protobuf --ignore-installed six
  fi
}

# Checks to see if the right version of protocol buffer is installed
checkProtocolBufferCompilerVersion() {
  version1=$(protoc --version)
  version2="libprotoc 3.1.0"
  if [[ $version1 == $version2 ]]; then
  isRightVersion=true
  else
  isRightVersion=false
  fi
}

# Installs the Google Protocol Buffer compiler.
installGoogleProtocolCompiler() {
  cd ./protobuf-3.1.0/
  ./configure
  make
  make check
  sudo make install
  sudo ldconfig # refresh shared library cache.
}

# Attempts to install the google protocol compiler by checking to see if it's already installed, and if the right version is installed.
attemptGoogleProtocolCompilerInstallation() {
  hasProtobuf=$( protoc --version )
  if (( $? == 0 )); then # check to see if the compiler is installed
    echo "protobuf already exist"
    echo "Check for right version of protoc compiler, Should be libprotoc 3.1.0"
    checkProtocolBufferCompilerVersion
    if (( $isRightVersion == 0 )); then
      echo "The right version is installed!"
    else
      installGoogleProtocolCompiler
    fi
  else
    installGoogleProtocolCompiler
  fi
}

echo "--- Installing Python Server-side framework ---"

echo "Attempt to install pip if needed."
installPip

echo "Attempt to install flask if needed"
installFlask

echo "--- Installing Swift Protocol Buffer Plugin ---"
echo "...Enter Admin Password if Needed... to copy protoc-gen-swift"
sudo yes | cp -rf protoc-gen-swift /usr/local/bin #Copy swift protoc generator plugin to a directory path that is executable.

echo "--- Installing Google Protocol Buffer Library ---"
echo "Attempt to install Google Compiler"
attemptGoogleProtocolCompilerInstallation

echo "Attempt to Install protobuf module in python"
installPythonProtobufModule
