#!/bin/bash
# =================================================================
# Website Info Crack by f4rdin


# --- Colors for better UI ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_CYAN='\033[0;36m'
C_BOLD='\033[1m'

# --- Helper Functions ---
# Clears the screen and prints a standard header
print_header() {
    clear
    echo -e "${C_BOLD}${C_BLUE}======================================================${C_RESET}"
    echo -e "${C_BOLD}${C_CYAN}         $SCRIPT_NAME (v$VERSION) by f4rdin         ${C_RESET}"
    echo -e "${C_BOLD}${C_BLUE}======================================================${C_RESET}"
}

# Removes protocol (http/https) and any trailing paths from a domain
sanitize_domain() {
    local domain_input="$1"
    # Remove protocol and everything after the first '/'
    echo "$domain_input" | sed -E 's|^(https?://)?([^/]+).*|\2|'
}

# Checks if a required command is installed
check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        echo -e "${C_YELLOW}Warning:${C_RESET} Command '$1' is not found. Some features may not work."
        echo -e "         Please install it (e.g., ${C_CYAN}sudo apt install $1${C_RESET})"
        return 1
    fi
    return 0
}

# --- Feature Functions ---
# Fetches IPv4 and IPv6 addresses for the domain
get_ip_address() {
    local domain="$1"
    echo -e "\n${C_BOLD}[🔍 IP Lookup for: $domain]${C_RESET}"
    check_dependency "dig" || return

    local ipv4=$(dig +short A "$domain" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | tr '\n' ' ')
    local ipv6=$(dig +short AAAA "$domain" | tr '\n' ' ')

    if [[ -n "$ipv4" ]]; then
        echo -e "${C_GREEN}IPv4 Addresses:${C_RESET} $ipv4"
    else
        echo -e "${C_YELLOW}No IPv4 address found.${C_RESET}"
    fi

    if [[ -n "$ipv6" ]]; then
        echo -e "${C_GREEN}IPv6 Addresses:${C_RESET} $ipv6"
    else
        echo -e "${C_YELLOW}No IPv6 address found.${C_RESET}"
    fi
}

# Fetches full WHOIS details
get_whois_details() {
    local domain="$1"
    echo -e "\n${C_BOLD}[📜 Full WHOIS for: $domain]${C_RESET}"
    check_dependency "whois" || return
    whois "$domain"
}

# Fetches a summary of WHOIS details
short_whois_details() {
    local domain="$1"
    echo -e "\n${C_BOLD}[📜 WHOIS Summary for: $domain]${C_RESET}"
    check_dependency "whois" || return
    whois "$domain" | head -n 25
}

# Checks website uptime via HTTP status code
check_uptime() {
    local domain="$1"
    echo -e "\n${C_BOLD}[🚦 Uptime Check for: $domain]${C_RESET}"
    check_dependency "curl" || return

    # Use curl with flags: -s (silent), -o /dev/null (discard output), -w (write out format),
    # -L (follow redirects), --connect-timeout (max time for connection)
    local code=$(curl -s -o /dev/null -w "%{http_code}" "https://$domain" -L --connect-timeout 10)

    # Fallback to http if https fails or times out
    if [ "$code" = "000" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "http://$domain" -L --connect-timeout 10)
    fi

    echo -en "${C_CYAN}HTTP Status Code: $code${C_RESET} - "
    case "$code" in
        2*) echo -e "${C_GREEN}Website is UP and running perfectly.${C_RESET}" ;;
        3*) echo -e "${C_GREEN}Website is UP (via redirection).${C_RESET}" ;;
        4*) echo -e "${C_YELLOW}Website is reachable, but returned a Client Error (e.g., Not Found).${C_RESET}" ;;
        5*) echo -e "${C_RED}Website is reachable, but returned a Server Error.${C_RESET}" ;;
        000) echo -e "${C_RED}Website is DOWN or unreachable.${C_RESET}" ;;
        *) echo -e "${C_YELLOW}Website is reachable, but with an unusual status code.${C_RESET}" ;;
    esac
}

# Measures the total response time of the website
check_speed() {
    local domain="$1"
    echo -e "\n${C_BOLD}[⚡ Speed Test for: $domain]${C_RESET}"
    check_dependency "curl" || return

    local time_total=$(curl -s -o /dev/null -w "%{time_total}" "https://$domain" -L --connect-timeout 10)

    # Fallback to http if https fails
    if [[ $(echo "$time_total == 0" | bc -l) -eq 1 ]]; then
        time_total=$(curl -s -o /dev/null -w "%{time_total}" "http://$domain" -L --connect-timeout 10)
    fi

    if [[ -n "$time_total" && $(echo "$time_total > 0" | bc -l) -eq 1 ]]; then
        echo -e "${C_CYAN}Total Response Time:${C_RESET} ${time_total}s"
        if command -v bc &>/dev/null; then
            if (( $(echo "$time_total < 0.5" | bc -l) )); then
                echo -e "${C_GREEN}Performance: Excellent${C_RESET}"
            elif (( $(echo "$time_total < 1.5" | bc -l) )); then
                echo -e "${C_GREEN}Performance: Good${C_RESET}"
            else
                echo -e "${C_YELLOW}Performance: Slow${C_RESET}"
            fi
        fi
    else
        echo -e "${C_RED}Could not measure response time. The site might be down.${C_RESET}"
    fi
}

# --- Interactive Menu Logic ---
interactive_menu() {
    local domain="$1"
    while true; do
        print_header
        echo -e "Selected Domain: ${C_BOLD}${C_YELLOW}$domain${C_RESET}"
        echo -e "${C_BLUE}------------------------------------------------------${C_RESET}"
        echo "1) IP Address Lookup"
        echo "2) Full WHOIS Details"
        echo "3) Uptime Check"
        echo "4) Speed Check"
        echo -e "${C_CYAN}A) Run All Checks${C_RESET}"
        echo "C) Change Domain"
        echo -e "${C_RED}Q) Quit${C_RESET}"
        echo -e "${C_BLUE}------------------------------------------------------${C_RESET}"
        read -r -p "Choose an option: " opt

        case "$opt" in
            1) get_ip_address "$domain" ;;
            2) get_whois_details "$domain" ;;
            3) check_uptime "$domain" ;;
            4) check_speed "$domain" ;;
            [Aa])
                get_ip_address "$domain"
                short_whois_details "$domain"
                check_uptime "$domain"
                check_speed "$domain"
                ;;
            [Cc])
                read -r -p "Enter new domain: " new_domain
                if [[ -n "$new_domain" ]]; then
                    domain=$(sanitize_domain "$new_domain")
                fi
                continue
                ;;
            [Qq]) echo -e "\n${C_BOLD}Goodbye!${C_RESET}"; exit 0 ;;
            *) echo -e "\n${C_RED}Invalid option. Please try again.${C_RESET}" ;;
        esac
        echo
        read -r -p "Press ENTER to continue..."
    done
}

# --- Main Execution Logic ---
main() {
    # If a domain is provided as an argument, run in non-interactive mode
    if [[ -n "$1" ]]; then
        local target_domain=$(sanitize_domain "$1")
        print_header
        echo -e "${C_BOLD}Running all checks for: ${C_YELLOW}$target_domain${C_RESET}"
        get_ip_address "$target_domain"
        short_whois_details "$target_domain"
        check_uptime "$target_domain"
        check_speed "$target_domain"
        echo -e "\n${C_BOLD}${C_GREEN}All checks complete.${C_RESET}"
        exit 0
    fi

    # Otherwise, start the interactive menu
    print_header
    local target_domain
    read -r -p "Enter website domain (e.g., google.com): " target_domain
    if [[ -z "$target_domain" ]]; then
        echo -e "\n${C_RED}No domain entered. Exiting.${C_RESET}"
        exit 1
    fi
    target_domain=$(sanitize_domain "$target_domain")
    interactive_menu "$target_domain"
}

# Pass all script arguments to the main function
main "$@"


