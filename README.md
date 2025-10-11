Website Info Crack by f4rdin
সংস্করণ: 1.0.0
লক্ষ্য: টার্মিনাল থেকে দ্রুত কোনো ওয়েবসাইটের IP (A/AAAA), WHOIS তথ্য, HTTP/HTTPS স্ট্যাটাস ও প্রাথমিক রেসপন্স-টাইম দেখা।
গুরুত্বপূর্ণ: স্ক্রিপ্টটি কোনো SSH/পাসওয়ার্ড/কি ব্যবহার করে না — শুধুমাত্র লোকাল কমান্ড (dig, whois, curl, bc) চালায়।
বৈশিষ্ট্যসমূহ
IPv4 ও IPv6 (A/AAAA) লুকআপ (dig)
পুরো WHOIS ও সংক্ষিপ্ত WHOIS সারাংশ (whois)
HTTP/HTTPS আপটাইম চেক (HTTP স্ট্যাটাস কোড) (curl)
মোট রেসপন্স-টাইম পরিমাপ (curl, bc — ঐচ্ছিক)
ইন্টারঅ্যাকটিভ মেনু মোড এবং নন-ইন্টারঅ্যাকটিভ মোড (ডোমেইন আরগুমেন্ট হিসেবে পাস করা যায়)
রঙিন টার্মিনাল আউটপুট (পাঠযোগ্যতার জন্য)
প্রয়োজনীয়তা (Dependencies)
bash
dig (প্যাকেজ: dnsutils অর্থাৎ Debian/Ubuntu-তে dnsutils)
whois
curl
bc (ঐচ্ছিক — সংখ্যা তুলনার জন্য)
Debian/Ubuntu-এ ইনস্টল:
sudo apt update
sudo apt install -y dnsutils whois curl bc
দ্রুত সেটআপ (1 মিনিট)
রেপো ক্লোন বা নতুন রিপো তৈরি করুন।
স্ক্রিপ্ট ফাইল (উদাহরণ: website_info.sh) রিপো-তে যোগ করুন।
executable করতে:
chmod +x website_info.sh
ব্যবহার (Usage)
ইন্টারঅ্যাকটিভ মোড
কোনো আর্গুমেন্ট বাদ দিলে মেনু ওপেন হবে:
./website_info.sh
মেনু থেকে ডোমেইন দিন এবং অপশন নির্বাচন করুন — IP, WHOIS, Uptime, Speed অথবা সবগুলো চালান।
নন-ইন্টারঅ্যাকটিভ (একসাথে সব চেক)
এক লাইনেই সব চেক চালাতে:
./website_info.sh example.com
আউটপুট ফাইল হিসাবে সেভ করা
টার্মিনাল আউটপুট একই সঙ্গে ফাইলেও রাখতে চাইলে:
./website_info.sh example.com | tee website_info_example.com.txt
আউটপুট উদাহরণ
IPv4 Addresses: 1.2.3.4
IPv6 Addresses: 2001:db8::1
HTTP Status Code: 200 — Website is UP and running.
Total Response Time: 0.34s — Performance: Excellent
(WHOIS আউটপুট সরাসরি WHOIS সার্ভার থেকে আসে; তাই দেখা যাবে রেজিস্ট্রেশন ডিটেইলস।)
নিরাপত্তা ও গোপনীয়তা (Security & Privacy)
স্ক্রিপ্টটি কেবল রিড-ওনলি কুয়েরি করে (DNS, WHOIS, HTTP)।
কোনো ধরনের SSH/লগইন/পাসওয়ার্ড/কি অনুরোধ করে না।
WHOIS আউটপুটে কখনও ব্যক্তিগত কন্ট্যাক্ট ডিটেইল থাকতে পারে — লক্ষ্য রাখুন।
