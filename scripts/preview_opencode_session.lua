#!/usr/bin/env lua

-- コマンドライン引数
local sessions_file = arg[1]
local selected_line = arg[2]

-- 色定義
local PURPLE = '\x1b[38;5;141m'
local BLUE = '\x1b[38;5;117m'
local WHITE = '\x1b[38;5;255m'
local GRAY = '\x1b[38;5;240m'
local GREEN = '\x1b[38;5;114m'
local RESET = '\x1b[0m'

-- pane_idを抽出
local pane_id = selected_line:match("|([^|]+)$")

if not pane_id then
  print("Error: Could not extract pane_id")
  os.exit(1)
end

-- jqでJSONパース
local jq_cmd = string.format(
  "grep '\"pane_id\":\"%s\"' '%s' | jq -r '.workspace,.project,.cwd,.content,.tab_title,.status'",
  pane_id,
  sessions_file
)

local handle = io.popen(jq_cmd)
if not handle then
  print("Error: Failed to execute jq")
  os.exit(1)
end

local workspace = handle:read("*line") or ""
local project = handle:read("*line") or ""
local cwd = handle:read("*line") or ""
local content = handle:read("*line") or ""
local tab_title = handle:read("*line") or ""
local status = handle:read("*line") or "idle"
handle:close()

-- ヘッダー表示
print(GRAY .. "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" .. RESET)
print(PURPLE .. "🤖 Open Code Session" .. RESET)
print(GRAY .. "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" .. RESET)
print("")

-- ステータス表示
local status_display
if status == "running" then
  status_display = GREEN .. "● running" .. RESET
else
  status_display = GRAY .. "○ idle" .. RESET
end

-- セッション詳細
print(WHITE .. "Status:   " .. RESET .. " " .. status_display)
print(WHITE .. "Workspace:" .. RESET .. " " .. PURPLE .. workspace .. RESET)
print(WHITE .. "Project:  " .. RESET .. " " .. BLUE .. project .. RESET)
print(WHITE .. "Tab:      " .. RESET .. " " .. GRAY .. tab_title .. RESET)
print(WHITE .. "Path:     " .. RESET .. " " .. GRAY .. cwd .. RESET)
print("")

-- セッション内容
if content ~= "" and content ~= "null" then
  print(WHITE .. "Session Content:" .. RESET)
  print("  " .. content)
  print("")
end

-- 最新出力
print(GRAY .. "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" .. RESET)
print(WHITE .. "Recent Output" .. RESET)
print(GRAY .. "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" .. RESET)
print("")

-- wezterm cliでペイン出力取得
local wezterm_cmd = string.format("wezterm cli get-text --pane-id %s 2>/dev/null | tail -n 20", pane_id)
local wezterm_handle = io.popen(wezterm_cmd)
if wezterm_handle then
  local output = wezterm_handle:read("*all")
  wezterm_handle:close()

  if output and output ~= "" then
    print(output)
  else
    print(GRAY .. "(Could not retrieve pane output)" .. RESET)
  end
else
  print(GRAY .. "(wezterm cli not available)" .. RESET)
end
