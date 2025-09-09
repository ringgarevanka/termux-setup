# Termux Setup

A comprehensive automated setup script for Termux that transforms your Android terminal into a fully-featured development environment with optional desktop capabilities.

## Overview

This script provides an interactive installation process that configures Termux with modern theming, development tools, and optionally a complete desktop environment. The setup is designed to work seamlessly on fresh Termux installations while providing flexibility for customization.

## Features

### Terminal Customization
- **JetBrains Mono Nerd Font** - Professional programming font with icon support
- **Tokyo Night Color Scheme** - Modern dark theme optimized for readability
- **Fastfetch System Information** - Comprehensive system info display with custom configuration
- **Enhanced Shell Environment** - Custom .bashrc with productivity-focused aliases

### Desktop Environment
- **XFCE4 Desktop Environment** - Complete Linux desktop experience
- **Termux:X11 Integration** - Seamless X11 server configuration
- **Hardware Acceleration** - VirGL renderer for optimal graphics performance
- **Pre-installed Applications** - Firefox browser and Visual Studio Code OSS
- **Audio Support** - PulseAudio configuration for desktop applications

### System Optimization
- **Automated Package Management** - System updates, upgrades, and cleanup routines
- **Storage Integration** - Configured access to Android filesystem
- **Performance Tuning** - Optimized settings for Android environment

## Installation

### Quick Install
```bash
wget -qO setup.sh https://raw.githubusercontent.com/ringgarevanka/termux-setup/refs/heads/main/setup.sh && bash setup.sh && rm setup.sh
```

### Manual Installation
```bash
wget https://raw.githubusercontent.com/ringgarevanka/termux-setup/refs/heads/main/setup.sh
chmod +x setup.sh
./setup.sh
```

## Configuration Options

The script provides interactive prompts for the following components:

### Core Components
- JetBrains Mono Nerd Font installation
- Tokyo Night color scheme application
- Fastfetch system information tool with custom layout
- Custom .bashrc configuration with aliases

### Optional Components
- XFCE4 desktop environment with supporting packages
- Desktop font configuration
- Fastfetch startup integration
- OS logo display in system information

## Desktop Environment Usage

After installing the desktop environment, use these commands:

```bash
startxfce    # Launch XFCE4 desktop
```

**Prerequisites**: Install Termux:X11 from Play Store or GitHub releases.

## Shell Aliases

The script configures the following productivity aliases:

```bash
cp='cp -rv'              # Verbose recursive copy
ls='ls --color=auto -ACF' # Colorized file listing
ll='ls -lhA'             # Detailed file listing
mv='mv -v'               # Verbose move operations
mkdir='mkdir -pv'        # Create parent directories
rf='rm -rf'              # Recursive force removal
wget='wget -c'           # Resume interrupted downloads
fhere="find . -name"     # Quick file search
..="cd .."               # Navigate up one directory
histg="history | grep"   # Search command history
```

## System Requirements

### Minimum Requirements
- Android 7.0 or higher
- Termux application installed
- 2GB available storage space
- Internet connection for package downloads

### Desktop Environment Additional Requirements
- Termux:X11 application
- 4GB available storage space (recommended)
- Device with sufficient RAM for desktop applications

## Best Practices

### Fresh Installation
For optimal results, use a fresh Termux installation:
- Execute `termux-reset` command, or
- Clear Termux application data through Android settings

The script automatically detects fresh installations and provides warnings for existing setups.

### Storage Permissions
Ensure Termux has appropriate storage permissions for:
- Font installation
- Configuration file management
- Desktop environment setup

## Troubleshooting

### Common Issues

**Script Execution Fails**
- Verify internet connectivity
- Ensure sufficient storage space
- Check Termux permissions

**Font Not Applied**
- Restart Termux application
- Verify font file: `ls ~/.termux/font.ttf`
- Confirm storage permissions granted

**Desktop Environment Problems**
- Install and update Termux:X11 application
- Grant required permissions to both applications
- Restart both Termux and Termux:X11

**Package Installation Errors**
- Update package repositories: `pkg update`
- Clear package cache: `pkg clean`
- Retry installation with stable internet connection

## Post-Installation

### Immediate Steps
1. Restart Termux to apply all configurations
2. Test system information display with `fastfetch`
3. Verify aliases functionality with `alias` command
4. Launch desktop environment if installed

### Verification
- Check font rendering in terminal
- Confirm color scheme application
- Test desktop environment functionality
- Validate custom aliases and shell configuration

## Technical Details

### Package Sources
- **Main Repository**: Official Termux packages
- **X11 Repository**: X11-related packages for desktop environment
- **TUR Repository**: Community-maintained packages

### Configuration Locations
- Font: `~/.termux/font.ttf`
- Colors: `~/.termux/colors.properties`
- Fastfetch: `~/fastfetch/config.jsonc`
- Shell: `~/.bashrc`
- Desktop Launcher: `~/.termux/.startxfce4`

## Contributing

Contributions are welcome through:
- Issue reports for bugs or enhancement requests
- Pull requests with improvements or fixes
- Documentation updates and clarifications

## This repository doesn't have LICENSE, just please add credits to this repository.

---

For support, issues, or feature requests, please visit the project repository.
