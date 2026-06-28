# GPG 签名配置与故障排除

## 问题现象

执行 `git commit` 时报错：

```
error: gpg failed to sign the data
gpg: skipped "XXXX": Unusable secret key
gpg: signing failed: Unusable secret key
fatal: failed to write commit object
```

## 原因诊断

```bash
# 查看当前 GPG 密钥状态
gpg --list-secret-keys --keyid-format LONG
```

常见原因：
- **密钥已过期** — 输出中显示 `[过期于：YYYY-MM-DD]` 或 `[expired: YYYY-MM-DD]`
- 密钥无密码且 gpg-agent 无法访问 `/dev/tty`

## 解决方案

### 1. 延长密钥有效期

```bash
# 延长指定时间（如 1 年）
gpg --no-tty --batch --yes --quick-set-expire "<完整指纹>" "1y"

# 设为永不过期
gpg --no-tty --batch --yes --quick-set-expire "<完整指纹>" "0"
```

> **注意**：`--quick-set-expire` 需要**完整指纹**（40 位十六进制字符），不能使用短 Key ID。

### 2. 更新 GitHub 上的公钥

密钥的有效期嵌入在公钥数据中。延长有效期后，**必须**将更新后的公钥重新上传到 GitHub，否则 commit 会显示 `Unverified`。

```bash
# 导出更新后的公钥
gpg --armor --export "<完整指纹>"
```

然后前往 [github.com/settings/gpg](https://github.com/settings/gpg)：
1. 删除旧的（已过期）GPG key
2. 粘贴新导出的公钥
3. 点击 **Add GPG Key**

## 验证配置一致性

确保以下三项的邮箱地址完全一致，commit 才会显示 `Verified`：

```bash
# GPG 密钥邮箱
gpg --list-secret-keys --keyid-format LONG | grep uid

# Git 用户邮箱
git config --global user.email

# Git 签名密钥
git config --global user.signingkey
```

| 配置项 | 说明 |
|--------|------|
| GPG 密钥 UID | `gpg --list-secret-keys` 中的 uid |
| Git `user.email` | commit 作者邮箱，必须与 GPG 密钥邮箱一致 |
| Git `user.signingkey` | GPG 密钥的 Key ID（如 `2FA4A4CD9B3CAD94`） |
| GitHub GPG Keys | 上传的公钥必须是最新版本（含有效期内） |

> 如果 GitHub 开启了 **"Keep my email addresses private"**，应使用 GitHub 提供的 noreply 邮箱（格式：`ID+USERNAME@users.noreply.github.com`），并与 GPG 密钥、git config 保持一致。

## 常用命令速查

| 命令 | 说明 |
|------|------|
| `gpg --list-secret-keys --keyid-format LONG` | 查看所有私钥及有效期 |
| `gpg --armor --export "<指纹>"` | 导出 ASCII 格式公钥（用于上传 GitHub） |
| `gpg --no-tty --batch --yes --quick-set-expire "<指纹>" "1y"` | 延长有效期 1 年 |
| `gpg --no-tty --batch --yes --quick-set-expire "<指纹>" "0"` | 设为永不过期 |
| `git config --global commit.gpgsign true` | 启用全局 GPG 签名 |
| `git config --global user.signingkey <KEY>` | 设置签名密钥 |
