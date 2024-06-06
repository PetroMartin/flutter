# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How to install flutter

Follow these steps to install Flutter on your system:

Prerequisites
Operating System: Windows, macOS, or Linux.
Disk Space: 2.8 GB (does not include disk space for IDE/tools).
Tools: Flutter requires Git for installation and use. Get Git from git-scm.com.
Installation Steps
### Windows
Download Flutter SDK:

Visit the Flutter official website and download the latest stable version of the Flutter SDK for Windows.
Extract Flutter:

Extract the downloaded .zip file and place the flutter directory in a suitable location, such as C:\src\flutter.
Add Flutter to PATH:

Open the Start Search, type in env, and select Edit environment variables for your account.
Under User variables, find the PATH variable, and add the path to the flutter\bin directory, for example, C:\src\flutter\bin.
Install Dependencies:

Run flutter doctor in the command prompt to see if there are any additional dependencies that need to be installed. Follow the on-screen instructions.
### macOS
Download Flutter SDK:

Visit the Flutter official website and download the latest stable version of the Flutter SDK for macOS.
Extract Flutter:

Extract the downloaded .tar.xz file and move the flutter directory to a suitable location, such as $HOME/development.
Add Flutter to PATH:

Open a terminal and run the following command to add Flutter to your PATH:
sh
```bash
$ export PATH="$PATH:`pwd`/flutter/bin"
```

To make this change permanent, add the above line to your .bashrc, .zshrc, or .bash_profile.
Install Dependencies:

Run flutter doctor in the terminal to check for and install additional dependencies.
```bash
$  flutter doctor
```
### Linux
Download Flutter SDK:

Visit the Flutter official website and download the latest stable version of the Flutter SDK for Linux.
Extract Flutter:

Extract the downloaded .tar.xz file and place the flutter directory in a suitable location, such as $HOME/development.
Add Flutter to PATH:

Open a terminal and run the following command to add Flutter to your PATH:
sh
```bash
$ export PATH="$PATH:`pwd`/flutter/bin"
```
To make this change permanent, add the above line to your shell’s configuration file (e.g., .bashrc or .zshrc).
Install Dependencies:

Run flutter doctor in the terminal to check for and install additional dependencies.

Verify Installation
To ensure Flutter is correctly installed, run:
```bash
$  flutter doctor
```
This command checks your environment and displays a report of the status of your Flutter installation. Ensure all checks are successful to proceed with Flutter development.

Additional Setup
IDE: Install Android Studio or Visual Studio Code with the Flutter and Dart plugins for a better development experience.
Android Setup: For Android development, ensure you have an Android emulator or a physical device connected and set up.
For more detailed instructions, visit the official Flutter installation guide.
