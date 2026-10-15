# wol

[日本語](README.md)

A simple Wake-on-LAN command-line utility for Linux.

## Features

- Send Wake-on-LAN magic packets using a hostname, index number, or IP address.
- Display configured hosts in a numbered list.
- Hostnames are optional.

## Requirements

- Bash
- `wakeonlan`

## Installation

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install wakeonlan
```

For RHEL-based distributions, replace `apt` with `dnf` in the package installation command. Package availability may vary depending on the distribution and enabled repositories.

### Install the script

Place the script at `/usr/local/bin/wol` and make it executable.

```bash
sudo install -m 755 wol /usr/local/bin/wol
```

Create the configuration file.

```bash
sudo mkdir -p /etc/wol
sudo nano /etc/wol/hosts
```

## Configuration

The configuration file is `/etc/wol/hosts`.

Add one host per line, with fields separated by whitespace in the following order: **IP address, MAC address, hostname**. The hostname is optional. Blank lines and comment lines beginning with `#` are ignored.

```text
# IP address       MAC address          Hostname
192.168.131.106    7c:83:34:b9:32:a2    ia01
192.168.131.119    7c:83:34:aa:bb:cc
192.168.131.120    7c:83:34:aa:bb:dd    nas01
```

These are example entries. Replace the IP and MAC addresses with values for your own network.

## Usage

List configured hosts:

```bash
wol
```

Specify a host by hostname:

```bash
wol ia01
```

Specify a host by its number in the list:

```bash
wol 02
```

Specify a host by IP address:

```bash
wol 192.168.131.119
```

## License

See [LICENSE](LICENSE).

