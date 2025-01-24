#!/vendor/bin/sh

export PATH=/vendor/bin

alog()
{
    log -t init_kswapd_sh "$*"
}

get_kswapd_pid()
{
    # kswapd0 is a kernel thread created at boot time, so look through
    # pids in sorted order to find it.  The pid for kswapd is in the
    # low 100's (in v69 it is 115 on eureka and 155 on hollywood), so
    # try up to pid 500 just in case.
    pid=1
    while [ $pid -lt 500 ]; do
        if [ -d "/proc/${pid}" ]; then
            read comm < "/proc/${pid}/comm"
            if [ "${comm}" == "kswapd0:0" ]; then
                echo "${pid}"
                return
            fi
        fi
        pid=$((pid + 1))
    done
    echo ""
}

set_kswapd_cgroup()
{
    cgroup="${1}"
    kswapd_pid="$(get_kswapd_pid)"

    alog "kswapd_pid=${kswapd_pid} cgroup=${cgroup}"
    /vendor/bin/echo "${kswapd_pid}" > /dev/cpuset/"${cgroup}"/tasks
}

alog "starting with args: $@"

if [ $# -eq 1 ]; then
    set_kswapd_cgroup $1
else
    exit 1
fi
