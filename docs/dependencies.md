# 依赖项目路径

## 开发目录

```
/MyData/projects/fcitx5-dev/          ← 专用开发目录
├── fcitx5                   → ../fcitx5                  (软链接)
├── libime                   → ../libime                  (软链接)
└── fcitx5-chinese-addons    → ../fcitx5-chinese-addons   (软链接)
```

三个项目的实际路径仍在 `/MyData/projects/` 下平级存放，通过软链接聚合到 `fcitx5-dev/`。用 VSCode 打开 `/MyData/projects/fcitx5-dev/` 即可同时编辑三个项目。

## 依赖项目

| 项目 | 路径 | 版本要求 | 说明 |
|------|------|----------|------|
| fcitx5 | `/MyData/projects/fcitx5` | ≥ 5.1.20 | 输入法核心框架 |
| libime | `/MyData/projects/libime` | ≥ 1.1.14 | 拼音/码表输入法引擎 |

## 本项目

| 项目 | 路径 |
|------|------|
| fcitx5-chinese-addons | `/MyData/projects/fcitx5-chinese-addons` |

## 编译说明

编译 fcitx5-chinese-addons 前，需先编译安装 fcitx5 和 libime：

```bash
# 1. 编译安装 fcitx5
cd /MyData/projects/fcitx5
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build
sudo cmake --install build

# 2. 编译安装 libime
cd /MyData/projects/libime
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build
sudo cmake --install build

# 3. 编译 fcitx5-chinese-addons
cd /MyData/projects/fcitx5-chinese-addons
cmake -B build
cmake --build build
```
