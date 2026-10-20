# dotfiles

## Cisco VPN

Run the [Cisco VPN AppleScript](scripts/connect-cisco-vpn.applescript):

```sh
osascript ~/work/dotfiles/scripts/connect-cisco-vpn.applescript
```

It finds Cisco Secure Client (or legacy AnyConnect), opens it, and clicks
**Connect** using the currently selected VPN server. Configure the server in
Cisco first. Complete any password, SSO, or MFA prompts yourself; the script
does not store credentials or confirm that the connection succeeded.

Allow the app running the script (Terminal, Script Editor, etc.) under
**System Settings → Privacy & Security → Accessibility**, and allow Automation
access to System Events if prompted. The script expects English button labels
and leaves an existing connection untouched.

## Installation

### MacOS

1. Download and install [1Password](https://1password.com/downloads/mac).
2. Open App Store application and sign in.
3. Run Installation script

```sh
/bin/bash -c "$(curl -s https://raw.githubusercontent.com/RomiC/dotfiles/master/install.sh)"
```
