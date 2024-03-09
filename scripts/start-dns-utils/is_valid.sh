is_valid_int() {
    # Check if the string contains only digits
    if [[ $1 =~ ^[0-9]+$ ]]; then
        return 0 # Success, valid integer
    else
        return 1 # Failure, not a valid integer
    fi
}

is_valid_ip() {
    # Check if either IPv4 or IPv6 validations pass
    if  is_valid_ipv4 "$1" || is_valid_ipv6 "$1"; then
        return 0 # At least one test passed
    else
        return 1 # Both tests failed
    fi
}

is_valid_ipv4() {
    # Regular expression to match a valid IPv4 address
    local ipv4_regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    # Check if the string matches the regex
    if [[ $1 =~ $ipv4_regex ]]; then
        # Split the string into octets
        IFS='.' read -r -a octets <<< "$1"
        for octet in "${octets[@]}"; do
            if (( $octet < 0 || $octet > 255 )); then
                return 1 # Invalid octet value
            fi
        done
        return 0 # Success, valid IPv4 address
    else
        return 1 # Failure, not a valid IPv4 address
    fi
}

is_valid_ipv6() {
    # Regular expression to match a valid IPv6 address
    local ipv6_regex="^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){6}(:[0-9a-fA-F]{1,4})|(([0-9a-fA-F]{1,4})?::([0-9a-fA-F]{1,4}:){0,5}[0-9a-fA-F]{1,4})|([0-9a-fA-F]{1,4}::([0-9a-fA-F]{1,4}:){0,4}[0-9a-fA-F]{1,4})|(([0-9a-fA-F]{1,4}:){0,2}[0-9a-fA-F]{1,4})?::([0-9a-fA-F]{1,4}:){0,3}[0-9a-fA-F]{1,4}|(([0-9a-fA-F]{1,4}:){0,3}[0-9a-fA-F]{1,4})?::([0-9a-fA-F]{1,4}:){0,2}[0-9a-fA-F]{1,4}|(([0-9a-fA-F]{1,4}:){0,4}[0-9a-fA-F]{1,4})?::[0-9a-fA-F]{1,4}|(([0-9a-fA-F]{1,4}:){0,5}[0-9a-fA-F]{1,4})?::)"

    # Check if the string matches the regex
    if [[ $1 =~ $ipv6_regex ]]; then
        return 0 # Success, valid IPv6 address
    else
        return 1 # Failure, not a valid IPv6 address
    fi
}
