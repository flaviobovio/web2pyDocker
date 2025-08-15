### Web2py & Python2 Development Enviroment




## Generar certificados para testing
```
openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -days 365 -nodes
```

## Docker 
```
# Crear el contenedor
docker compose build

# Iniciar contenedor (agregar -d al final para modo detach)
docker compose up
 
# Detener contenedor 
docker compose down

# Consola contenedor
docker exec -it web2py_app bash 
```

