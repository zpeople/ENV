在 WSL 环境中遇到 `Permission denied (publickey)` 错误，通常是由于 SSH 密钥配置问题导致的。以下是解决此问题的步骤：

1. **检查是否已有 SSH 密钥**
   在 WSL 终端中运行：
   ```bash
   ls -la ~/.ssh
   ```
   查看是否有 `id_rsa` 和 `id_rsa.pub` 文件

2. **生成新的 SSH 密钥（如果没有）**
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   按回车接受默认位置和空密码

3. **启动 SSH 代理并添加密钥**
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_rsa
   ```

4. **复制公钥内容**
   ```bash
   cat ~/.ssh/id_rsa.pub
   ```
   复制输出的全部内容

5. **在 GitHub 上添加 SSH 密钥**
   - 登录 GitHub，进入 Settings → SSH and GPG keys
   - 点击 "New SSH key"
   - 粘贴复制的公钥内容并保存

6. **测试连接**
   ```bash
   ssh -T git@github.com
   ```
   如果成功，会显示你的 GitHub 用户名

再次尝试 `git pull --tags origin main` 应该就能正常工作了。