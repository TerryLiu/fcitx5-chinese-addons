#!/bin/bash
# ============================================================
# 从源码编译安装全部依赖链 + fcitx5-chinese-addons
# 用法: ./builder/build-all.sh
# 编译顺序: fcitx5 → libime → fcitx5-qt → fcitx5-chinese-addons
# ============================================================
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/env.sh"

BUILD_TYPE="${1:-Debug}"

echo "============================================"
echo "  完整构建 fcitx5 依赖链"
echo "  构建类型: $BUILD_TYPE"
echo "  并行数:   $NPROC"
echo "============================================"
echo ""

# ---- 1. fcitx5 ----
echo "=== [1/4] 编译安装 fcitx5 ==="
cd "$FCITX5_DIR"
if [ ! -d ".git" ]; then
    echo "❌ $FCITX5_DIR 不存在，请先 clone fcitx5"
    exit 1
fi
git submodule update --init --recursive
cmake -B build -DCMAKE_BUILD_TYPE="$BUILD_TYPE" $CMAKE_COMMON_FLAGS -DENABLE_WAYLAND=Off
cmake --build build -j"$NPROC"
sudo cmake --install build
echo ""

# ---- 2. libime ----
echo "=== [2/4] 编译安装 libime ==="
cd "$LIBIME_DIR"
if [ ! -d ".git" ]; then
    echo "❌ $LIBIME_DIR 不存在，请先 clone libime"
    exit 1
fi
git submodule update --init --recursive
cmake -B build -DCMAKE_BUILD_TYPE="$BUILD_TYPE" $CMAKE_COMMON_FLAGS
cmake --build build -j"$NPROC"
sudo cmake --install build
echo ""

# ---- 3. fcitx5-qt ----
echo "=== [3/4] 编译安装 fcitx5-qt ==="
cd "$FCITX5_QT_DIR"
if [ ! -d ".git" ]; then
    echo "❌ $FCITX5_QT_DIR 不存在，请先 clone fcitx5-qt"
    exit 1
fi
cmake -B build -DCMAKE_BUILD_TYPE="$BUILD_TYPE" $CMAKE_COMMON_FLAGS -DENABLE_QT5=Off
cmake --build build -j"$NPROC"
sudo cmake --install build
echo ""

# ---- 4. fcitx5-chinese-addons ----
echo "=== [4/4] 编译 fcitx5-chinese-addons ==="
"$SCRIPT_DIR/build.sh" "$BUILD_TYPE"

echo ""
echo "============================================"
echo "  ✅ 全部构建完成"
echo "============================================"
