## GLPI para Contenedores Docker

Permite instalar GLPI usando Docker, se necesita una base de datos externa como MariaDB o Mysql

## Volumenes:

- /var/www/html/config: Directorio de configuracion	
- /var/www/html/files: Donde se guardan los archivos en GLPI


## Docker Compose:

```
version: '3.0'

services:
  glpi:
    container_name: "glpi"
    image: "nsoporte/glpi:9.5.1"
    network_mode: "bridge"
    restart: "always"
    ports:
      - "80:80"
    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/data/etc/glpi:/var/www/html/config"
      - "data/var/glpi/files:/var/www/html/config"
```