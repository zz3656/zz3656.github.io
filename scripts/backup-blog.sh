#!/bin/bash
# 检查博客源文件是否有变动，如有则备份到 hexo-blog-source 仓库
# 使用方式: bash backup-blog.sh

BLOG_SRC="/home/ceasar/workspace/my-blog/source"
BACKUP_REPO="/home/ceasar/workspace/hexo-blog-source"
GIT_REMOTE="https://github.com/zz3656/hexo-blog-source.git"

cd "$BACKUP_REPO" || exit 1

# 检查 working tree 是否有变化
if git diff --quiet && git diff --quiet --cached; then
    echo "[$(date)] 博客源文件无变动，无需备份"
    exit 0
fi

# 有变动，add 并 commit
git add "$BLOG_SRC"
git commit -m "backup: $(date '+%Y-%m-%d %H:%M:%S')"

# push 到远程
git push "$GIT_REMOTE" master

echo "[$(date)] 博客源文件已备份到 hexo-blog-source 仓库"