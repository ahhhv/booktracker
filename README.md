# Book Tracker

Book Tracker es una aplicación desarrollada en SwiftUI que permite a los usuarios buscar libros, rastrear sus fechas de lanzamiento y organizar sus listas de libros favoritos. La app utiliza la API de Google Books para obtener información actualizada sobre los libros y ofrece autenticación mediante Google Login.

## Características principales

- **Búsqueda de libros**: Encuentra libros mediante la API de Google Books.
- **Seguimiento de lanzamientos**: Clasifica los libros en:
  - Favoritos
  - Lanzamientos pasados
  - Próximos lanzamientos
- **Autenticación con Google**: Cada usuario puede iniciar sesión con su cuenta de Google, asegurando la privacidad de sus datos y personalizando su experiencia.

## Requisitos del sistema

- **iOS 15.0 o superior**
- **Xcode 13 o superior**
- **Cuenta de desarrollador de Apple** (para probar en un dispositivo real)
- **Clave de API de Google Books**

## Configuración del proyecto

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/book-tracker.git
   cd book-tracker
   ```

2. **Configura la API de Google Books**:
   - Ve a [Google Cloud Console](https://console.cloud.google.com/).
   - Crea un proyecto o selecciona uno existente.
   - Habilita la API de Google Books.
   - Genera una clave de API y cópiala.
   - En el proyecto de Xcode, añade la clave de API en un archivo de configuración seguro (por ejemplo, `Secrets.plist`).

3. **Configura el login con Google**:
   - En Google Cloud Console, habilita la autenticación OAuth 2.0.
   - Configura las credenciales para iOS.
   - Descarga el archivo `GoogleService-Info.plist` proporcionado por Google y añádelo al proyecto.

4. **Instala las dependencias** (si es necesario):
   - Si usas Swift Package Manager, verifica que las dependencias están correctamente configuradas en el archivo `Package.swift`.

5. **Ejecuta el proyecto**:
   - Abre `BookTracker.xcodeproj` en Xcode.
   - Selecciona un simulador o dispositivo real.
   - Compila y ejecuta.

## Estructura del proyecto

- **Model**: Contiene las estructuras de datos principales (por ejemplo, modelo de libros).
- **View**: Diseños de las pantallas principales en SwiftUI.
- **ViewModel**: Implementa la lógica de negocio y gestiona la comunicación entre vistas y modelos.
- **Services**: Incluye la integración con la API de Google Books y el manejo de autenticación con Google.

## Futuras mejoras

- Añadir notificaciones para recordar los lanzamientos próximos.
- Posibilidad de compartir listas de libros con otros usuarios.
- Integración con Apple Books para abrir los libros directamente.

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas colaborar, abre un issue o envía un pull request.

## Licencia

Este proyecto está licenciado bajo la [MIT License](LICENSE).

---

¡Gracias por usar Book Tracker! Esperamos que disfrutes organizando y siguiendo tus libros favoritos.

