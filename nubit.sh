#!/bin/bash

# 定义一个函数来执行批量操作
function batch_operations() {
    # 询问用户要创建的 Docker 镜像和容器的数量
    read -p "请输入要创建的 Docker 镜像和容器的数量: " count

    # Step 1: 创建一个文件夹 nubit-docker
    mkdir -p nubit-docker

    # Step 2: 进入 nubit-docker 文件夹，然后下载 Dockerfile
    cd nubit-docker
    curl -L -o Dockerfile https://raw.githubusercontent.com/OkamotoSatoshi/node/main/Dockerfile

    # Step 3: 批量创建 Docker 镜像
    for ((i=1; i<=count; i++))
    do
        docker build -t nubit-node-$i .
    done

    # Step 4: 批量运行 Docker 容器
    for ((i=1; i<=count; i++))
    do
        docker run -d --name nubit-node-$i nubit-node-$i
    done

    echo "Docker images built and containers started successfully."
}

# 定义一个函数来执行第二个批量操作
function batch_exec_operations() {
    # 询问用户要操作的 Docker 容器的数量
    read -p "请输入要操作的 Docker 容器的数量: " count

    # 批量执行命令并将输出保存到对应的文件中
    for ((i=1; i<=count; i++))
    do
        docker exec -it nubit-node-$i bash -c "\$HOME/nubit-node/bin/nkey list --p2p.network nubit-alphatestnet-1 --node.type light" > nubit-docker/node-key-$i.txt
        docker exec -it nubit-node-$i cat ~/nubit-node/mnemonic.txt >> nubit-docker/node-key-$i.txt
    done

    echo "Commands executed and output saved to files successfully."
}

# 显示菜单
echo "请选择一个选项:"
echo "1. 执行批量构建和运行操作"
echo "2. 执行批量 exec 操作"
echo "3. 退出"

# 读取用户输入
read -p "请输入你的选择: " choice

# 根据用户选择执行相应的操作
case $choice in
    1)
        batch_operations
        ;;
    2)
        batch_exec_operations
        ;;
    3)
        echo "退出"
        ;;
    *)
        echo "无效的选择，请输入 1、2 或 3"
        ;;
esac
