docker-varnish
===

This is Varnish Cache Docker, the high-performance HTTP accelerator.

Documentation and additional information about Varnish is available on https://www.varnish-cache.org/
 
 - Supported : Varnish 6.0
    - [Varnish 6.0.0 Documentation](https://varnish-cache.org/docs/6.0/index.html)

### Build the image 

Compiling Varnish from source

 - https://github.com/varnishcache/varnish-cache

The varnishd binary is in /usr/local/sbin/varnishd.

```.docker
$ docker build -t docker-varnish .
``` 
 
### Run

```.docker
$ docker run -itd -p 8080:80 docker-varnish
```
