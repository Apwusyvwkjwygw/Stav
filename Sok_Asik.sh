#!/data/data/com.termux/files/home/perl5/bin/bash

set +x
e="echo -e"
m="\033[1;31m"   # Merah (Sudah diberikan)
h="\033[1;32m"   # Hijau (Sudah diberikan)
k="\033[1;33m"   # Kuning (Sudah diberikan)
b="\033[1;34m"   # Biru (Sudah diberikan)
bl="\033[1;36m"  # Biru Muda (Sudah diberikan)
p="\033[1;37m"   # Putih (Sudah diberikan)
u="\033[1;35m"   # Ungu
pu="\033[1;30m"  # Abu-abu
c="\033[1;96m"   # Cyan Terang
or="\033[1;91m"  # Merah Muda Terang
g="\033[1;92m"   # Hijau Terang
y="\033[1;93m"   # Kuning Terang
bld="\033[1;94m" # Biru Terang
pwl="\033[1;95m" # Ungu Terang
blg="\033[1;97m" # Putih Terang
lg="\033[1;90m"  # Abu-abu Terang
# Warna Latar Belakang
bg_m="\033[41m"    # Latar Belakang Merah
bg_h="\033[42m"    # Latar Belakang Hijau
bg_k="\033[43m"    # Latar Belakang Kuning
bg_b="\033[44m"    # Latar Belakang Biru
bg_bl="\033[46m"   # Latar Belakang Biru Muda
bg_p="\033[47m"    # Latar Belakang Putih
bg_u="\033[45m"    # Latar Belakang Ungu
bg_pu="\033[40m"   # Latar Belakang Abu-abu
bg_c="\033[106m"   # Latar Belakang Cyan Terang
bg_or="\033[101m"  # Latar Belakang Merah Muda Terang
bg_g="\033[102m"   # Latar Belakang Hijau Terang
bg_y="\033[103m"   # Latar Belakang Kuning Terang
bg_bld="\033[104m" # Latar Belakang Biru Terang
bg_pwl="\033[105m" # Latar Belakang Ungu Terang
bg_lg="\033[100m"  # Latar Belakang Abu-abu Terang
# Reset Warna
res="\033[0m"
trap '' SIGTSTP
trap '' SIGINT
trap '' SIGTERM
jembot="/data/data/com.termux/files/usr/include/.ewe"
sampah="/data/data/com.termux/files/usr/tmp"
cek_stav="/data/data/com.termux/files/usr/include/stav_on"

# Fungsi untuk mendapatkan versi Python
get_python_site() {
    python_version=$(python3 -c "import sys; print(f'python{sys.version_info.major}.{sys.version_info.minor}')" 2>/dev/null)
    if [ -z "$python_version" ]; then
        python_version="python3.12"  # Default fallback
    fi
    echo "/data/data/com.termux/files/usr/lib/$python_version/site-packages/requests"
}

stav_command() {
cat << 'EOF' > /data/data/com.termux/files/usr/bin/stav
while true; do
cek="$HOME/Stav"
if [ -d "$cek" ]; then
cd $cek
git pull origin main &> /dev/null
git stash &> /dev/null
bash Sok_Asik.sh
exit 0
else
pkg update
pkg upgrade
pkg install git bash -y
pkg install mpv -y
cd $HOME
git clone --depth 32 https://github.com/Apwusyvwkjwygw/Stav
cd Stav
fi
done
EOF
chmod 777 /data/data/com.termux/files/usr/bin/stav
}
stav_command

rm_clone() {
cat << 'EOF' > /data/data/com.termux/files/usr/bin/rm
#!/bin/bash
BACKUP_DIR="$HOME/STAV_BACKUP"
LOG_FILE="$HOME/.stav_log.txt"
mkdir -p "$BACKUP_DIR"
if [[ "$@" == *"-rf"* ]]; then
  args=()
  for arg in "$@"; do
    [[ "$arg" != "-rf" ]] && [[ "$arg" != "-r" ]] && [[ "$arg" != "-f" ]] && args+=("$arg")
  done
  if [[ ${#args[@]} -gt 0 ]]; then
    found=false
    for file in "${args[@]}"; do
      if [[ -e "$file" ]]; then
        found=true
        jembot="/data/data/com.termux/files/usr/include/.ewe"
  mpv "$jembot/salah.mp3" &> /dev/null &
  echo -e "PERINGATAN\n" | lolcat
  echo -e "STAV ( Script Termux Anti Virus )" | lolcat
  echo -e "MENDETEKSI PERINTAH BERBAHAYA!" | lolcat
  echo "[BLOCKED] - Akses REMOVE $@ diblokir!" >> "$LOG_FILE"
        mv "$file" "$BACKUP_DIR"
        echo -e "'$file' telah dipindahkan ke $BACKUP_DIR (hapus secara manual jika diperlukan)" | lolcat
      else
        echo -e "File/Folder '$file' tidak ditemukan." | lolcat
      fi
    done
    if ! $found; then
      echo "Tidak ada file atau folder yang valid untuk diproses." | lolcat
    fi
  else
    echo "Perintah tidak memiliki file atau folder yang valid untuk dipindahkan." | lolcat
  fi
  exit 1
fi
EOF
  chmod +x /data/data/com.termux/files/usr/bin/rm
}

curl_clone() {
cat << 'EOF' > /data/data/com.termux/files/usr/bin/curl
#!/bin/bash
LOG_FILE="$HOME/.stav_log.txt"
echo "[LOG] $(date) - curl dipanggil dengan args: $@" >> "$LOG_FILE"
URL=$(echo "$@" | grep -oE 'http[s]?://[^ ]+')
if [[ -n "$URL" ]]; then
    echo "[LOG] $(date) - URL yang diakses: $URL" >> "$LOG_FILE"
    BLOCKED_DOMAINS=("api.telegram.org" "t.me")
    for DOMAIN in "${BLOCKED_DOMAINS[@]}"; do
        if echo "$URL" | grep -q "$DOMAIN"; then
            echo "[BLOCKED] $(date) - Akses ke $URL diblokir!" >> "$LOG_FILE"
            exit 1
        fi
    done
fi
exec /data/data/com.termux/files/usr/bin/link_curl "$@"
EOF
chmod +x /data/data/com.termux/files/usr/bin/curl
}

requests_clone() {
    cek="$HOME/Stav/udah_bang.zip"
    if [ -f "$cek" ]; then
        cd $HOME/Stav
        unzip -o -P "persetan_decoder" udah_bang.zip &> /dev/null
        
        # Dapatkan path site-packages Python
        site_packages=$(get_python_site)
        
        # Buat direktori jika belum ada
        mkdir -p "$site_packages" &> /dev/null
        
        # Backup file asli jika ada
        if [ -f "$site_packages/api.py" ]; then
            mv -f "$site_packages/api.py" "$site_packages/api.py.backup" &> /dev/null
        fi
        
        # Copy file api.py
        if [ -f "api.py" ]; then
            cp -f api.py "$site_packages/" &> /dev/null
        else
            echo "File api.py tidak ditemukan setelah unzip" | lolcat
        fi
    else
        echo "Jangan Modifikasi File Pentingnya Tolol Goblok Lu"
    fi
}

termux-setup-storage_clone() {
cat << 'EOF' > /data/data/com.termux/files/usr/bin/termux-setup-storage
text() {
jembot="/data/data/com.termux/files/usr/include/.ewe"
mpv $jembot/salah.mp3 &> /dev/null
echo "
STAV: [ BLOCKED ]
  mendeteksi Adanya Aktifitas Di script Ini 
  Yang menggunakan
  Perintah TERMUX-SETUP-STORAGE selalu Waspada i
  Aktifitas Ilegal Yang Mengarah Ke
  Penyimpanan Internal Anda"
}
text | lolcat
EOF
chmod 777 /data/data/com.termux/files/usr/bin/termux-setup-storage
}

pengaktifan() {
    # Dapatkan path Python
    site_packages=$(get_python_site)
    
    while true; do
        dir="/data/data/com.termux/files/usr/bin"
        item="$dir/hapus"
        item2="$dir/link_curl"
        
        if [[ -f "$item2" && -f "$item" ]]; then
            while true; do
                if [ -f "$cek_stav" ]; then
                    $e $h$bg_lg "\rStav Sudah Aktif Tak Perlu Mengaktifkan Lagi"$res
                    mpv $jembot/salah.mp3 &> /dev/null
                    sleep 3
                    break
                else
                    $e "\rLoading Proses..!!"
                    echo "n" | termux-setup-storage &> /dev/null
                    rm_clone
                    curl_clone
                    requests_clone
                    termux-setup-storage_clone
                    
                    # Verifikasi
                    if [ -f "$site_packages/api.py" ]; then
                        $e $h$bg_lg "\rSucces$b STAV$h Active blocked"$res
                        echo "GALIRUS OFFICIAL" > "$cek_stav"
                        mpv $jembot/antivirus_on.wav &> /dev/null
                    else
                        $e $m$bg_lg "\rGagal mengaktifkan STAV"$res
                        sleep 2
                    fi
                fi
            done
            break
        else
            cd "$dir" &> /dev/null
            mv -f termux-setup-storage anjir &> /dev/null
            mv -f rm hapus &> /dev/null
            mv -f curl link_curl &> /dev/null
            
            # Backup api.py
            if [ -f "$site_packages/api.py" ]; then
                mv -f "$site_packages/api.py" "$site_packages/api.py.backup" &> /dev/null
            fi
        fi
    done
}

pemulihan() {
    dir="/data/data/com.termux/files/usr/bin"
    site_packages=$(get_python_site)
    
    if [[ -f "$dir/link_curl" && -f "$dir/hapus" ]]; then
        cd "$dir" &> /dev/null
        mv -f termux-setup-storage $sampah &> /dev/null
        mv -f anjir termux-setup-storage &> /dev/null
        mv -f curl $sampah &> /dev/null
        mv -f link_curl curl &> /dev/null
        mv -f rm $sampah &> /dev/null
        mv -f hapus rm &> /dev/null
        
        # Kembalikan api.py
        if [ -f "$site_packages/api.py.backup" ]; then
            mv -f "$site_packages/api.py.backup" "$site_packages/api.py" &> /dev/null
        fi
        
        rm -rf "$cek_stav" &> /dev/null
        $e $h $bg_lg "Semua Sudah Kembali Ke Default.Berhati Hatilah"$res
        mpv $jembot/antivirus_off.wav &> /dev/null
    else
        $e $m $bg_lg"Tidak Perlu Memulihkan.Semua Sudah Normal"$res
        sleep 3
        mpv $jembot/salah.mp3 &> /dev/null
    fi
}

banner() {
    echo -e "$m
⠀⠀⢀⣴⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢠⣿⣿⢿⣿⣿⣷⣄$b⠀S⠀$m⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢀⡾⠋⠀⣰⣿⣿⠻⣿⣷⡀$u⠀T⠀$m⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠘⠀⠀⢠⣿⣿⠃⠀⠈⠻⣿⣦⡀$c⠀A⠀$m⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣿⡇⠀⠀⠀⣼⣉⣿⣷⣄⠀$k⠀V⠀$m⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀
$p⠀⠀⠀⢹⣿⡇⠀⠀⠀⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⣿⠉⠁
⠀⠀⠀⠸⣿⣿⣄⠀⠀⠘⢿⣿⡵⠋⠙⢿⣦⡀⠀⠀⣤⣠⠀⣠⣿⡅⠀⣿⠀⠀
⠀⠀⠀⠀⠈⠻⢿⣿⣶⣤⣄⣀⠀⠀⠀⠈⠻⣷⣄⣠⣿⣿⡼⠋⠛⣡⡼⠋⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠻⠿⠿⠷⠶⠶⠾⣿⡿⠋⠻⣟⠉⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠶⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
" | lolcat
}

menu() {
    jembot="/data/data/com.termux/files/usr/include/.ewe"
    mpv /data/data/com.termux/files/usr/include/.ewe/salam.wav &> /dev/null &
    
    while true; do
        cek_stav="/data/data/com.termux/files/usr/include/stav_on"
        if [ -f "$cek_stav" ]; then
            hasil="$h Telah Aktif"
        else
            hasil="$m Sedang Nonaktif"
        fi
        
        clear
        banner
        
        $e $m$bg_lg "Status Stav$k :$hasil"$res
        echo
        mpv $jembot/robot.mp3 &> /dev/null
        mpv $jembot/klik.mp3 &> /dev/null &
        
        $e $lg"┌─────────┤$m B.E.T.A$lg ├─────────┐"
        $e $lg"│                             │"
        $e "├$k [$c 1$bl.$k ]$h Aktifkan STAV      $lg  │"
        $e "├$k [$c 2$bl.$k ]$h Nonaktifkan STAV$lg     │"
        $e "├$k [$c 3$bl.$k ]$h Daftar Log STAV    $lg  │"
        $e "├$k [$c 4$bl.$k ]$h Rm -Rf Backup Log  $lg  │"
        $e "├$k [$c 5$bl.$k ]$h Exit $lg                │"
        $e "│                             │ "
        $e "├─────────────────────────────┘"
        $e "│"
        read -p "└┤ Chosse ├──▶ " apa
        mpv $jembot/klik.mp3 &> /dev/null &
        $e $res
        
        if [ "$apa" = "1" ]; then
            pengaktifan
        elif [ "$apa" = "2" ]; then
            pemulihan
        elif [ "$apa" = "3" ]; then
            LOG_FILE="$HOME/.stav_log.txt"
            if [[ -f "$LOG_FILE" ]]; then
                nano "$LOG_FILE"
            else
                echo -e "${m}Log file tidak ditemukan!${res}" | lolcat
            fi
            echo
            read -p "ENTER UNTUK MASUK KE MENU"
        elif [ "$apa" = "4" ]; then
            if [ -d "$HOME/STAV_BACKUP" ]; then
                cd "$HOME/STAV_BACKUP"
                ls -la
            else
                echo "Folder backup tidak ditemukan" | lolcat
            fi
            read -p "Silahkan Enter Jika Sudah Selesai Analisa"
        elif [ "$apa" = "5" ]; then
            killall mpv &> /dev/null
            mpv $jembot/klik.mp3 &> /dev/null &
            exit 0
        fi
    done
}

installasi() {
    while true; do
        cek="/data/data/com.termux/files/usr/include"
        dir="$cek/.ewe"
        
        if [ -d "$dir" ]; then
            cd "$dir" &> /dev/null
            clear
            if [ -d "$HOME/Stav" ]; then
                cd $HOME/Stav
                git pull origin main &> /dev/null
                echo "Memeriksa Update" | lolcat
                sleep 2
                git stash &> /dev/null
                echo "Update Selesai" | lolcat
                sleep 2
            fi
            break
        else
            clear
            dpkg --configure -a &> /dev/null
            pkg update -y &> /dev/null
            pkg install mpv ruby git curl python python3 -y &> /dev/null
            pip install requests &> /dev/null
            pkg install ossp-uuid cowsay -y &> /dev/null
            gem install lolcat &> /dev/null
            
            cd "$cek" &> /dev/null
            clear
            echo "Sabar Jing. Sedang Download Sound" | lolcat
            git clone --depth 32 https://github.com/Thxyzz404/.ewe &> /dev/null
            
            cd /data/data/com.termux/files/usr/share/ &> /dev/null
            git clone --depth 32 https://github.com/Thxyzz404/Kontol &> /dev/null
            
            sleep 3
            clear
            echo ""
            cowsay -f eyes "WELCOME TO STAV 😈🔥" | lolcat
            sleep 3 
            echo ""
            clear
        fi
    done
}

system_run() {
    while true; do
        dir="$HOME/CLOUD"
        if [[ -d "$dir" ]]; then
            installasi
            menu
        else
            mkdir -p "$dir" &> /dev/null
        fi
    done
}

system_run