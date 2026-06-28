#!/bin/bash
# ============================================================
# 安装 fcitx5-chinese-addons 到 /usr
# 用法: sudo ./builder/install.sh
# ============================================================
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/env.sh"

if [ "$EUID" -ne 0 ]; then
    echo "❌ 需要 root 权限，请用: sudo ./builder/install.sh"
    exit 1
fi

BUILD_DIR="$CHINESE_ADDONS_DIR/build"

if [ ! -f "$BUILD_DIR/cmake_install.cmake" ]; then
    echo "❌ 未找到 cmake_install.cmake，请先执行 ./builder/build.sh"
    exit 1
fi

echo "=== 安装 fcitx5-chinese-addons ==="
cd "$BUILD_DIR"
cmake --install .

echo ""
echo "✅ 安装完成"
