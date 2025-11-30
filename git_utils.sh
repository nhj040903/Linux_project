#!/bin/bash

get_git_status() {
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "❌ 경고: 현재 디렉토리는 Git Repository가 아닙니다."
        return 1
    fi

    local branch_name=$(git branch --show-current)
    local changes=$(git status -s | wc -l)

    echo -e "\n[💡 Git 상태 요약]"
    echo -e "  - 현재 브랜치: \e[33m$branch_name\e[0m"

    if [ $changes -eq 0 ]; then
        echo -e "  - 변경 사항: \e[32m커밋/스테이징할 변경 사항 없음\e[0m"
    else
        echo -e "  - 변경 사항: \e[31m$changes개의 추적 중인 변경 사항이 있습니다.\e[0m"
        git status -s
    fi
}

get_git_log() {
    echo -e "\n[📜 최근 5개 커밋 로그]"
    git log --pretty=format:"%Cred%h%Creset - %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" -n 5
}