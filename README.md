# Termux Setup (Core)

A core (lightweight/basic) version of Termux Setup. an automated bash script for Setup your Termux App.

## Overview

This automated lightweight/basic bash script to setup Termux.

## Features

### Terminal Customization
- **JetBrains Mono Nerd Font** - Font with icon support
- **Enhanced Shell Environment** - Custom .bashrc with aliases

### System Optimization
- **Automated Package Management** - System updates, upgrades, and cleanup routines

## Installation

```bash
wget -qO setup.sh https://raw.githubusercontent.com/ringgarevanka/termux-setup/refs/heads/core/setup.sh && bash setup.sh && rm setup.sh
```
or

```bash
wget https://raw.githubusercontent.com/ringgarevanka/termux-setup/refs/heads/core/setup.sh
chmod +x setup.sh
./setup.sh
```
## System Requirements

### Minimum Requirements
- Android 7.0 or higher
- Termux application installed
- 2GB available storage space
- Stable Internet connection for package downloads

## Troubleshooting

### Common Issues

**Script Execution Fails**
- Verify internet connectivity
- Ensure sufficient storage space
- Check Termux permissions

**Font Not Applied**
- Restart Termux application
- Verify font file: `file $HOME/.termux/font.ttf`
- Confirm storage permissions granted

**Package Installation Errors**
- Update package repositories: `pkg update`
- Clear package cache: `pkg clean`
- Retry installation with stable internet connection

## Post-Installation

### Immediate Steps
1. Restart Termux to apply all configurations

### Verification
- Check font rendering in terminal
- Validate custom aliases and shell configuration

## Technical Details

### Package Sources
- **Main Repository**: Official Termux packages

### Configuration Locations
- Font: `~/.termux/font.ttf`
- Shell: `~/.bashrc`

## Contributing

Contributions are welcome through:
- Issue reports for bugs or enhancement requests
- Pull requests with improvements or fixes
- Documentation updates and clarifications

## This repository doesn't have LICENSE, just please add credits to this repository.

---

For support, issues, or feature requests, please visit the project repository.
