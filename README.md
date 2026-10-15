# wol

[English](README-en.md)

設定ファイルに登録したホストに対して、Wake-on-LAN（WoL）パケットを送信する Bash スクリプトです。

## 特徴

- ホスト名、番号、IPアドレスによる送信先の指定
- ホスト名の大文字・小文字を区別しない検索
- 設定ファイルの入力チェック
- Debian/Ubuntu および RPM 系ディストリビューション向けインストーラー
- 既存の設定ファイルを保持したまま再インストール可能

## 対応環境

- Debian / Ubuntu
- Fedora / RHEL / Rocky Linux / AlmaLinux / Oracle Linux などの RPM 系ディストリビューション

Bash、curl、wakeonlan を使用します。curl と wakeonlan はインストーラーが導入します。

## インストール

### Debian / Ubuntu

```bash
curl -fsSLO https://raw.githubusercontent.com/Go-oN-JP/wol/main/install-deb.sh
sudo bash install-deb.sh
```

### RPM 系ディストリビューション

```bash
curl -fsSLO https://raw.githubusercontent.com/Go-oN-JP/wol/main/install-rpm.sh
sudo bash install-rpm.sh
```

`wakeonlan` のインストールに失敗する場合は、対象ディストリビューションに対応したリポジトリを追加・有効化したうえで、インストーラーを再実行してください。

インストール後、実行ファイルは `/usr/local/bin/wol` に配置され、設定ファイル `/etc/wol/hosts` が作成されます。

既存の `/etc/wol/hosts` がある場合、その内容は上書きされません。

## 設定

`/etc/wol/hosts` を編集し、送信先のホストを1行ずつ登録します。

```text
# IPアドレス       MACアドレス          ホスト名
192.168.131.106    7c:83:34:b9:32:a2    ia01
192.168.131.119    7c:83:34:aa:bb:cc
192.168.131.120    7c:83:34:aa:bb:dd    nas01
```

各行の形式は次のとおりです。

```text
IP_ADDRESS MAC_ADDRESS [HOSTNAME]
```

- IPアドレス：送信先ホストの IPv4 アドレス
- MACアドレス：送信先ネットワークインターフェースの MAC アドレス
- ホスト名：任意。省略できます
- 空行と `#` で始まるコメント行は無視されます

設定ファイルの編集には、例えば次のコマンドを使用できます。

```bash
sudoedit /etc/wol/hosts
```

## 使い方

### ホスト一覧の表示

```bash
wol
```

登録済みのホストを番号、ホスト名、IPアドレス、MACアドレスとともに表示します。ホスト名が省略されている場合も、一覧の列はずれません。

### ホスト名で指定

```bash
wol ia01
```

ホスト名は大文字・小文字を区別しません。

```bash
wol IA01
```

### 番号で指定

```bash
wol 9
wol 09
```

一覧に表示された番号で送信先を指定できます。先頭のゼロは省略可能です。

### IPアドレスで指定

```bash
wol 192.168.131.106
```

### エラーについて

- 未登録のホスト名・IPアドレスを指定した場合はエラーになります。
- 登録されているホスト数の範囲外の番号を指定した場合はエラーになります。
- 設定ファイルに不正な行がある場合は、修正が必要な行番号を表示して終了します。

## ライセンス

[MIT License](LICENSE)

Copyright (c) 2026 Go-oN株式会社
