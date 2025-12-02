# sys_monitor.sh 파일 수정 (search_process 함수)

search_process() {
    read -p "검색할 프로세스 키워드를 입력하세요 (예: python, node, httpd): " keyword

    echo -e "\n[🔍 '$keyword' 프로세스 검색 결과 (PID, CPU, MEM)]"
    
    # WSL(Linux) 표준 명령어인 ps -aux 사용 (CPU, MEM 정보를 포함)
    ps -aux | grep "$keyword" | grep -v "grep" | awk '
        BEGIN {
            print "PID\tUSER\t%CPU\t%MEM\tCMD";
            print "------------------------------------------------";
        }
        # 첫 번째 라인(헤더) 건너뛰기
        NR > 1 {
            # 표준 ps -aux 포맷: $1=USER, $2=PID, $3=%CPU, $4=%MEM, ... $11=CMD
            # CMD는 11번째 필드부터 끝까지 합칩니다.
            cmd = "";
            for (i=11; i<=NF; i++) cmd = cmd " " $i;
            
            # $2(PID), $1(USER), $3(%CPU), $4(%MEM), CMD 출력
            printf "%-7s\t%-8s\t%-4s\t%-4s\t%s\n", $2, $1, $3, $4, cmd;
        }'
}