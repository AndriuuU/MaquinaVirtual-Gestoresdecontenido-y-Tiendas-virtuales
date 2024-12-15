# Instalación de Moodle y Prestashop en un servidor Ubuntu

## Descripción
Este proyecto automatiza la instalación de dos populares gestores de contenidos (CMS):
- **Moodle**: Plataforma de aprendizaje (LMS) utilizada para educación en línea.
- **Prestashop**: Sistema de comercio electrónico para crear tiendas virtuales.

Los scripts están diseñados para realizar la instalación completa sin necesidad de interacción del usuario.

---

## Requisitos Previos
Antes de ejecutar los scripts, asegúrate de que el servidor cumpla con los siguientes requisitos:
1. **Sistema Operativo**: Ubuntu 20.04 o superior.
2. **Permisos de usuario**: El usuario debe tener permisos de superusuario (`sudo`).
3. **Acceso a Internet**: Es necesario para descargar los paquetes y archivos de instalación.
4. **Apache y MySQL preinstalados**:
   - Si Apache y MySQL no están instalados, los scripts los instalarán automáticamente.

---

## Estructura del Proyecto
```
.
├── README.md                 # Este documento
├── scripts/
│   ├── install_moodle.sh     # Script de instalación de Moodle
│   ├── install_prestashop.sh # Script de instalación de Prestashop
```

---

## Scripts de Instalación

### 1. **Moodle**
#### ¿Qué hace el script?
- Instala Apache, MySQL y PHP junto con las extensiones requeridas.
- Crea una base de datos y un usuario específico para Moodle.
- Descarga Moodle desde el sitio oficial y configura el directorio de instalación.
- Configura Apache para que Moodle esté accesible a través del navegador.

#### Requisitos adicionales
- Moodle necesita un directorio de datos para almacenar archivos: `/var/moodledata`.

#### Comandos de ejecución
```bash
sudo chmod +x scripts/install_moodle.sh
sudo ./scripts/install_moodle.sh
```

#### Salida esperada
- Moodle estará instalado en el directorio `/var/www/html/moodle`.
- El sitio será accesible en el navegador a través de `http://<tu-servidor>/moodle`.

---

### 2. **Prestashop**
#### ¿Qué hace el script?
- Instala Apache, MySQL y PHP junto con los módulos requeridos:
  - `php-curl`, `php-zip`, `php-intl`.
- Crea una base de datos y un usuario específico para Prestashop.
- Descarga Prestashop desde el sitio oficial y lo descomprime en `/var/www/html/prestashop`.
- Configura Apache para que Prestashop esté accesible a través del navegador.

#### Requisitos adicionales
- Activación del módulo `mod_rewrite` en Apache, que el script realiza automáticamente.

#### Comandos de ejecución
```bash
sudo chmod +x scripts/install_prestashop.sh
sudo ./scripts/install_prestashop.sh
```

#### Salida esperada
- Prestashop estará instalado en el directorio `/var/www/html/prestashop`.
- El sitio será accesible en el navegador a través de `http://<tu-servidor>/prestashop`.

---

## Notas Técnicas

### Bases de Datos
Ambos scripts crean automáticamente bases de datos y usuarios para cada CMS:
- **Moodle**:
  - Base de datos: `moodle_db`
  - Usuario: `moodle_user`
- **Prestashop**:
  - Base de datos: `prestashop_db`
  - Usuario: `prestashop_user`

### Configuración de Apache
- Moodle y Prestashop configuran automáticamente un archivo en `/etc/apache2/sites-available/`.
- Apache será reiniciado para aplicar los cambios.

### Variables de Configuración
Si necesitas personalizar nombres de bases de datos, usuarios o contraseñas, edita los scripts antes de ejecutarlos. Busca las siguientes secciones:

```bash
DB_NAME=moodle_db      # Nombre de la base de datos
DB_USER=moodle_user    # Usuario de la base de datos
DB_PASSWORD=securepassword # Contraseña del usuario
```

---

## Verificación Post-Instalación

1. **Para Moodle**:
   - Accede a `http://<tu-servidor>/moodle`.
   - Sigue el asistente de instalación para configurar el sitio.
   - Asegúrate de que el directorio `/var/moodledata` sea accesible y tenga permisos adecuados.

2. **Para Prestashop**:
   - Accede a `http://<tu-servidor>/prestashop`.
   - Completa el asistente de instalación. El script ya habrá configurado la base de datos y los módulos requeridos.

---

## Problemas Comunes

1. **Apache no carga los sitios correctamente**:
   - Asegúrate de que los sitios están habilitados:
     ```bash
     sudo a2ensite moodle.conf
     sudo a2ensite prestashop.conf
     sudo systemctl reload apache2
     ```

2. **Errores de permisos**:
   - Asegúrate de que los directorios de instalación tienen los permisos adecuados:
     ```bash
     sudo chown -R www-data:www-data /var/www/html/moodle
     sudo chown -R www-data:www-data /var/www/html/prestashop
     ```

3. **Problemas con las bases de datos**:
   - Verifica que las bases de datos y usuarios están correctamente creados:
     ```bash
     sudo mysql -u root -e "SHOW DATABASES;"
     ```

---

## Conclusión
Este proyecto automatiza la instalación de Moodle y Prestashop en un servidor Ubuntu, ahorrando tiempo y evitando errores manuales. Los scripts garantizan que ambos sistemas estén listos para usar con una configuración mínima por parte del usuario.

¡Disfruta de tu plataforma educativa y tienda virtual! 🚀

