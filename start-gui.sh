#!/bin/bash
set -e  # 遇到错误立即停止

echo "===== 开始安装 LXQt 桌面环境 ====="

# 更新软件源
sudo apt update

# 安装 LXQt 核心桌面（选择 lightdm 作为显示管理器）
echo "安装 LXQt 核心桌面..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y lxqt-core lightdm

# 安装 VNC 服务
echo "安装 TigerVNC..."
sudo apt install -y tigervnc-standalone-server tigervnc-common

# 设置 VNC 密码（这里预设为 "123456"，你可以修改）
echo "设置 VNC 密码（默认 123456）..."
mkdir -p ~/.vnc
echo "123456" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# 启动 VNC 服务（使用 1920x1080 分辨率，可自行调整）
echo "启动 VNC 服务（分辨率 1920x1080）..."
vncserver -geometry 1920x1080 -localhost no

# 安装 noVNC（用于 Web 访问）
echo "安装 noVNC..."
git clone https://github.com/novnc/noVNC.git ~/noVNC

# 启动 noVNC 代理
echo "启动 noVNC，监听端口 6080..."
cd ~/noVNC/utils
./novnc_proxy --vnc localhost:5901 &

echo ""
echo "===== 安装完成！====="
echo "请切换到 VS Code 的「端口」(PORTS) 选项卡，找到 6080 端口，"
echo "点击「在浏览器中打开本地地址」图标（或手动访问 http://localhost:6080）"
echo "VNC 密码是：123456"
EOF
