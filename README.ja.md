# WezTerm Configuration

モジュール化されたLua構造による個人用 [WezTerm](https://wezfurlong.org/wezterm/) 設定です。

## 機能

### キーバインド

| キー | 動作 |
|------|------|
| `Ctrl+q` | リーダーキー（2秒タイムアウト） |
| `Leader o` | アクティブなopencodeセッション一覧（fzf） |
| `Leader r` / `Leader R` | ペイン右/水平分割 |
| `Leader d` / `Leader D` | ペイン下/垂直分割 |
| `Leader x` | 現在のペインを閉じる |
| `Leader ,` | タブ名変更 |
| `Leader w` | ワークスペース切替（InputSelector） |
| `Leader s` | 設定モード開始（ペインリサイズ） |
| `Leader k` | Karabinerプロファイル切替 |
| `Leader p` | AWSプロファイル選択 |
| `Leader u` | Codex stash（Ctrl+g → `:wq`） |
| `Leader y` | Codex stash pop |
| `Leader z` | 直前のコマンド+出力をコピー |
| `Leader b` | バッファをNeovimで表示（WezCapture） |
| `Leader l` | コマンド起動セレクター（ghost/lazygit/nvim/yazi） |
| `Leader a` | ARNをQuick SelectしてAWS Consoleを開く |
| `Ctrl+Shift+c` | ペインを1行に最小化/復元 |
| `Ctrl+Shift+h/j/k/l` | ペイン間移動 |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | 次/前のタブ |
| `Super+n` | 新規ウィンドウ |
| `Super+t` | 新規タブ |
| `Super+w` | タブを閉じる |
| `Super+1-9` | タブ切替 |
| `Super+f` | 検索モード |
| `Super+r` | 設定再読み込み |
| `Ctrl+P` | コマンドパレット |
| `Ctrl+X` | コピーモード（ビューポート中央） |
| `Ctrl+Z` | ペインズーム切替 |
| `Ctrl+U` | 文字選択 |
| `Ctrl+Shift+R` | 設定を強制再読み込み |
| `Super+Shift+Space` | Quick Select |
| `Alt+Enter` | フルスクリーン切替 |
| `Alt+[` / `Alt+]` | 前/次のプロンプトまでスクロール |
| `Ctrl+Alt+p` / `Ctrl+Alt+n` | 半ページ上下スクロール |

### 設定モード（`Leader s`）

| キー | 動作 |
|------|------|
| `h/j/k/l` | ペインサイズ調整（1単位） |
| `1-9` | ペイン幅を10-90%に設定 |
| `Alt+1-9` | ペイン高さを10-90%に設定 |
| `;` | 透明度を上げる |
| `-` | 透明度を下げる |
| `0` | 透明度をリセット |
| `Esc` / `q` | 設定モード終了 |

### コピーモード（`Ctrl+X`）

Vim風キーバインド: `h/j/k/l`, `w/b/e`, `v/V/Ctrl+v`（選択）, `y`（コピー）, `f/t/F/T`（ジャンプ）, `z`（セマンティックゾーン選択）, `[/]`（インプットゾーンジャンプ）。

### タブ

- プロセス種別ごとのアイコンと色（opencode, neovim, docker, SSH, nb）
- ペインズーム中のインジケーター
- アクティブタブの丸い装飾
- `Leader ,` でタブ名変更

### ステータスバー

- ワークスペース名表示（色分け: 黄=コピーモード, 緑=設定モード）
- アクティブなキーテーブルに応じてカーソル色が変化

### Open Code連携

- opencodeセッションのタブアイコン検出
- `Leader o` でアクティブなopencodeセッションをfzf一覧・切替
- プレビューペインにセッション詳細と最新の出力を表示
- コマンドパレットから起動（`Ctrl+P` → "Launch: Open Code"）

### ワークスペース

| キー | 動作 |
|------|------|
| `Ctrl+Super+s` | スクラッチワークスペース切替 |
| `Ctrl+Super+a` | nbワークスペース切替 |
| `Ctrl+Super+n/p` | 次/前のワークスペース（scratch/nbをスキップ） |
| `Leader w` | ワークスペース切替 |
| `Shift+C`（ワークスペースモード） | 新規ワークスペース作成 |

### AWSプロファイル選択（`Leader p`）

`aws configure list-profiles` または `~/.aws/config` からプロファイル一覧を取得し `export AWS_PROFILE=<name>` を挿入します。

### Karabinerプロファイル切替（`Leader k`）

`~/.config/karabiner/karabiner.json` からプロファイルを読み込み `karabiner_cli` で切替します。

### Caffeinate制御

コマンドパレット（`Ctrl+P`）から利用可能。スリープ防止の `caffeinate` を開始/停止します（30分、1時間、2時間、無制限）。

### フォーカス連動の透明度

- フォーカス時: `opacity = 0.9`（ブラー表示）
- 非フォーカス時: `opacity = 1.0`（ブラー非表示）

### Quick Select（`Super+Shift+Space`）

パターン: URL、AWS ARN、ファイルパス、Gitコミットハッシュ、IPアドレス、UUID。

## モジュール

| ファイル | 説明 |
|---------|------|
| `wezterm.lua` | エントリポイント |
| `keymaps.lua` | キーバインド、コマンドパレット |
| `appearance.lua` | カラースキーム、ウィンドウ装飾 |
| `statusbar.lua` | ワークスペース表示、カーソル色 |
| `tab.lua` | タブタイトル整形、プロセス検出 |
| `workspace.lua` | ワークスペース管理 |
| `modules/opacity.lua` | ウィンドウ透明度制御 |
| `modules/aws_profile.lua` | AWSプロファイル選択 |
| `modules/karabiner_profile.lua` | Karabinerプロファイル切替 |
| `modules/caffeinate.lua` | スリープ防止 |
| `modules/opencode_session.lua` | opencodeセッションfzf切替 |
| `scripts/preview_opencode_session.lua` | opencodeセッションのfzfプレビュースクリプト |

## 要件

- [WezTerm](https://wezfurlong.org/wezterm/)
- [fzf](https://github.com/junegunn/fzf)（`Leader o` セッション切替用）
- [jq](https://jqlang.github.io/jq/)（セッションプレビュー用）
- [opencode](https://opencode.ai)（オプション、opencode連携用）
- [Karabiner-Elements](https://karabiner-elements.pqrs.org/)（オプション、プロファイル切替用）
- [AWS CLI](https://aws.amazon.com/cli/)（オプション、プロファイル選択用）
