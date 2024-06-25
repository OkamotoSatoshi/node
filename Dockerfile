# 使用官方的 Ubuntu 镜像作为基础镜像
FROM ubuntu:20.04

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 创建一个脚本文件来执行 curl 命令
RUN echo '#!/bin/bash\ncurl -sL1 https://nubit.sh | bash' > /usr/local/bin/start-nubit.sh \
    && chmod +x /usr/local/bin/start-nubit.sh

# 将脚本作为容器启动命令运行
CMD ["bash", "-c", "/usr/local/bin/start-nubit.sh"]



#创建docker
#docker build -t nubit-node-10 .
#运行docker
#docker run -d --name nubit-node-10 nubit-node-10
#检查节点日志
#docker logs -f nubit-node-10 
#执行容器中的命令  -- 查询地址
#docker exec -it nubit-node-10 bash -c "$HOME/nubit-node/bin/nkey list --p2p.network nubit-alphatestnet-1 --node.type light"
#查询秘钥助记词
#docker exec -it nubit-node-10 cat ~/nubit-node/mnemonic.txt