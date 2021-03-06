#! /bin/sh
 
#to prevent some possible problems
export AS_JAVA=/usr/lib/jvm/java-6-oracle
 
GLASSFISHPATH=/opt/glassfish3/bin
 
case "$1" in
start)
echo "starting glassfish from $GLASSFISHPATH"
sudo -u glassfish $GLASSFISHPATH/asadmin start-domain domain1
;;
restart)
$0 stop
$0 start
;;
stop)
echo "stopping glassfish from $GLASSFISHPATH"
sudo -u glassfish $GLASSFISHPATH/asadmin stop-domain domain1
;;
*)
echo $"usage: $0 {
start|stop|restart}"
exit 3
;;
esac
:
