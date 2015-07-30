#!/bin/bash
#
# starts confd and nginx

echo ""
echo "------------------------------------------------------------"
echo "---           Keys available for use                     ---"
echo "------------------------------------------------------------"
echo "* note: config server key format /some/key/name maps to environment format SOME_KEY_NAME"
echo ""
echo "- /upstream/<name>  (env: UPSTREAM_<name>)        Reverse proxied servers. One unique name per proxied server"
echo "- /nginx/hostname   (env: NGINX_HOSTNAME)         Name for this server. Default is localhost"
echo ""

if [ -z "${CONFD_OPTS}" ]; then
	echo "[INFO] no confd options passed in. To customize confd operation, set env var CONFD_OPTS."
	CONFD_OPTS="-backend env -onetime"
fi
echo "[INFO] Using confd options: ${CONFD_OPTS}"


if [[ ${CONFD_OPTS} =~ " env " ]]; then
	if [ -z "`env | grep UPSTREAM_`" ]; then 
		echo "[ERROR] There must be at least one env var prefixed with UPSTREAM_"
		echo ""
		echo "Exiting..."
		exit 1
	else
		echo "[INFO] Using the following server:ports for reverse proxying:"
		env | grep UPSTREAM_ | cut -d "=" -f2
		echo ""
	fi
fi

echo ""
echo "------------------------------------------------------------"
echo "---           STARTING CONFD & NGINX SERVICE             ---"
echo "------------------------------------------------------------"
echo ""
/usr/local/bin/confd ${CONFD_OPTS} &

/usr/sbin/service nginx start
