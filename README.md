# 🔥 Pop!_OS AI/ML Edition Builder

Crea automáticamente un ISO personalizado de Pop!_OS con frameworks de AI/ML preinstalados.

## 🚀 Inicio rápido

1. **Fork este repositorio**
2. **Ve a Actions → "Build Pop!_OS AI/ML Custom ISO"**
3. **Click "Run workflow"**
4. **Espera 1.5-2 horas**
5. **Descarga tu ISO personalizado**

## 📦 ¿Qué incluye?

### 🤖 Frameworks AI/ML
- **PyTorch** con soporte CUDA
- **TensorFlow** con soporte GPU
- **Scikit-learn** para ML clásico
- **Transformers** para NLP
- **OpenCV** para visión computacional

### 📊 Análisis de datos
- **Pandas** & **NumPy**
- **Matplotlib** & **Seaborn**
- **Plotly** para visualizaciones interactivas
- **Dask** para big data

### 🔧 Herramientas de desarrollo
- **JupyterLab** con extensiones
- **MLflow** para tracking
- **Weights & Biases**
- **Docker** preconfigurado

### 🚀 GPU Computing
- **NVIDIA CUDA** toolkit
- **cuDNN** optimizado
- Soporte completo RTX 20/30/40 series

## 🎯 Después de instalar

### Primer uso:
\`\`\`bash
# Se ejecuta automáticamente al primer login
~/setup-ai-env.sh
\`\`\`

### Comandos útiles:
\`\`\`bash
# Activar entorno AI/ML
ai-env

# Iniciar JupyterLab
start-jupyter

# Verificar GPU
ai-test

# Información del sistema
ai-info
\`\`\`

## 🏗️ Construcción local

### Prerrequisitos:
\`\`\`bash
sudo apt install debootstrap squashfs-tools xorriso wget
\`\`\`

### Construir ISO:
\`\`\`bash
# Verificar sistema
./build-local.sh check

# Construir ISO completo
./build-local.sh build

# Limpiar archivos temporales
./build-local.sh clean
\`\`\`

## 📋 Estructura del proyecto (raíz)

\`\`\`
popos-ai-ml-builder/
├── .github/workflows/build-iso.yml    # GitHub Actions
├── customize-system.sh                # Personalización del sistema
├── install-ai-packages.sh            # Instalación AI/ML
├── verify-nvidia.sh                  # Verificación NVIDIA
├── setup-ai-env.sh                   # Setup entorno usuario
├── start-jupyter.sh                  # Iniciar JupyterLab
├── ai-first-setup.desktop            # Autostart desktop
├── iso-config.json                   # Configuración ISO
├── package-list.txt                  # Lista de paquetes
├── build-local.sh                    # Constructor local
└── README.md                         # Documentación
\`\`\`

## 🔧 Personalización

### Modificar paquetes AI/ML:
Edita \`install-ai-packages.sh\`

### Cambiar configuración del sistema:
Edita \`customize-system.sh\`

### Personalizar entorno de usuario:
Modifica \`setup-ai-env.sh\` y \`start-jupyter.sh\`

## 📊 Especificaciones técnicas

- **Base**: Pop!_OS 22.04 LTS NVIDIA (build 55)
- **Drivers NVIDIA**: Preinstalados (no requiere instalación adicional)
- **Python**: 3.12 con pip actualizado
- **CUDA**: Toolkit mínimo + cuDNN
- **Docker**: Última versión estable
- **Tamaño**: ~3-4 GB (reducido al evitar reinstalar drivers)
- **Tiempo de build**: ~1.5-2 horas (optimizado)

## ⚡ Optimizaciones

### Estructura simplificada
- ✅ Todos los archivos en la raíz del proyecto
- ✅ Referencias de rutas actualizadas
- ✅ Fácil navegación y mantenimiento
- ✅ Scripts más simples de ejecutar

### Drivers NVIDIA preinstalados
- ✅ La ISO base ya incluye drivers NVIDIA optimizados
- ✅ No se reinstalan drivers (ahorra ~500MB y 15 minutos)
- ✅ Solo se instalan componentes CUDA necesarios
- ✅ Verificación automática de compatibilidad

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver \`LICENSE\` para más detalles.

## 🆘 Soporte

- **Issues**: Reporta bugs o solicita features
- **Discussions**: Preguntas y ayuda de la comunidad
- **Wiki**: Documentación extendida

## 🎉 Créditos

Creado con ❤️ por la comunidad de desarrolladores AI/ML.

---

**¿Te gusta el proyecto?** ⭐ ¡Dale una estrella en GitHub!
