ip=$1
ufw insert 1 deny from $1
ufw status numbered

