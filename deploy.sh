#!/usr/bin/env sh
# 當發生錯誤時終止腳本運行
set -e

# 打包
npm run build

# 移動至到打包後的 dist 目錄 
cd dist

# dist 資料夾預設是被 ignore 的，因此在進入 dist 資料夾後初始化 git
git init
git add -A
git commit -m "deploy"
git push -f git@github.com:chaowudev/ubike-map.git master:gh-pages
cd -
