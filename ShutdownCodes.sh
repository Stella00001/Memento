#!/bin/zsh
Log show --predicate 'eventMessage contains "Previous shutdown cause"' --last 1024h | awk '
BEGIN{
FS=" ";
scode["7"]="CPU thread error. try Safe Mode.";
scode["6"]="unknown.";
scode["5"]="Correct Shut Down.";
scode["3"]="Hard shutdown.";
scode["1"]="User-initiated Restart.";
scode["0"]="Power disconnected.";
scode["-3"]="Multiple temperature sensors exceeded limits.";
scode["-14"]="Electricity spike/surge. On Mac Pro, check PSU.";
scode["-20"]="BridgeOS T2-initiated shutdown.";
scode["-60"]="Bad master directory block (badMDBErr). Back up your data, wipe and reinstall macOS.";
scode["-61"]="Watchdog timer detected unresponsive application, shutting down the system.";
scode["-62"]="Watchdog timer detected unresponsive application, restarting the system.";
scode["-63"]="unknown. Potentially T2 related?";
scode["-64"]="unknown.";
scode["-65"]="unknown. Potentially linked to operating system issue.";
score["-70"]="Unknown. Possibly Top Case related?";
scode["-71"]="SO-DIMM Memory temperature exceeds limits.";
scode["-74"]="Battery temperature exceeds limits.";
scode["-75"]="Communication issue with AC adapter.";
scode["-78"]="Incorrect current value coming from AC adapter.";
scode["-79"]="Incorrect current value coming from battery.";
scode["-82"]="Unknown.Potentially thermal sensor communication issue?";
scode["-86"]="Proximity temperature exceeds limits.";
scode["-95"]="CPU temperature exceeds limits.";
scode["-100"]="Power supply temperature exceeds limits.";
scode["-101"]="LCD temperature exceeds limits.";
scode["-102"]="Overvoltage. Safety shutdown related to over voltage protection (MLB or Battery).";
scode["-103"]="Battery cell under voltage detected. Check battery. Perform 1 charge cycle, then try again.";
scode["-104"]="unknown. Possibly linked to battery issue.";
scode["-108"]="unverified. Likely memory issue. Commonly occurs when RAM full and page issue.";
scode["-112"]="unverified. Memory issue. Almost always occurs around -128, another memory issue.";
scode["-127"]="PMU forced shutdown. Check power button if unit was not forcibly shutdown.";
scode["-128"]="unknown. Possibly linked to memory issue."
}
/cause/ {print "Shutdown Detected on",$1,"at",substr($2,0,8),"--> Code",$13,"-->",scode[$13]}'
#https://krypted.com/lists/comprehensive-list-of-mac-os-x-error-codes/ possibly useful?