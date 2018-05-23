#!/bin/bash
date >> /var/log/v2ray/update.log
bash <(curl -L -s https://install.direct/go.sh) >> /var/log/v2ray/update.log
