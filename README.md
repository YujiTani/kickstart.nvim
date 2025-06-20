# kickstart.nvim

## はじめに

Neovimのスタートポイントとなる設定です：

* 軽量
* 単一ファイル
* 完全にドキュメント化済み

Neovimのディストリビューションでは**ありません**が、あなたの設定の出発点となります。

## インストール

### Neovimのインストール

Kickstart.nvimは、Neovimの最新の
['stable'](https://github.com/neovim/neovim/releases/tag/stable)版と最新の
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly)版のみをサポートしています。
問題が発生した場合は、最新版を使用していることを確認してください。

### 外部依存関係のインストール

必要な外部ツール：
- 基本ユーティリティ：`git`, `make`, `unzip`, Cコンパイラ (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- クリップボードツール（プラットフォームに応じてxclip/xsel/win32yankなど）
- [Nerd Font](https://www.nerdfonts.com/)：オプション、様々なアイコンを提供
  - インストールした場合は `init.lua` で `vim.g.have_nerd_font` を true に設定
- 言語設定：
  - Typescriptを書く場合は `npm` が必要
  - Golangを書く場合は `go` が必要
  - など

> **注意**
> WindowsとLinux特有の注意事項とクイックインストールスニペットについては、[インストールレシピ](#Install-Recipes)を参照してください

### Kickstartのインストール

> **注意**
> 既存の設定がある場合は、事前に[バックアップ](#FAQ)を取ってください

NeovimのOS別設定パス：

| OS | パス |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### 推奨手順

このリポジトリを[フォーク](https://docs.github.com/en/get-started/quickstart/fork-a-repo)して、
自分が変更できるコピーを作成し、OSに応じて以下のコマンドのいずれかを使用してフォークをマシンにクローンしてインストールします。

> **注意**
> フォークのURLは以下のようになります：
> `https://github.com/<your_github_username>/kickstart.nvim.git`

フォークの `.gitignore` ファイルから `lazy-lock.json` を削除することをお勧めします。
kickstartリポジトリではメンテナンスを簡単にするために無視していますが、
[バージョン管理で追跡することが推奨されています](https://lazy.folke.io/usage/lockfile)。

#### kickstart.nvimのクローン
> **注意**
> 上記の推奨手順（リポジトリのフォーク）に従う場合は、
> 以下のコマンドで `nvim-lua` を `<your_github_username>` に置き換えてください

<details><summary> Linux と Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

`cmd.exe` を使用している場合：

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

`powershell.exe` を使用している場合：

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### インストール後の設定

Neovimを起動：

```sh
nvim
```

以上です！Lazyがすべてのプラグインをインストールします。`:Lazy` で現在の
プラグインステータスを表示できます。`q` でウィンドウを閉じます。

Neovimの拡張と探索について詳しくは、設定フォルダ内の `init.lua` ファイルを
読んでください。よく要求されるプラグインの追加例も含まれています。


### はじめ方

[Neovimを始めるために必要な唯一のビデオ](https://youtu.be/m8C0Cq9Uv9o)

### よくある質問（FAQ）

* 既存のNeovim設定がある場合はどうすればよいですか？
  * バックアップを取ってから、関連するすべてのファイルを削除してください。
  * これには既存の init.lua と `~/.local` 内のneovimファイルが含まれ、
    `rm -rf ~/.local/share/nvim/` で削除できます
* kickstartと並行して既存の設定を保持できますか？
  * はい！[NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    を使用して複数の設定を維持できます。例えば、kickstart設定を `~/.config/nvim-kickstart` に
    インストールしてエイリアスを作成できます：
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    `nvim-kickstart` エイリアスを使用してNeovimを実行すると、代替設定ディレクトリと
    対応するローカルディレクトリ `~/.local/share/nvim-kickstart` が使用されます。
    この方法は試したいNeovimディストリビューションに適用できます。
* この設定を「アンインストール」したい場合は？
  * [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling)の情報を参照してください
* なぜkickstartの `init.lua` は単一ファイルなのですか？複数ファイルに分割する方が良いのでは？
  * kickstartの主な目的は、学習ツールおよび誰でも簡単に `git clone` して
    自分のベースとして使用できる参考設定として機能することです。
    NeovimとLuaの学習が進むにつれて、`init.lua` を小さな部分に分割することを
    検討するかもしれません。同じ機能を維持しながらこれを行うkickstartのフォークが
    こちらで利用できます：
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * このトピックに関する議論はこちらで見つけることができます：
    * [設定の再構築](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [init.luaをマルチファイル設定に再編成](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### インストールレシピ

以下では、Neovimと依存関係のOS固有のインストール手順を確認できます。

すべての依存関係をインストールした後、[Kickstartのインストール](#Install-Kickstart)ステップに進んでください。

#### Windows インストール

<details><summary>Microsoft C++ Build ToolsとCMakeを使用するWindows</summary>
インストールにはビルドツールのインストールと `telescope-fzf-native` の実行コマンドの更新が必要な場合があります

詳細については `telescope-fzf-native` のドキュメント[こちら](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)を参照してください

これには以下が必要です：

- WindowsにCMakeとMicrosoft C++ Build Toolsをインストール

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>chocolateyを使用してgcc/makeを使用するWindows</summary>
または、設定の変更を必要としないgccとmakeをインストールできます。
最も簡単な方法はchocoを使用することです：

1. [chocolatey](https://chocolatey.org/install)をインストール
   ページの指示に従うかwingetを使用し、
   **管理者として**cmdで実行：
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. chocoを使用してすべての要件をインストール。前のcmdを終了し、
   chocoのパスが設定されるように新しいものを開き、**管理者として**cmdで実行：
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux インストール
<details><summary>Ubuntu インストール手順</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian インストール手順</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# nvimをインストール
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# /usr/local/binで利用可能にする（ディストリビューションは/usr/binにインストール）
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora インストール手順</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch インストール手順</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

