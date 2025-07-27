#!/bin/bash

echo "🚀 Iniciando JupyterLab..."

# Activar entorno virtual
source ~/ai-projects/ai-env/bin/activate

# Cambiar al directorio de proyectos
cd ~/ai-projects

# Verificar que JupyterLab esté instalado
if ! command -v jupyter &> /dev/null; then
    echo "❌ JupyterLab no encontrado. Ejecuta primero: ~/setup-ai-env.sh"
    exit 1
fi

echo "📊 Información del sistema:"
nvidia-smi --query-gpu=name,memory.total,memory.used --format=csv,noheader,nounits 2>/dev/null || echo "GPU info not available"

echo "🌐 Iniciando JupyterLab en http://localhost:8888"
echo "⚠️ Para detener: Ctrl+C"

# Iniciar JupyterLab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root=false
