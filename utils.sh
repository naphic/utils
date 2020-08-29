#!/bin/bash
# This script is meant to provide useful utilities to aid in troubleshooting macs. Thank you Kevin for the very creative menu title and suggestions on wording.
while [ "$sel" != q ]
do
    clear
    echo "**Just Understanding System and Testing Internal Nuances**"
    echo "       **CPU Hammering And Processing In Nuisances**"
    echo "" 
    echo "------------"
    echo "Pick one of the following, but don't mess up, one of them blows up!"
    echo ""
    echo "1. Find and view kernel panics in logs"
    echo "2. Analyze Disk Usage to discover the largest files and folders"
    echo "3. Perform stress test on this unit"
    echo "4. Stop a stress test that is already in progress"
    echo "q. Enter q to quit"
    echo ""
    echo "------------" 
    echo -n "Enter choice and press enter, please and thank you..: "; read sel

    case  $sel  in
        1)       
            clear
            if [[ -n $(find /Library/Logs -iname kernel*panic) ]]; then
                echo "Detected $(find /Library/Logs -iname kernel*panic | wc -l| awk '{print $1}') Kernel panic(s) in the logs."
                for log in $(find /Library/Logs -iname kernel*panic); do
                    echo -n "Would you like to read kernel panic log "$log"?(y for yes n for no): "; read stat
                    if [ "$stat" == y -o "$stat" == yes ]; then
                        osascript -e 'tell application "Terminal" to do script "less '$log'"' > /dev/null
                    fi
                done
            else
                echo "No panics detected in logs"
                read -n 1 -s -r -p "Press any key to continue"
            echo "................................................................................"
            fi
            ;;
        2)
            clear
            echo "Storage Analysis"
            echo "================================================================================"
            echo -e "After you select from the menu below, the folders and files will be listed in descending order.\nWhen you are done viewing the report, press q to exit to the main menu"
            echo "================================================================================"
            echo "1. Analyze Home Directory"
            echo "2. Analyze entire drive starting from root dir (May take a long time and requires login/admin password)"
            echo ""
            echo -n "Enter Choice: " ; read choice
            if [ "$choice" == 2 ] ; then
                sudo du -ah / | sort -hr | less
            elif [ "$choice" == 1 ] ;then
                du -ah ~ | sort -hr | less
            fi
            ;;            
        3)
            clear
            echo "Initializing stress test. Please wait..."
            echo "................................................................................"
            for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & disown; done
            echo "................................................................................"
            echo "................................................................................"
            echo "Stress test started."
            open -a /Applications/Utilities/Activity\ Monitor.app
            open /Library/Application\ Support/Apple/Grapher/Examples/3D\ Examples/*
            open -a /Applications/Safari.app https://www.youtube.com/watch?v=SkgTxQm9DWM
            osascript -e 'tell application "Terminal" to do script "cat /dev/urandom | hexdump -C"' > /dev/null
            osascript -e 'tell application "Terminal" to do script "top"' > /dev/null
            ;;
       4)
            clear
            killall yes Grapher Activity\ Monitor hexdump 
            ;;

        *)              
    esac
done
