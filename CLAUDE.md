# fcitx5-chinese-addons

## 项目简介

fcitx5 的中文输入法附加组件集合，包含拼音、双拼、五笔等输入法模块。

## 代理配置

```bash
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
```

## 构建

依赖 fcitx5 和 libime 先编译安装到 `/usr`，详见 `../fcitx5-dev/docs/dev-setup.md`。

```bash
cd /MyData/projects/fcitx5-chinese-addons
cmake -B build
cmake --build build
```

## 开发注意事项

- 这是 `fcitx5-dev` 工作区中的主要开发目标
- fcitx5 和 libime 是上游依赖，只读不写
- 使用 VSCode 时打开 `/MyData/projects/fcitx5-dev/` 作为工作区根目录
