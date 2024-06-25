#!/bin/bash

# 定义一个函数来执行批量操作
function batch_operations() {
    # Step 1: 创建一个文件夹 nubit-docker
    mkdir -p nubit-docker

    # Step 2: 进入 nubit-docker 文件夹，然后下载 Dockerfile
    cd nubit-docker
    curl -O https://raw.githubusercontent.com/OkamotoSatoshi/node/main/Dockerfile

    # Step 3: 批量创建 Docker 镜像
    for i in {1..10}
    do
        docker build -t nubit-node-$i .
    done

    # Step 4: 批量运行 Docker 容器
    for i in {1..10}
    do
        docker run -d --name nubit-node-$i nubit-node-$i
    done

    echo "Docker images built and containers started successfully."
}

# 显示菜单
echo "请选择一个选项:"
echo "1. 执行批量操作"
echo "2. 退出"

# 读取用户输入
read -p "请输入你的选择: " choice

# 根据用户选择执行相应的操作
case $choice in
    1)
        batch_operations
        ;;
    2)
        echo "退出"
        ;;
    *)
        echo "无效的选择，请输入 1 或 2"
        ;;
esac
