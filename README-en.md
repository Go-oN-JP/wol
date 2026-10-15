# wol

[日本語](README.md)

A Bash script that sends Wake-on-LAN (WoL) packets to hosts registered in a configuration file.

## Features

- Select hosts by hostname, list number, or IP address
- Case-insensitive hostname matching
- Configuration file validation
- Installers for Debian/Ubuntu and RPM-based distributions
- Reinstallation without overwriting an existing configuration file

## Supported Environments

- Debian / Ubuntu
- RPM-based distributions, including Fedora, RHEL, Rocky Linux, AlmaLinux, and Oracle Linux

The script requires Bash, curl, and wakeonlan. The installer installs curl and wakeonlan.

## Installation

### Debian / Ubuntu

```bash
curl -fsSLO https://raw.githubusercontent.com/Go-oN-JP/wol/main/install-deb.sh
sudo bash install-deb.sh
```

### RPM-based distributions

```bash
curl -fsSLO https://raw.githubusercontent.com/Go-oN-JP/wol/main/install-rpm.sh
sudo bash install-rpm.sh
```

If `wakeonlan` cannot be installed, add or enable a repository appropriate for your distribution and run the installer again.

After installation, the executable is placed at `/usr/local/bin/wol`, and the configuration file `/etc/wol/hosts` is created.

If `/etc/wol/hosts` already exists, its contents are preserved.

## Configuration

Edit `/etc/wol/hosts` and add one host per line.

```text
# IP address       MAC address          Hostname
192.168.131.106    7c:83:34:b9:32:a2    ia01
192.168.131.119    7c:83:34:aa:bb:cc
192.168.131.120    7c:83:34:aa:bb:dd    nas01
```

The format is:

```text
IP_ADDRESS MAC_ADDRESS [HOSTNAME]
```

- IP address: IPv4 address of the target host
- MAC address: MAC address of the target network interface
- Hostname: Optional; it may be omitted
- Blank lines and comment lines beginning with `#` are ignored

For example, edit the configuration file with:

```bash
sudoedit /etc/wol/hosts
```

## Usage

### List configured hosts

```bash
wol
```

Displays the registered hosts with their list numbers, hostnames, IP addresses, and MAC addresses. The columns remain aligned even when a hostname is omitted.

### Select by hostname

```bash
wol ia01
```

Hostname matching is case-insensitive.

```bash
wol IA01
```

### Select by list number

```bash
wol 9
wol 09
```

Select a host using its number in the list. Leading zeros are optional.

### Select by IP address

```bash
wol 192.168.131.106
```

### Errors

- An unregistered hostname or IP address results in an error.
- An index outside the range of configured hosts results in an error.
- If the configuration file contains invalid entries, the script reports the affected line numbers and exits.

## License

[MIT License](LICENSE)

Copyright (c) 2026 Go-oN Co., Ltd.
