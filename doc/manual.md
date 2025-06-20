# Neovim設定解説書

## 概要
この設定は **Kickstart.nvim** をベースとした Neovim の設定で、モダンな開発環境を提供します。
- **init.lua:1-85**: Kickstart.nvim のイントロダクション
- **使用パッケージマネージャ**: lazy.nvim

## 基本設定

### リーダーキー
- **リーダーキー**: `<Space>` (init.lua:90-91)
- **ローカルリーダーキー**: `<Space>`

### 基本オプション (init.lua:96-169)
- **行番号表示**: `vim.opt.number = true`
- **文字エンコーディング**: UTF-8 (init.lua:108-110)
- **スワップファイル**: 無効 (init.lua:113)
- **マウス有効**: `vim.opt.mouse = 'a'`
- **クリップボード連携**: OS のクリップボードと同期 (init.lua:125-127)
- **インデント**: `breakindent` 有効
- **検索**: 大文字小文字を区別しない、賢い検索 (init.lua:135-137)
- **カーソル**: `guicursor = 'n-i:ver25'` (init.lua:165)
- **スクロール**: 最低10行のマージン (init.lua:168)

### キーマップ設定

#### 基本キーマップ (init.lua:170-203)
- **`<Esc>`**: 検索ハイライトをクリア
- **`<leader>q`**: 診断リストを開く
- **`<Esc><Esc>`**: ターミナルモードから抜ける
- **方向キー**: 使用を制限 (`hjkl` の使用を促す)
- **`<C-hjkl>`**: ウィンドウ間の移動

#### LSP キーマップ (init.lua:422-454)
- **`gd`**: 定義へジャンプ
- **`gr`**: 参照を検索
- **`gI`**: 実装へジャンプ
- **`<leader>D`**: 型定義へジャンプ
- **`<leader>ds`**: ドキュメントシンボル検索
- **`<leader>ws`**: ワークスペースシンボル検索
- **`<leader>rn`**: リネーム
- **`<leader>ca`**: コードアクション
- **`<leader>th`**: インレイヒント切り替え

## プラグイン構成

### 必須プラグイン (init.lua:241-244)
1. **vim-sleuth**: タブ幅を自動検出

### Git統合 (init.lua:257-268)
**gitsigns.nvim** - Git の変更を視覚的に表示
- **git signs**: `+` (追加), `~` (変更), `_` (削除)
- **追加設定**: `lua/custom/plugins/init.lua` でカスタマイズ

### キーバインド表示 (init.lua:285-337)
**which-key.nvim** - キーバインドのヘルプ表示
- **グループ定義**:
  - `<leader>c`: コード関連
  - `<leader>d`: ドキュメント
  - `<leader>s`: 検索
  - `<leader>w`: ワークスペース
  - `<leader>t`: トグル

### LSP設定 (init.lua:347-572)
**nvim-lspconfig** + **Mason**
- **自動インストール**: LSP サーバーの自動管理
- **有効な LSP**: lua_ls (Lua Language Server)
- **ツール**: stylua (Lua フォーマッター)

### フォーマッター (init.lua:574-615)
**conform.nvim** - コードフォーマット
- **保存時フォーマット**: 有効
- **`<leader>f`**: 手動フォーマット

### 補完機能 (init.lua:617-731)
**nvim-cmp** + **LuaSnip**
- **補完ソース**: LSP, path, luasnip, lazydev
- **キーマップ**:
  - `<C-n>`: 次の項目
  - `<C-p>`: 前の項目
  - `<C-y>`: 選択確定
  - `<C-l>/<C-h>`: スニペット移動

### テーマ設定 (init.lua:733-749)
**tokyonight.nvim** - カラースキーム
- **デフォルト**: `tokyonight-night`
- **追加テーマ**: gruvbox も利用可能 (colorscheme.lua)

### 追加機能プラグイン

#### mini.nvim (init.lua:755-790)
- **mini.ai**: テキストオブジェクト拡張
- **mini.surround**: 囲み文字の操作
- **mini.statusline**: ステータスライン

#### Treesitter (init.lua:791-815)
**nvim-treesitter** - シンタックスハイライト
- **対応言語**: bash, c, diff, html, lua, markdown, vim

#### ファジーファインダー (telescope.lua)
**telescope.nvim** - ファイル・テキスト検索
- **`<leader>sf`**: ファイル検索
- **`<leader>sg`**: 文字列検索
- **`<leader>sh`**: ヘルプ検索
- **`<leader>sk`**: キーマップ検索
- **`<leader><leader>`**: バッファ一覧

#### ファイルエクスプローラー (neo-tree.lua)
**neo-tree.nvim** - ファイルツリー
- **`<leader>e`**: ファイルツリー表示

#### ターミナル統合 (toggleterm.lua)
**toggleterm.nvim** - フローティングターミナル
- **`<leader>tt`**: ターミナル表示切り替え
- **`<leader>lg`**: lazygit 起動
- **設定**: フローティングモード、curved border

#### その他のプラグイン
- **nvim-autopairs**: 括弧の自動補完 (autopairs.lua)
- **todo-comments.nvim**: TODOコメントのハイライト
- **lazydev.nvim**: Neovim設定の LSP サポート

## カスタマイズ

### 独自プラグインの追加
- **場所**: `lua/custom/plugins/` ディレクトリ
- **自動読み込み**: `{ import = 'custom.plugins.init' }` で設定

### 設定ファイル構造
```
nvim3/
├── init.lua (メイン設定)
├── lua/
│   ├── kickstart/
│   │   ├── health.lua (ヘルスチェック)
│   │   └── plugins/ (基本プラグイン群)
│   └── custom/
│       └── plugins/ (カスタムプラグイン)
```

## 使用方法

### 初回起動時
1. `:Tutor` でVimチュートリアルを実行
2. `:checkhealth` で設定状態を確認
3. `:Lazy` でプラグインの状態確認

### よく使用するコマンド
- **`:Lazy`**: プラグイン管理
- **`:Mason`**: LSP/ツール管理
- **`:Telescope`**: ファジーファインダー
- **`:Neotree`**: ファイルエクスプローラー

この設定は学習しやすく、段階的にカスタマイズできるように設計されています。