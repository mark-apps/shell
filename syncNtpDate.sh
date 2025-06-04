#!/bin/bash
apt update && apt install ntpdate

ntpdate 1.pool.ntp.org
