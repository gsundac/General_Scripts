#! /bin/bash
DATAFILE='/net/hs/vol/unix_home/hsmnt/home/dropbox/hosts_summary/hosts.csv'
# Total Server Summary
HPUX_TOTAL=`grep HP-UX  $DATAFILE | wc -l`
RHEL_TOTAL=`grep "RHEL" $DATAFILE | wc -l`
SUNOS_TOTAL=`grep "SunOS" $DATAFILE | wc -l`
OTHEROS=`egrep -v "^$|SunOS|RHEL|HP-UX" $DATAFILE | wc -l`
TOTALOSI=`echo "$HPUX_TOTAL + $RHEL_TOTAL + $SUNOS_TOTAL + $OTHEROS" | bc`

# Virtual Server Summary
VHPUX_TOTAL=`grep HP-UX $DATAFILE | grep "VMWare" | wc -l`
VRHEL_TOTAL=`grep "RHEL" $DATAFILE |  grep "VMware Virtual Platform" | wc -l`
VSUNOS_TOTAL=`grep "SunOS" $DATAFILE | grep NGC | wc -l`
VOTHEROS=`egrep -v "^$|SunOS|RHEL|HP-UX" $DATAFILE | grep "VMware Virtual Platform" | wc -l`
VTOTALOSI=`echo "$VHPUX_TOTAL + $VRHEL_TOTAL + $VSUNOS_TOTAL + $VOTHEROS" | bc`

# Phyiscal Server Summary
#PHPUX_TOTAL=`echo "$HPUX_TOTAL-$VHPUX_TOTAL"| bc`
PHPUX_TOTAL=$HPUX_TOTAL
PRHEL_TOTAL=`echo "$RHEL_TOTAL-$VRHEL_TOTAL"| bc`
PSUNOS_TOTAL=`echo "$SUNOS_TOTAL-$VSUNOS_TOTAL"| bc`
POTHEROS_TOTAL=`echo "$OTHEROS-$VOTHEROS"| bc`
PTOTALOSI=`echo "$PHPUX_TOTAL + $PRHEL_TOTAL + $PSUNOS_TOTAL + $POTHEROS_TOTAL" | bc`

# Age Summary
OHPUX_TOTAL=`grep HP-UX $DATAFILE | grep -v "VMware" | awk '{print $(NF)}' | egrep "49|[5-9][0-9]|[1-9][0-9][0-9]" | wc -l`
ORHEL_TOTAL=`grep "RHEL" $DATAFILE | grep -v "VMware" | awk '{print $(NF)}' | egrep "4[8-9]|[5-9][0-9]|[1-9][0-9][0-9]" | wc -l`
OSUNOS_TOTAL=`grep "SunOS" $DATAFILE | grep -v "NGC" | awk '{print $(NF)}' | egrep "4[8-9]|[5-9][0-9]|[1-9][0-9][0-9]" | wc -l`
OOTHEROS=`egrep -v "^$|SunOS|RHEL|HP-UX" $DATAFILE | grep -v "VMware" | awk '{print $(NF)}' |grep -v \- | egrep "4[8-9]|[5-9][0-9]|[1-9][0-9][0-9]" | wc -l`
OTOTALOSI=`echo "$OHPUX_TOTAL + $ORHEL_TOTAL + $OSUNOS_TOTAL + $OOTHEROS" | bc`

# Location Summary
MLP_TOTAL=`grep MLP $DATAFILE | wc -l`
SEO_TOTAL=`grep SEO $DATAFILE | wc -l`
ENB2_TOTAL=`grep ENB2 $DATAFILE | wc -l`
REMOTE_TOTAL=`egrep "EDMTerm|REMOTE|PLC" $DATAFILE | wc -l`
UNDEFINED=`egrep -v "^$|REMOTE|ENB2|SEO|MLP|PLC|EDMTerm" $DATAFILE | wc -l`
TOTALLS=`echo "$MLP_TOTAL + $SEO_TOTAL + $ENB2_TOTAL + $REMOTE_TOTAL + $UNDEFINED" | bc` 

# Virtual Location Summary
MLP_VTOTAL=`grep MLP $DATAFILE | egrep "VMware Virtual|NGC" | wc -l`
SEO_VTOTAL=`grep SEO $DATAFILE | egrep "VMware Virtual|NGC" | wc -l`
ENB2_VTOTAL=`grep ENB2 $DATAFILE | egrep "VMware Virtual|NGC" | wc -l`
# EPL_VTOTAL=`grep PLC $DATAFILE | egrep "VMware Virtual|NGC" | wc -l`
# EDTERM_PTOTAL=`grep EDMTerminal $DATAFILE | egrep "VMware Virtual|NGC" | wc -l`
REMOTE_VTOTAL=`egrep "EDMTerm|REMOTE|PLC" $DATAFILE | egrep "VMware Virtual|NGC" | wc -l`
VTOTALLS=`echo "$MLP_VTOTAL + $SEO_VTOTAL + $ENB2_VTOTAL + $REMOTE_VTOTAL" | bc`

# Physical Location Summary
MLP_PTOTAL=`grep MLP $DATAFILE | egrep -v "VMware Virtual|NGC" | wc -l`
SEO_PTOTAL=`grep SEO $DATAFILE | egrep -v "VMware Virtual|NGC" | wc -l`
ENB2_PTOTAL=`grep ENB2 $DATAFILE | egrep -v "VMware Virtual|NGC" | wc -l`
EPL_PTOTAL=`grep PLC $DATAFILE | egrep -v "VMware Virtual|NGC" | wc -l`
EDTERM_PTOTAL=`grep EDMTerminal $DATAFILE | egrep -v "VMware Virtual|NGC" | wc -l`
REMOTE_PTOTAL=`egrep "REMOTE|EDMTerm|PLC" $DATAFILE | egrep -v "VMware Virtual|NGC" | wc -l`
PTOTALLS=`echo "$EPL_PTOTAL + $MLP_PTOTAL + $SEO_PTOTAL + $ENB2_PTOTAL + $REMOTE_PTOTAL" | bc`

# Location Detailed Physical Server Inv for Team Report
MLP_HP_RHEL=`grep MLP $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep "ProLiant"| wc -l`
MLP_CISCO_RHEL=`grep MLP $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -v "ProLiant|HP"| wc -l`
MLP_HPUX=`grep MLP $DATAFILE | egrep "HP-UX" | wc -l`
MLP_SOL=`grep MLP $DATAFILE | egrep "SunOS" | grep -v Global | wc -l`
MLP_HP_RHEL_CONSOLE=`grep MLP $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -i "HP Z8|workstation"| wc -l`
SEO_HP_RHEL=`grep SEO $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep "ProLiant"| wc -l`
SEO_CISCO_RHEL=`grep SEO $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -v "ProLiant|HP"| wc -l`
SEO_HPUX=`grep SEO $DATAFILE | egrep "HP-UX" | wc -l`
SEO_SOL=`grep SEO $DATAFILE | egrep "SunOS" | grep -v Global | wc -l`
SEO_HP_RHEL_CONSOLE=`grep SEO $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -i "HP Z8|workstation"| wc -l`
ENB2_HP_RHEL=`grep ENB2 $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep "ProLiant"| wc -l`
ENB2_CISCO_RHEL=`grep ENB2 $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -v "ProLiant|HP"| wc -l`
ENB2_HPUX=`grep ENB2 $DATAFILE | egrep "HP-UX" | wc -l`
ENB2_SOL=`grep ENB2 $DATAFILE | egrep "SunOS" | grep -v Global | wc -l`
ENB2_HP_RHEL_CONSOLE=`grep ENB2 $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -i "HP Z8|workstation"| wc -l`
REMOTE_HP_RHEL=`grep REMOTE $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep "ProLiant"| wc -l`
REMOTE_CISCO_RHEL=`grep REMOTE $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -v "ProLiant|HP"| wc -l`
REMOTE_HPUX=`grep REMOTE $DATAFILE | egrep "HP-UX" | wc -l`
REMOTE_SOL=`grep REMOTE $DATAFILE | egrep "SunOS" | grep -v Global | wc -l`
REMOTE_HP_RHEL_CONSOLE=`grep REMOTE $DATAFILE | egrep "Red Hat|RHEL" | egrep -v VMware | egrep -i "HP Z8|workstation"| wc -l`

# OUTPUT TIME
echo "===========,============,==========,==========,=========="
echo "PHYSICAL Location Breakdown"
echo "===========,============,==========,==========,=========="
echo "MLP,HP,RHEL,$MLP_HP_RHEL"
echo "MLP,CISCO,RHEL,$MLP_CISCO_RHEL"
echo "MLP,HPUX,11i,$MLP_HPUX"
echo "MLP,SUN,Solaris8-11,$MLP_SOL"
echo "SEO,HP,RHEL,$SEO_HP_RHEL"
echo "SEO,CISCO,RHEL,$SEO_CISCO_RHEL"
echo "SEO,HPUX,11i,$SEO_HPUX"
echo "SEO,SUN,Solaris8-11,$SEO_SOL"
echo "ENB2,HP,RHEL,$ENB2_HP_RHEL"
echo "ENB2,CISCO,RHEL,$ENB2_CISCO_RHEL"
echo "ENB2,HPUX,11i,$ENB2_HPUX"
echo "ENB2,SUN,Solaris8-11,$ENB2_SOL"
echo "REMOTE,HP,RHEL,$REMOTE_HP_RHEL"
echo "REMOTE,CISCO,RHEL,$REMOTE_CISCO_RHEL"
echo "REMOTE,HPUX,11i,$REMOTE_HPUX"
echo "REMOTE,SUN,Solaris8-11,$REMOTE_SOL"
echo
echo "===========,============,==========,==========,=========="
echo "Console Breakdown"
echo "===========,============,==========,==========,=========="
echo "MLP,HP_CONSOLES,RHEL,$MLP_HP_RHEL_CONSOLE"
echo "SEO,HP_CONSOLES,RHEL,$SEO_HP_RHEL_CONSOLE"
echo "ENB2,HP_CONSOLES,RHEL,$ENB2_HP_RHEL_CONSOLE"
echo "REMOTE,HP_CONSOLES,RHEL,$REMOTE_HP_RHEL_CONSOLE"
echo
echo
echo "===========,============,==========,==========,=========="
echo "OS_Summary,Virtual,Physical,Phy>4Yrs,Total"
echo "===========,============,==========,==========,=========="
echo "Total_HPUX,$VHPUX_TOTAL,$PHPUX_TOTAL,$OHPUX_TOTAL,$HPUX_TOTAL"
echo "Total_RedHat,$VRHEL_TOTAL,$PRHEL_TOTAL,$ORHEL_TOTAL,$RHEL_TOTAL"
echo "Total_Solaris,$VSUNOS_TOTAL,$PSUNOS_TOTAL,$OSUNOS_TOTAL,$SUNOS_TOTAL"
echo "Total_Other,$VOTHEROS,$POTHEROS_TOTAL,$OOTHEROS,$OTHEROS"
echo "-----------,---------,---------------,---------,---------"
echo "Total_Servers,$VTOTALOSI,$PTOTALOSI,$OTOTALOSI,$TOTALOSI"
echo "===========,============,==========,==========,=========="
echo
echo "===========,============,==========,==========,=========="
echo "LOC_Summary,Virtual,Physical,Total"
echo "===========,============,==========,==========,=========="
echo "MLP_DC,$MLP_VTOTAL,$MLP_PTOTAL,$MLP_TOTAL"
echo "SEO_DC,$SEO_VTOTAL,$SEO_PTOTAL,$SEO_TOTAL"
echo "Enb_Tower,$ENB2_VTOTAL,$ENB2_PTOTAL,$ENB2_TOTAL"
echo "Remote,$REMOTE_VTOTAL,$REMOTE_PTOTAL,$REMOTE_TOTAL"
echo "-----------,---------,---------------,---------,---------"
echo "Totals,$VTOTALLS,$PTOTALLS,$TOTALLS"
echo "===========,============,==========,==========,=========="
