#!/bin/bash

echo "🚀 Configurando entorno AI/ML personalizado..."

# Crear directorio de proyectos
cd ~/ai-projects || exit 1

echo "📁 Creando entorno virtual..."
python3.12 -m venv ai-env

echo "🔧 Activando entorno virtual..."
source ai-env/bin/activate

echo "📦 Actualizando pip..."
pip install --upgrade pip setuptools wheel

echo "🔥 Instalando PyTorch..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo "🤖 Instalando TensorFlow..."
pip install tensorflow[and-cuda]

echo "📊 Instalando librerías ML..."
pip install scikit-learn numpy pandas matplotlib seaborn plotly scipy

echo "📓 Instalando Jupyter..."
pip install jupyterlab jupyterlab-git ipykernel ipywidgets

echo "🔧 Instalando herramientas MLOps..."
pip install mlflow wandb tensorboard dvc

echo "🎯 Instalando extras..."
pip install transformers datasets gradio streamlit opencv-python

echo "⚙️ Configurando kernel de Jupyter..."
python -m ipykernel install --user --name=ai-env --display-name="AI/ML Environment"

echo "🎨 Configurando aliases..."
cat >> ~/.bashrc << 'EOFBASH'
# === AI/ML Environment Aliases ===
alias ai-env='source ~/ai-projects/ai-env/bin/activate'
alias start-jupyter='source ~/ai-projects/ai-env/bin/activate && cd ~/ai-projects && jupyter lab'
alias ai-test='source ~/ai-projects/ai-env/bin/activate && python -c "import torch, tensorflow as tf; print(f\"✅ PyTorch CUDA: {torch.cuda.is_available()}\"); print(f\"✅ TensorFlow GPU: {len(tf.config.list_physical_devices(\"GPU\"))>0}\")"'
alias ai-info='nvidia-smi && echo "=== Python Environment ===" && source ~/ai-projects/ai-env/bin/activate && python --version && pip list | grep -E "(torch|tensorflow|scikit)"'
EOFBASH

echo "📝 Creando notebook de bienvenida..."
mkdir -p ~/ai-projects/notebooks

cat > ~/ai-projects/notebooks/Welcome.ipynb << 'EOFNOTEBOOK'
{
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "# 🎉 ¡Bienvenido a Pop!_OS AI/ML Edition!\n",
        "\n",
        "Este entorno viene preconfigurado con:\n",
        "- 🔥 PyTorch con soporte CUDA\n",
        "- 🤖 TensorFlow con soporte GPU\n",
        "- 📊 Scikit-learn, NumPy, Pandas\n",
        "- 📓 JupyterLab con extensiones\n",
        "- 🔧 MLflow, Weights & Biases\n",
        "- 🚀 Y mucho más...\n"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "source": [
        "# Verificar instalación\n",
        "import torch\n",
        "import tensorflow as tf\n",
        "import sklearn\n",
        "import pandas as pd\n",
        "import numpy as np\n",
        "\n",
        "print(f\"✅ PyTorch: {torch.__version__} (CUDA: {torch.cuda.is_available()})\")\n",
        "print(f\"✅ TensorFlow: {tf.__version__} (GPU: {len(tf.config.list_physical_devices('GPU'))>0})\")\n",
        "print(f\"✅ Scikit-learn: {sklearn.__version__}\")\n",
        "print(f\"✅ Pandas: {pd.__version__}\")\n",
        "print(f\"✅ NumPy: {np.__version__}\")\n",
        "\n",
        "if torch.cuda.is_available():\n",
        "    print(f\"🚀 GPU: {torch.cuda.get_device_name(0)}\")\n",
        "    print(f\"💾 VRAM: {torch.cuda.get_device_properties(0).total_memory / 1024**3:.1f} GB\")"
      ]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "AI/ML Environment",
      "language": "python",
      "name": "ai-env"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
EOFNOTEBOOK

echo ""
echo "🎉 ¡Configuración completada exitosamente!"
echo ""
echo "📋 Comandos disponibles:"
echo "  🔧 ai-env - Activar entorno AI/ML"
echo "  📓 start-jupyter - Iniciar JupyterLab"
echo "  🧪 ai-test - Verificar instalación GPU"
echo "  📊 ai-info - Mostrar información del sistema"
echo ""
echo "📚 Para empezar:"
echo "  1. Abre una terminal"
echo "  2. Ejecuta: start-jupyter"
echo "  3. Ve a: http://localhost:8888"
echo ""

# Auto-eliminar este script
rm ~/setup-ai-env.sh

# Eliminar el autostart
rm ~/.config/autostart/ai-first-setup.desktop 2>/dev/null || true

echo "✨ ¡Disfruta tu entorno AI/ML!"
