#!/bin/bash
# ============================================================
# 共享环境配置 — 被其他构建脚本 source 引用
# ============================================================

# 代理配置（git clone、cmake 下载依赖等需要）
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890

# 项目路径
PROJECTS_ROOT="/MyData/projects"
WORKSPACE="$PROJECTS_ROOT/fcitx5-dev"

FCITX5_DIR="$PROJECTS_ROOT/fcitx5"
LIBIME_DIR="$PROJECTS_ROOT/libime"
FCITX5_QT_DIR="$PROJECTS_ROOT/fcitx5-qt"
CHINESE_ADDONS_DIR="$PROJECTS_ROOT/fcitx5-chinese-addons"

# 编译参数
NPROC=$(nproc)
CMAKE_COMMON_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
