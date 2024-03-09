check_srv_record() {
    IP=$(dig +short ${1})
    PORT=$(dig +short _minecraft._tcp.${1} SRV | awk '{print $3}')
    echo $IP $PORT
}