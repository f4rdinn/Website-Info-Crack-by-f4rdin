# 🌐 Website Info Crack by f4rdin

A powerful and user-friendly **Bash tool** that allows you to gather key information about any website — including IP lookup, WHOIS data, uptime status, and response speed. Designed for Linux terminal users with a clean and colorful interface.

---

## 🚀 Features

* 🔍 **IP Lookup:** Fetch both IPv4 and IPv6 addresses of any website.
* 📜 **WHOIS Lookup:** Get complete domain registration information.
* 🚦 **Uptime Check:** Verify if the website is up or down via HTTP status codes.
* ⚡ **Speed Test:** Measure total response time and performance level.
* 🧠 **Smart Detection:** Automatically detects and cleans malformed URLs.
* 🎨 **Interactive Menu:** Navigate easily through options with a clean UI.

---

## ⚙️ Requirements

Make sure the following dependencies are installed:

```bash
sudo apt install curl dig whois bc
```

All commands used in this script are lightweight and available in most Linux systems by default.

---

## 🧩 Installation

Clone the repository and make the script executable:

```bash
git clone https://github.com/f4rdinn/Website-Info-Crack-by-f4rdin.git
cd Website-Info-Crack-by-f4rdin
chmod +x website_info_crack_by_f4rdin.sh
```

---

## ▶️ Usage

### **Interactive Mode:**

Run the script without arguments to enter the interactive menu.

```bash
./website_info_crack_by_f4rdin.sh
```

### **Quick Command Mode:**

Run directly with a domain to perform all checks automatically.

```bash
./website_info_crack_by_f4rdin.sh example.com
```

---

## 🧰 Example Output

```
======================================================
         Website Info Crack (v1.0) by f4rdin
======================================================
[🔍 IP Lookup for: example.com]
IPv4: 93.184.216.34

[🚦 Uptime Check for: example.com]
HTTP Status Code: 200 - Website is UP and running perfectly.

[⚡ Speed Test for: example.com]
Total Response Time: 0.214s
Performance: Excellent
```

---

## 🧑‍💻 Author

**Developed by:** [f4rdin](https://github.com/f4rdinn)

If you like this project, ⭐ the repo and share it with others!

---

## 🪪 License

This project is licensed under the **MIT License** — you can freely use, modify, and distribute it.

---

### 💡 Tip

Use this tool responsibly for educational and diagnostic purposes only. Unauthorized or malicious usage is strictly discouraged.
