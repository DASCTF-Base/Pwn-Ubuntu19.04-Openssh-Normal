#!/bin/bash

if [[ -f /flag.sh ]]; then
	source /flag.sh
fi

/usr/sbin/sshd -D
tail -f /dev/null
