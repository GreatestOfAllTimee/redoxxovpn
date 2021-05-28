clear
echo "-----------=[ Redoxxo Malaysian Vps Script ]=-----------" | lolcat
echo "-----------=[ Pakya Malay Telco Vpn Trick  ]=-----------" | lolcat
echo -e "" 
echo -e "[1] Usernew"
echo -e "[2] Delete"
echo -e "[3] Trial"
echo -e "[4] Check"
echo -e "[5] Member"
echo -e "[6] Live"
echo -e "[7] Information Server"
echo -e "[8] Restart Port"
echo -e "[9] Reboot Server"
echo -e "[10] Speed Test"
echo -e "[11] Check Memory"
echo -e "[12] Check Port"
echo -e "[13] Status Port"
echo -e "[14] Contact Developer Script"
echo -e "[15] About"
echo -e "[16] Webmin"
echo -e "[17] SHADOWSOCKS"
echo -e ""
read -p "Enter your choice : " Answer 

# Function Usernew
if [[ $Answer =~ ^([1])$ ]]
        then
            clear
            usernew
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Usernew
            if [[ $Usernew =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Delete
if [[ $Answer =~ ^([2])$ ]]
        then
            clear
            delete
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Delete
            if [[ $Delete =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Trial
if [[ $Answer =~ ^([3])$ ]]
        then
            clear
            trial
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Trial
            if [[ $Trial =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Check
if [[ $Answer =~ ^([4])$ ]]
        then
            clear
            cek
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Check
            if [[ $Check =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Member
if [[ $Answer =~ ^([5])$ ]]
        then
            clear
            member
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Member
            if [[ $Member =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Live
if [[ $Answer =~ ^([6])$ ]]
        then
            clear
            live
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Live
            if [[ $Live =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Info
if [[ $Answer =~ ^([7])$ ]]
        then
            clear
            info
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Info
            if [[ $Info =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Restart
if [[ $Answer =~ ^([8])$ ]]
        then
            clear
            restart
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Restart
            if [[ $Restart =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Reboot
if [[ $Answer =~ ^([9])$ ]]
        then
            clear
            reboot
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Reboot
            if [[ $Reboot =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Speedtest
if [[ $Answer =~ ^([10])$ ]]
        then
            clear
            speedtest
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Speedtest
            if [[ $Speedtest =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi

# Function Webmin
if [[ $Answer =~ ^([11])$ ]]
        then
            clear
            webmin
            echo -e "[0] Back to Menu"
            echo -e ""
            read -p "Enter your choice : " Webmin
            if [[ $Webmin =~ ^([0])$ ]]
                then
                    clear
                    redoxxo
                else
                    echo -e ""
            fi

        else
            echo -e ""
fi
