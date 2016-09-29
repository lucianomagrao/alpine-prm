Alpine Linux - Package Repository Mirror
========================================

Docker image that sync packages from alpine official repositories and serve over http. Based on this [alpine mirror tutorial](http://wiki.alpinelinux.org/wiki/How_to_setup_a_Alpine_Linux_mirror).

Current excluding from sync:

```
v2.*/
v3.0/
v3.1/
v3.2/
armhf/
x86/
```

## How to use:

```shell
docker volume create --name alpineprmdata
docker run --restart="unless-stopped" -d -p 8080:80 -v alpineprmdata:/var/www/localhost/htdocs/alpine/ leslau/alpine-prm
```

If you want to exclude more repositories, just create your own `exclude` file and override it.

```
-v $(pwd)/exclude:/exclude
```


To configure your alpine to use your repository mirror follow instructions in http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
