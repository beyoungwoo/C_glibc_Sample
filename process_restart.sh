#! /bin/bash
#
# * Reference
# http://stackoverflow.com/questions/20162678/linux-script-to-check-if-process-is-running-act-on-the-result
#

case "$(pidof perl ./check_it_out.pl | wc -w)" in

0)  echo "Restarting Telegram bot:     $(date)" >> /home/beyoungwoo/src/BASH/restart_log
    nohup /home/beyoungwoo/src/Perl/check_it_out.pl
    ;;
1)  # all ok
    ;;
*)  echo "Removed double Telegram bot: $(date)" >> /home/beyoungwoo/src/BASH/restart_log
    kill $(pidof perl ./check_it_out.pl | awk '{print $1}')
    ;;
esac

