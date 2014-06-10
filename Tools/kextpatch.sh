if [[ $1 == '' ]] ; then
	echo "usage: $0 <name>.kext"
	exit
fi
echo "patching "  $1

chmod -R 755 $1
chown -R root:wheel $1
