#!/bin/bash

#
# Author: Yuri Medvinsky
# Date: 05-03-2022
# Info: quick check certificates start date, end date, serial


if [ -z "$1" ]
then
  echo "Usage: "
  echo " $0 <something>.library.nyu.edu"
  exit
fi


# NOTE: openssl 2>/dev/null <-- optional entry should be immediately after openssl otherwise you get verbose output


# Show cert expiration
cert_start_date=$(echo -n | openssl 2>/dev/null s_client -servername $1 -connect $1:443 | openssl x509 -noout -startdate | cut -d '=' -f2- )
cert_end_date=$(echo -n | openssl 2>/dev/null s_client -servername $1 -connect $1:443 | openssl x509 -noout -enddate | cut -d '=' -f2- )

# Show cert serial
cert_serial=$(echo -n | openssl 2>/dev/null s_client -servername $1 -connect $1:443 | openssl x509 -noout -serial | cut -d '=' -f2 )


# -------------------------------
# Verify TLS certificate versions
# -------------------------------
# TLS1.1
TLS1_1=$(echo -n | openssl 2>/dev/null s_client -connect $1:443 -tls1_1 > /dev/null)
if [ $? -eq 0 ]; then
  tls1_1=TLS1.1
else
  tls1_1=''
fi


# TLS1.2
TLS1_2=$(echo -n | openssl 2>/dev/null s_client -connect $1:443 -tls1_2 > /dev/null)
if [ $? -eq 0 ]; then
  tls1_2=TLS1.2
else
  tls1_2=''
fi


echo "-------------------"
printf "Name:       $1 \n"
printf "Start Date: $cert_start_date \n"
printf "End Date:   $cert_end_date \n"
printf "Serial:     $cert_serial \n"
printf "TLS(1,2):   $tls1_1 $tls1_2 \n"
echo "-------------------"

