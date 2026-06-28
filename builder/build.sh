#!/bin/bash
# ============================================================
# Debug 构建 fcitx5-chinese-addons（日常开发用）
# 用法: ./builder/build.sh
# ============================================================
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/env.sh"

BUILD_TYPE="${1:-Debug}"

echo "=== [$BUILD_TYPE] 配置 fcitx5-chinese-addons ==="
cd "$CHINESE_ADDONS_DIR"
cmake -B build -DCMAKE_BUILD_TYPE="$BUILD_TYPE" $CMAKE_COMMON_FLAGS

echo ""
echo "=== [$BUILD_TYPE] 编译 fcitx5-chinese-addons ==="
cmake --build build -j"$NPROC"

echo ""
echo "=== 构建产物 ==="
echo "  build/bin/  — 共享模块 + 工具"
echo "  build/lib/  — 静态库"
echo ""
echo "✅ [$BUILD_TYPE] 构建完成"
