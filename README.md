## 🐳 Docker, Web2py & Python2 Development Enviroment
Permite simular distintos entornos versiones web2py, librerías, etc, configurando Dockerfile

### Requisitos
Tener instalado docker y docker compose
Testeado con Docker version 28

### Clonar repo
```
git clone https://github.com/flaviobovio/web2pyDocker
```

### Aplicaciones
Copiar aplicaciones en la carpeta ./applications/


### Generar certificados para testing
```
openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -days 365 -nodes
```

### Docker 
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

