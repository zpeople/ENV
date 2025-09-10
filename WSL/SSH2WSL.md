通过 SSH 访问 WSL（Windows Subsystem for Linux）是一个非常实用的方法，特别是在需要远程开发或在不同环境中协作时。以下是详细的步骤，帮助你在 WSL 中设置和配置 OpenSSH 服务器，并通过 SSH 连接到 WSL。

### 1. 确保 WSL 已安装并配置好

首先，确保你已经安装了 WSL 2 并配置好了你喜欢的 Linux 发行版（例如 Ubuntu）。以下是安装步骤：

#### a. 启用 WSL 和虚拟机平台

打开 PowerShell 并以管理员身份运行以下命令：

```powershell
wsl --install
```

这将启用 WSL 和虚拟机平台，并安装默认的 Linux 发行版（通常是 Ubuntu）。

#### b. 设置默认 WSL 版本为 2

确保默认 WSL 版本设置为 2：

```powershell
wsl --set-default-version 2
```

### 2. 安装 Linux 发行版

如果你还没有安装 Linux 发行版，可以通过 Microsoft Store 安装。以下是安装 Ubuntu 的示例：

1. 打开 Microsoft Store。
2. 搜索 "Ubuntu"。
3. 点击 "获取" 或 "安装"。

安装完成后，启动 Ubuntu 终端并按照提示完成初始设置。

### 3. 更新和安装必要的软件包

在 Ubuntu 终端中，更新包列表并安装必要的软件包：

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget htop 
```

### 4. 安装 OpenSSH Server

为了通过 SSH 连接到 WSL，你需要安装 OpenSSH Server。

1. **安装 OpenSSH Server**：
   ```bash
   sudo apt install -y openssh-server
   ```

2. **启动 SSH 服务**：
   ```bash
   sudo service ssh start
   ```
   
   ```
   sudo nano /etc/wsl.conf
  
   #粘贴内容
   [boot]
   systemd=true  # 关键：启用 systemd

   [user]
   default=你的用户名  # 替换为你的 WSL 用户名（如 ubuntu）
   ```

3. **检查 SSH 服务状态**：
   ```bash
   
   sudo systemctl status ssh
   ```
   确保服务正在运行并且没有错误。

### 5. 配置防火墙

确保 Windows 防火墙允许 SSH 流量。你可以手动配置防火墙规则或使用以下 PowerShell 命令：

```powershell
New-NetFirewallRule -DisplayName 'Open Port 22 for WSL' -Direction Inbound -LocalPort 22 -Protocol TCP -Action Allow
```

### 6. 查找 WSL IP 地址

WSL 使用一个动态分配的 IP 地址。你可以通过以下命令查找 WSL 的 IP 地址：

```bash
ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1
```

记下输出的 IP 地址，例如 `172.29.160.1`。

### 7. 配置 SSH 密钥（可选但推荐）

使用 SSH 密钥比密码更安全。以下是生成 SSH 密钥对并将其添加到 WSL 的步骤：

1. **在本地机器上生成 SSH 密钥对**（如果还没有的话）：
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   默认情况下，密钥对会保存在 `~/.ssh/id_rsa`（私钥）和 `~/.ssh/id_rsa.pub`（公钥）。

2. **将公钥复制到 WSL**：
   ```bash
   ssh-copy-id username@172.29.160.1
   ```
   其中 `username` 是你在 WSL 中的用户名，`172.29.160.1` 是你的 WSL IP 地址。

3. **测试 SSH 连接**：
   ```bash
   ssh username@172.29.160.1
   ```
   如果一切正常，你应该能够直接登录而无需输入密码。

### 8. 配置自动启动 SSH 服务（可选）

为了让 SSH 服务在 WSL 启动时自动启动，可以创建一个 systemd 服务单元文件。

1. **创建 systemd 服务单元文件**：
   ```bash
   sudo nano /etc/systemd/system/sshd.service
   ```

2. **添加以下内容**：
   ```ini
   [Unit]
   Description=OpenBSD Secure Shell server
   After=network.target

   [Service]
   ExecStart=/usr/sbin/sshd -D
   Restart=always
   User=root

   [Install]
   WantedBy=multi-user.target
   ```

3. **启用并启动服务**：
   ```bash
   sudo systemctl enable sshd
   sudo systemctl start sshd
   ```

### 9. 使用 VS Code 远程开发（可选）

VS Code 提供了强大的远程开发功能，可以方便地通过 SSH 连接到 WSL 并进行开发。

1. **安装 VS Code**：
   - 访问 [VS Code 官方网站](https://code.visualstudio.com/) 并下载安装。

2. **安装 Remote - SSH 扩展**：
   - 打开 VS Code。
   - 进入扩展市场，搜索 "Remote - SSH" 并安装。

3. **连接到 WSL**：
   - 打开 VS Code 命令面板（Ctrl+Shift+P 或 Cmd+Shift+P）。
   - 输入 "Remote-SSH: Connect to Host..." 并选择你的 WSL IP 地址或主机名。

### 示例：通过 SSH 连接到 WSL

假设你已经在 WSL 中安装了 OpenSSH Server，并且知道 WSL 的 IP 地址是 `172.29.160.1`，以下是具体步骤：

1. **生成 SSH 密钥对**（如果还没有的话）：
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

2. **将公钥复制到 WSL**：
   ```bash
   ssh-copy-id username@172.29.160.1
   ```

3. **通过 SSH 连接到 WSL**：
   ```bash
   ssh username@172.29.160.1
   ```
4. **删除文件**：
   ```bash
   .ssh\known_hosts
   ```





是的，SSH（Secure Shell）可以配置多个用户来远程访问 Linux 系统，包括在 WSL 中。通过 SSH，你可以为不同的用户提供独立的账户和权限，从而实现多用户的远程访问和管理。以下是详细的步骤和配置方法：

### 10. 创建多个用户

首先，你需要在 WSL 中创建多个用户账户。

#### a. 创建新用户

使用 `adduser` 命令创建新用户。例如，创建一个名为 `alice` 的用户：

```bash
sudo adduser alice
```

系统会提示你输入新用户的密码和其他信息。重复此步骤以创建更多用户。

#### b. 验证用户创建

你可以通过以下命令查看所有用户：

```bash
cut -d: -f1 /etc/passwd
```

这将列出系统中的所有用户。

### 2. 配置 SSH 密钥认证

为了安全地进行 SSH 连接，建议使用密钥对而不是密码。以下是生成和配置 SSH 密钥的步骤：

#### a. 在本地机器上生成 SSH 密钥对

如果你还没有生成 SSH 密钥对，可以在本地机器上生成：

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

这将生成 `id_rsa`（私钥）和 `id_rsa.pub`（公钥）文件，默认存储在 `~/.ssh` 目录下。

#### b. 将公钥复制到 WSL 用户

对于每个用户，将你的公钥复制到其 `~/.ssh/authorized_keys` 文件中。假设你要为 `alice` 用户配置 SSH 密钥：

1. **切换到 `alice` 用户**：
   ```bash
   sudo su - alice
   ```

2. **创建 `.ssh` 目录并设置权限**：
   ```bash
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   ```

3. **创建或编辑 `authorized_keys` 文件**：
   ```bash
   nano ~/.ssh/authorized_keys
   ```

4. **粘贴你的公钥**（`id_rsa.pub` 的内容）：
   ```plaintext
   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC... your_email@example.com
   ```

5. **保存并退出编辑器**（按 `Ctrl+X`，然后按 `Y`，最后按 `Enter`）。

6. **设置 `authorized_keys` 文件权限**：
   ```bash
   chmod 600 ~/.ssh/authorized_keys
   ```

7. **返回 root 用户**：
   ```bash
   exit
   ```

重复上述步骤为其他用户配置 SSH 密钥。



