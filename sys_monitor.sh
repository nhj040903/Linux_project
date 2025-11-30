#!/bin/bash

# 기능 3: 프로세스 목록 검색 및 출력
search_process() {
    read -p "검색할 프로세스 키워드를 입력하세요 (예: python, node, httpd): " keyword

    echo -e "\n[🔍 '$keyword' 프로세스 검색 결과 (PID, CPU, MEM)]"
    
    # ps -ef 결과를 파이프와 awk로 필터링하고 컬럼을 추출합니다.
    # $2=PID, $8+=CMD, $3=PPID, $6=TTY
    ps -ef | grep "$keyword" | grep -v "grep" | awk '
        BEGIN {
            print "PID\tUSER\t%CPU\t%MEM\tCMD";
            print "------------------------------------------------";
        }
        {
            # CMD를 8번째 필드부터 끝까지 합칩니다.
            cmd = "";
            for (i=8; i<=NF; i++) cmd = cmd " " $i;
            
            # PID, 사용자, %CPU, %MEM, CMD
            printf "%-7s\t%-8s\t%-4s\t%-4s\t%s\n", $2, $1, $3, $4, cmd;
        }'
    
    if [ $? -ne 0 ]; then
        echo "❌ 프로세스 검색 중 오류가 발생했거나 검색 결과가 없습니다."
    fi
}