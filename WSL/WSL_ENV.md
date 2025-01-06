### WSL 安装
```
wsl --list --online # 查询可在线安装的发行版本
wsl --install -d <Distribution Name> # 安装对应的发行版本
wsl --set-default-version 2

#删除系统
wsl --unregister <DistributionName>
```



### download miniconda
```

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo chmod 777 Miniconda3-latest-Linux-x86_64.sh 
./Miniconda3-latest-Linux-x86_64.sh

```
### conda create env
```
conda create -n env_python python=3.10
conda env list #查看当前环境列表
conda activate env_python #进入该虚拟环境
conda deactivate #退出当前虚拟环境
conda env remove --name env_python #删除指定虚拟环境
conda config --set env_prompt '({default_env})' #将虚拟环境名恢复默认
```
### 查看显卡和cuda版本
```
nvidia-smi
sudo nvidia-smi

在命令行输入nvidia-smi查看系统可安装的最新的cuda版本。

你可以安装所有不高于这个版本的cuda，一般情况下安装此版本即可

针对WSL的
https://docs.nvidia.com/cuda/wsl-user-guide/index.html

#修复Linux中无效问题
sudo cp /usr/lib/wsl/lib/nvidia-smi /usr/bin/nvidia-smi
sudo chmod ogu+x /usr/bin/nvidia-smi
在wsl2中运行这两个语句，再输入nvidia-smi，成功了


```
### 安装 CUDA 之前，子系统需要准备编译相关所需的环境
```
sudo apt update # 更新软件包列表
sudo apt upgrade # 执行软件包更新
sudo apt install build-essential # 安装编译所需的工具链
```
### 安装CUDA
```

https://developer.nvidia.com/cuda-toolkit-archive

进入网页，选择对应的平台，示例代码

wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo wget https://developer.download.nvidia.com/compute/cuda/12.4.0/local_installers/cuda-repo-wsl-ubuntu-12-4-local_12.4.0-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-4-local_12.4.0-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-4
```
### 卸载cuda
```
#列出所有cuda
ls /usr/local | grep cuda 

#卸载
sudo apt-get remove --autoremove cuda
sudo apt-get purge cuda-*

#不行就强制删除
sudo apt-get remove --purge '^cuda-.*'
sudo rm -rf /usr/local/cuda

#验证包是否正确安装
dpkg -l | grep cuda
```
### 启动配置PATH
```
nano ~/.bashrc

source ~/.bashrc

# miniconda3 对应的路径
export PATH=/home/zzz/miniconda3/bin:$PATH

# Add nvcc compiler to PATH
export PATH=/usr/local/cuda/bin:$PATH

# Add CUDA libraries to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

```
### 查看cuda是否安装成功
```
nvcc --version
```
### 安装cuDANN(CUDA Deep Neural Network library)

```
https://developer.nvidia.com/cudnn-downloads
https://developer.nvidia.com/rdp/cudnn-archive

找到对应的版本下载即可。
```
### 验证cuDNN安装
```
 import torch
 print(torch.backends.cudnn.version())
#能够正确返回一串数字，如：90100
 from torch.backends import cudnn # 若正常则静默
cudnn.is_available() 
# 若正常返回True
a=torch.tensor(1.)
cudnn.is_acceptable(a.cuda()) 
# 若正常返回True
```
### 安装pytorch
```
https://pytorch.org/

代码示例
conda install pytorch torchvision torchaudio pytorch-cuda=12.4 -c pytorch -c nvidia


之前的版本 
https://pytorch.org/get-started/previous-versions/
```
### 安装ML库
```
conda install jupyter numpy pandas tensorboard matplotlib tqdm pyyaml -y

```
### 安装Tensorflow
```
https://www.tensorflow.org/install/source?hl=zh-cn#gpu
```
### 导出wsl
 ```
 wsl -l -v
这个命令用来列出所有已安装的 WSL Linux 发行版，并显示它们的版本和状态（是否正在运行）。-v 选项表示详细模式。
wsl --shutdown
该命令会关闭所有的 WSL 后台进程，相当于关闭所有 WSL Linux 系统。这可以释放系统资源并确保在导出发行版时文件不会被占用。
wsl --export Ubuntu D:\Ubuntu_WSL\Ubuntu.tar
这个命令将名为 "Ubuntu" 的 WSL 发行版导出为一个 tar 文件，保存路径为 D:\Ubuntu_WSL\Ubuntu.tar。这会创建一个该发行版的备份，包括所有安装的软件包和个人配置。
wsl --unregister Ubuntu
该命令会从 WSL 中注销 "Ubuntu" 发行版。这意味着它将从 WSL 注册表中删除，但不会删除实际的文件。如果你之前已经用 --export 命令备份了数据，那么这些数据仍然存在于备份文件中。
wsl --import Ubuntu D:\Ubuntu_WSL D:\Ubuntu_WSL\Ubuntu.tar
该命令将之前导出的 "Ubuntu" 发行版重新导入到 WSL。D:\Ubuntu_WSL 是新发行版的安装目录，而 D:\Ubuntu_WSL\Ubuntu.tar 是之前导出的 tar 文件的位置。这允许你在不同的机器上恢复 WSL 发行版或在同一机器上重新安装。
Ubuntu config --default-user wr
这个命令设置 "Ubuntu" 发行版的默认用户为 wr。当启动 WSL 或通过命令行启动 Ubuntu 时，它将自动以这个用户身份登录，而不必每次都手动输入用户名和密码。
 ```
### python config
```
Python 环境
在 ~/.pip/pip.conf 文件中写入如下内容

[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = http://pypi.tuna.tsinghua.edu.cn
```
### VSCode 配置
```
在代码工作目录下执行 code . 会自动安装 VSCode 服务以当前目录为工作区启动
```
### netsh 命令配置 Windows 的端口转发
* wsl2可以和windows本机共享一个ip, 而wsl2默认的ssh 端口为23, 也就是说其ssh-host为${you-windows-ip}:23, (这里要注意的是, wsl2上的端口要避免和windows上产生冲突);
* 虽然是共享ip,但是外界并不能直接访问wsl2, 需要配置端口映射才能访问;
* 需要在防火墙开发端口的访问权限;

```
# option prot proxy
netsh interface portproxy add v4tov4 listenport=23 listenaddress=0.0.0.0 connectport=23 connectaddress=localhost
# show port proxy
netsh interface portproxy show all


侦听 ipv4:                 连接到 ipv4:

地址            端口        地址            端口
--------------- ----------  --------------- ----------
0.0.0.0         23          localhost       23
```