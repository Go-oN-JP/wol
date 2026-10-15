# wol

[English](README-en.md)

Linux向けのシンプルな Wake-on-LAN コマンドラインツールです。

## 特徴

- ホスト名、番号、IPアドレスを指定して Wake-on-LAN パケットを送信
- 登録済みホストを番号付き一覧で表示
- ホスト名は省略可能

## 動作要件

- Bash
- `wakeonlan`

## インストール

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install wakeonlan
```

RHEL系ディストリビューションでは、パッケージのインストールコマンドの `apt` を `dnf` に置き換えてください。パッケージの提供状況は、ディストリビューションや有効なリポジトリによって異なります。

### スクリプトの配置

スクリプトを `/usr/local/bin/wol` に配置し、実行権限を付与してください。

```bash
sudo install -m 755 wol /usr/local/bin/wol
```

設定ファイルを作成します。

```bash
sudo mkdir -p /etc/wol
sudo nano /etc/wol/hosts
```

## 設定ファイル

設定ファイルは `/etc/wol/hosts` です。

1行につき1台のホストを記述し、項目は **IPアドレス、MACアドレス、ホスト名** の順に、空白で区切って指定します。ホスト名は省略できます。空行と `#` で始まるコメント行は無視されます。

```text
# IPアドレス       MACアドレス          ホスト名
192.168.131.106    7c:83:34:b9:32:a2    ia01
192.168.131.119    7c:83:34:aa:bb:cc
192.168.131.120    7c:83:34:aa:bb:dd    nas01
```

上記は設定例です。IPアドレスとMACアドレスは、実際の環境に合わせて変更してください。

## 使用方法

登録済みホストの一覧を表示します。

```bash
wol
```

ホスト名で指定します。

```bash
wol ia01
```

一覧に表示された番号で指定します。

```bash
wol 02
```

IPアドレスで指定します。

```bash
wol 192.168.131.119
```

## ライセンス

[LICENSE](LICENSE) を参照してください。
