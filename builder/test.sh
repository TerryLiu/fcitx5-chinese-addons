#!/bin/bash
# ============================================================
# 运行 fcitx5-chinese-addons 测试
# 用法: ./builder/test.sh
# ============================================================
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/env.sh"

BUILD_DIR="$CHINESE_ADDONS_DIR/build"

if [ ! -f "$BUILD_DIR/CTestTestfile.cmake" ]; then
    echo "❌ 未找到 CTestTestfile.cmake，请先执行 ./builder/build.sh"
    exit 1
fi

echo "=== 运行测试 ==="
cd "$BUILD_DIR"
ctest --output-on-failure -j"$NPROC"

echo ""
echo "✅ 测试完成"
