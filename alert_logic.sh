#!/bin/bash

# 시스템 리소스 임계값 설정 (필요에 따라 값 조정)
MIN_FREE_MEM_MB=500  # 최소 사용 가능 메모리 (MB)
MAX_LOAD_AVG=2.0     # 5분 평균 로드 임계값

# 기능 9: 시스템 리소스 상태 확인 및 경고
check_system_health() {
    echo -e "[📊 시스템 리소스 상태]"
    
    # 1. 메모리 확인
    # free -m에서 Available Memory (사용 가능 메모리) 추출
    local free_mem=$(free -m | awk '/^Mem:/ {print $7}')
    
    echo -e "  - 사용 가능 메모리: \e[33m${free_mem}MB\e[0m (임계값: ${MIN_FREE_MEM_MB}MB)"
    if [ "$free_mem" -lt "$MIN_FREE_MEM_MB" ]; then
        echo -e "  \e[41m\e[37m🚨 경고: 사용 가능 메모리가 임계값보다 낮습니다! 시스템 성능 저하 우려.\e[0m"
    fi
    
    # 2. 로드 평균 확인 (Load Average - 5분 평균)
    # uptime 명령 결과 중 5분 평균 로드만 추출 (예: 'load average: 0.50, 0.45, 0.40' 에서 0.45)
    local load_avg_5m=$(uptime | awk -F'load average: ' '{print $2}' | cut -d',' -f2 | tr -d ' ')
    
    # Shell에서 소수점 비교를 위해 임시로 정수로 변환 (예: 2.0 -> 20, 0.50 -> 5)
    local load_int=$(echo $load_avg_5m | tr -d '.' | cut -c1-3)
    local max_int=$(echo $MAX_LOAD_AVG | tr -d '.' | cut -c1-3)
    
    echo -e "  - 5분 평균 로드: \e[33m${load_avg_5m}\e[0m (임계값: ${MAX_LOAD_AVG})"

    if [ "$load_int" -gt "$max_int" ]; then
        echo -e "  \e[41m\e[37m🚨 경고: 시스템 로드 평균이 높습니다. CPU 부하가 높을 수 있습니다.\e[0m"
    fi
}