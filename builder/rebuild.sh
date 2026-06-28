#!/bin/bash
# ============================================================
# 清理后重新构建 fcitx5-chinese-addons
# 用法: ./builder/rebuild.sh [Debug|Release]
# ============================================================
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/env.sh"

BUILD_TYPE="${1:-Debug}"

echo "=== 清理 build 目录 ==="
rm -rf "$CHINESE_ADDONS_DIR/build"

"$SCRIPT_DIR/build.sh" "$BUILD_TYPE"
