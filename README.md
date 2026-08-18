# Discord Drover (Proxy Settings for Discord)

Discord Drover is a program that forces the Discord application for Windows to route its TCP connections (chat, updates) through Tor. This may be necessary because the original Discord application lacks proxy settings, and the global system proxy is also not used.

Additionally, the program slightly modifies Discord's outgoing UDP traffic, which helps bypass some local restrictions on voice chats.

The program works locally at the specific process level (without drivers) and does not affect the operating system globally. This approach serves as an alternative to using a global VPN (such as TUN interfaces and others).

## Installation

The latest version of the program can be downloaded from the [latest release page](https://github.com/hdrover/discord-drover/releases/latest).

### Automatic Installation

For an easier setup, use the included installer `drover.exe`. Run the program, set the path to your Tor executable, then click **Install** to automatically place the necessary files in the correct folder.

The installer defaults to `socks5://127.0.0.1:9050`, which is the standard local SOCKS5 port used by Tor Browser and the standalone Tor daemon. If Tor Browser is installed, the default path is detected automatically.

To uninstall the program and remove all associated files, run `drover.exe` again and click **Uninstall**.

### Manual Installation

If you prefer manual installation, copy the `version.dll` and `drover.ini` files into the folder containing the `Discord.exe` file (not `Update.exe`). The proxy is specified in the `drover.ini` file under the `proxy` parameter, and the path to the Tor executable under the `tor` parameter.

### Example `drover.ini` Configuration:

```ini
[drover]
; SOCKS5 proxy pointing to local Tor (default)
proxy = socks5://127.0.0.1:9050
; Path to the Tor executable
tor = "C:\Users\User\Desktop\Tor Browser\Browser\TorBrowser\Tor\tor.exe"
```

- **proxy**: Defines the proxy server used for Discord's TCP connections. Defaults to the local Tor SOCKS5 port (`127.0.0.1:9050`). Change to `9150` if using Tor Browser's alternate port.
- **tor**: Path to the `tor.exe` executable. Used by the installer to locate and optionally launch Tor.

## Features

- Forces Discord to route TCP connections through Tor (SOCKS5 on `127.0.0.1:9050` by default).
- Slight interference with UDP traffic for bypassing voice chat restrictions.
- No drivers or system-level modifications are required.
- Works locally at the process level, offering an alternative to global VPN solutions.
- Supports Discord Canary and PTB versions in addition to the main version.

## Optional `drover-packet.bin`

If a `drover-packet.bin` file is present, its contents are sent at the start of each new outgoing UDP connection, before the built-in UDP manipulation. This can help bypass voice chat restrictions on networks where the built-in manipulation alone is not enough.

The file is re-read before every new connection, so its contents can be edited or replaced while Discord is running. There is no need to restart Discord to try a different packet; starting a new voice connection is enough.

The file is optional. The built-in UDP manipulation is always performed. `drover-packet.bin` only adds an extra payload before it.
