#!/bin/bash

source git_utils.sh
source sys_monitor.sh
source alert_logic.sh

show_menu() {
    echo "========================================="
    echo "🚀 프로젝트 상태 & 시스템 모니터링 툴"
    echo "========================================="
    echo "1. Git 상태 요약 확인"
    echo "2. 최근 커밋 로그 확인"
    echo "3. 프로세스 검색 및 확인"
    echo "4. 시스템 리소스 상태 및 경고"
    echo "5. 종료"
    echo "-----------------------------------------"
    read -p "번호를 선택하세요: " choice
}

while true; do
    show_menu
    case $choice in
        1)
            clear
            echo "### 1. Git 상태 요약 확인 (기능 1) ###"
            get_git_status   
            ;;
        2)
            clear
            echo "### 2. 최근 커밋 로그 확인 (기능 2) ###"
            get_git_log      
            ;;
        3)
            clear
            echo "### 3. 프로세스 검색 및 확인 (기능 3) ###"
            search_process    
            ;;
        4)
            clear
            echo "### 4. 시스템 리소스 상태 및 경고 (기능 9) ###"
            check_system_health 
            ;;
        5)
            echo "프로그램을 종료합니다."
            break
            ;;
        *)
            echo "잘못된 선택입니다. 다시 시도해 주세요."
            ;;
    esac
    echo -e "\n엔터를 눌러 메인 메뉴로 돌아갑니다."
    read -s
    clear
done