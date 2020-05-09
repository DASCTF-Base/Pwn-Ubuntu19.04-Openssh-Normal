#!/bin/bash

echo $FLAG > /home/ctf/flag
export FLAG=not_flag
FLAG=not_flag
chmod 600 /home/ctf/flag
