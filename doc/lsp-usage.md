# LSP（Language Server Protocol）使用ガイド

## 概要

LSP (Language Server Protocol) は、Neovimがプログラミング言語の支援機能を提供するための仕組みです。
コード補完、エラー診断、定義ジャンプ、リファクタリングなどの機能を利用できます。

## 基本的な使い方

### 1. LSPサーバーの管理

#### Masonでの言語サーバー管理
```
:Mason
```
- `g?` でヘルプを表示
- LSP サーバーを検索・インストール
- 現在インストール済み: `lua_ls` (Lua Language Server)

#### 健康状態の確認
```
:checkhealth
```
- LSPサーバーの動作状況を確認
- 必要な依存関係をチェック

### 2. 基本的なナビゲーション

#### 定義・宣言へのジャンプ
- **`gd`** - 定義へ移動（変数・関数が最初に定義された場所）
- **`gD`** - 宣言へ移動（C言語のヘッダーファイルなど）
- **`gI`** - 実装へ移動（インターフェースの実装）
- **`<C-t>`** - 前の場所に戻る

#### 型・参照の確認
- **`gr`** - 参照を表示（その変数・関数が使われている場所）
- **`<leader>D`** - 型定義を表示

### 3. シンボル検索

#### ドキュメント内検索
- **`<leader>ds`** - 現在のファイル内のシンボル（変数・関数）を検索

#### プロジェクト全体検索
- **`<leader>ws`** - ワークスペース全体のシンボルを検索

### 4. コード編集・リファクタリング

#### リネーム
- **`<leader>rn`** - カーソル下の変数・関数をプロジェクト全体でリネーム
- 関連するすべてのファイルで一括変更

#### コードアクション
- **`<leader>ca`** - コードアクションを実行
- エラー修正の提案
- インポート文の自動追加
- リファクタリングの提案

### 5. インレイヒント

#### インレイヒントの切り替え
- **`<leader>th`** - インレイヒントの表示/非表示切り替え
- 型情報やパラメータ名をコード内に表示

### 6. 診断機能

#### エラー・警告の確認
- **`<leader>q`** - 診断情報をQuickfixリストで表示
- **`]d`** - 次の診断項目へ移動
- **`[d`** - 前の診断項目へ移動

#### ホバー情報
- **`K`** - カーソル下の要素の詳細情報を表示

## 実践的な使用例

### Luaファイルでの開発

1. **変数の定義確認**
   ```lua
   local my_function = function() end
   ```
   `my_function`にカーソルを置いて`gd`で定義場所へ

2. **関数の使用箇所確認**
   ```lua
   my_function()  -- ここで`gr`を押すと使用箇所一覧
   ```

3. **エラー修正**
   ```lua
   local undefined_var = some_undefined_function()
   -- エラー行で`<leader>ca`でコードアクション
   ```

4. **変数のリネーム**
   ```lua
   local old_name = "value"
   -- `old_name`で`<leader>rn`を押して新しい名前に変更
   ```

### プロジェクト全体での作業

1. **関数の検索**
   - `<leader>ws`で関数名を入力して検索

2. **設定ファイルの編集**
   - `<leader>sn`でNeovim設定ファイルを検索
   - LSP設定は`lua/kickstart/plugins/lsp.lua`

## LSPサーバーの追加

### 新しい言語サーバーの追加

1. **`lua/kickstart/plugins/lsp.lua`を編集**
   ```lua
   local servers = {
     lua_ls = { ... },
     -- 新しいサーバーを追加
     pyright = {},  -- Python
     tsserver = {}, -- TypeScript
     clangd = {},   -- C/C++
   }
   ```

2. **Neovim再起動後に自動インストール**
   - Masonが自動的にサーバーをインストール

### よく使用される言語サーバー

| 言語 | サーバー名 | 説明 |
|------|------------|------|
| Python | `pyright` | Microsoft製Python LSP |
| TypeScript | `tsserver` | TypeScript公式LSP |
| JavaScript | `tsserver` | TypeScript LSPでJS対応 |
| C/C++ | `clangd` | LLVM製C/C++ LSP |
| Rust | `rust_analyzer` | Rust公式LSP |
| Go | `gopls` | Go公式LSP |
| Java | `jdtls` | Eclipse JDT LSP |

## トラブルシューティング

### LSPが動作しない場合

1. **健康チェック実行**
   ```
   :checkhealth lsp
   ```

2. **Masonで確認**
   ```
   :Mason
   ```
   - サーバーがインストール済みか確認

3. **LSP情報確認**
   ```
   :LspInfo
   ```
   - アクティブなLSPサーバー確認

### よくある問題

- **言語サーバーが起動しない**
  - ファイルタイプが正しく認識されているか確認
  - 必要な依存関係がインストールされているか確認

- **補完が表示されない**
  - nvim-cmpとの連携確認
  - LSPサーバーが正常に動作しているか確認

- **キーマップが効かない**
  - LSPがバッファにアタッチされているか確認
  - `:LspInfo`でバッファ情報を確認

## 設定のカスタマイズ

### キーマップの変更

`lua/kickstart/plugins/lsp.lua`の`map`関数定義部分を編集：

```lua
-- 例：定義ジャンプを別のキーに変更
map('gd', require('telescope.builtin').lsp_definitions, '[G]定義へ移動')
-- ↓
map('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]定義へ移動')
```

### サーバー固有の設定

```lua
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }  -- vimをグローバル変数として認識
        }
      }
    }
  }
}
```

## まとめ

LSPを効果的に使用することで、以下の恩恵を受けられます：

- **正確なコードナビゲーション** - 定義ジャンプや参照検索
- **インテリジェントな補完** - コンテキストに応じた補完候補
- **リアルタイムエラー検出** - タイプ中にエラーを発見
- **安全なリファクタリング** - プロジェクト全体での一括変更
- **豊富な言語サポート** - 多数のプログラミング言語に対応

これらの機能を活用して、より効率的で快適な開発環境を構築してください。