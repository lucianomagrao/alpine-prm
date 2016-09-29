#!/bin/sh

set -e

cat <<-'EOF' >> /etc/periodic/hourly/alpine-mirror
#!/bin/sh

lockfile="/tmp/alpine-mirror.lock"
if [ -z "$flock" ] ; then
  exec env flock=1 flock -n $lockfile "$0" "$@"
fi
src=rsync://rsync.alpinelinux.org/alpine/
dest=/var/www/localhost/htdocs/alpine/
/usr/bin/rsync \
        --archive \
        --update \
        --hard-links \
        --delete \
        --delete-after \
        --delay-updates \
        --timeout=600 \
        --exclude-from /exclude.txt \
        "$src" "$dest"
EOF

cat <<-'EOF' >> /etc/rsyncd.conf
[alpine]
        path = /var/www/localhost/htdocs/alpine
        comment = My Alpine Linux Mirror
EOF

chmod +x /etc/periodic/hourly/alpine-mirror

crond -b -l 6

exec "$@"
