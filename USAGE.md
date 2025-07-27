# 📖 Guía de uso - Pop!_OS AI/ML Edition

## 🚀 Instalación del ISO

### 1. Crear USB booteable

\`\`\`bash
# Linux
sudo dd if=pop-os-ai-ml-custom.iso of=/dev/sdX bs=4M status=progress

# macOS
sudo dd if=pop-os-ai-ml-custom.iso of=/dev/diskX bs=4m

# Windows - usar Rufus o Balena Etcher
\`\`\`

### 2. Instalación del sistema

1. **Boot desde USB**
2. **Selecciona idioma y teclado**
3. **Configura particiones** (recomendado: 50GB+ para AI/ML)
4. **Crea usuario** (se configurará automáticamente)
5. **Espera la instalación** (~15-30 min)

## 🎯 Primer uso

### Configuración automática

Al primer login se ejecutará automáticamente:

\`\`\`bash
~/setup-ai-env.sh
\`\`\`

Este script:
- ✅ Crea entorno virtual Python
- ✅ Instala frameworks AI/ML
- ✅ Configura JupyterLab
- ✅ Crea aliases útiles
- ✅ Genera notebook de bienvenida

### Verificar instalación

\`\`\`bash
# Verificar GPU y frameworks
ai-test

# Información completa del sistema
ai-info
\`\`\`

## 📓 Usando JupyterLab

### Iniciar JupyterLab

\`\`\`bash
# Método 1: Alias directo
start-jupyter

# Método 2: Manual
ai-env
cd ~/ai-projects
jupyter lab
\`\`\`

### Acceder a JupyterLab

1. **Abre navegador**
2. **Ve a**: http://localhost:8888
3. **Explora**: notebooks/Welcome.ipynb

### Estructura de proyectos

\`\`\`
~/ai-projects/
├── ai-env/           # Entorno virtual
├── notebooks/        # Jupyter notebooks
├── datasets/         # Conjuntos de datos
├── models/          # Modelos entrenados
├── scripts/         # Scripts Python
├── experiments/     # Experimentos ML
└── configs/         # Configuraciones
\`\`\`

## 🤖 Frameworks disponibles

### PyTorch

\`\`\`python
import torch
import torchvision

# Verificar CUDA
print(f"CUDA disponible: {torch.cuda.is_available()}")
print(f"GPU: {torch.cuda.get_device_name(0)}")

# Crear tensor en GPU
x = torch.randn(3, 3).cuda()
print(x)
\`\`\`

### TensorFlow

\`\`\`python
import tensorflow as tf

# Verificar GPU
print(f"GPUs disponibles: {len(tf.config.list_physical_devices('GPU'))}")

# Crear tensor en GPU
with tf.device('/GPU:0'):
    x = tf.random.normal([3, 3])
    print(x)
\`\`\`

### Scikit-learn

\`\`\`python
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier

# Cargar datos
iris = load_iris()
clf = RandomForestClassifier()
clf.fit(iris.data, iris.target)

print(f"Precisión: {clf.score(iris.data, iris.target):.2f}")
\`\`\`

## 🔧 MLOps Tools

### MLflow

\`\`\`python
import mlflow
import mlflow.sklearn

# Iniciar experimento
mlflow.start_run()
mlflow.log_param("n_estimators", 100)
mlflow.log_metric("accuracy", 0.95)
mlflow.sklearn.log_model(clf, "model")
mlflow.end_run()
\`\`\`

### Weights & Biases

\`\`\`python
import wandb

# Inicializar proyecto
wandb.init(project="mi-proyecto-ai")
wandb.log({"accuracy": 0.95, "loss": 0.05})
\`\`\`

### TensorBoard

\`\`\`bash
# Iniciar TensorBoard
tensorboard --logdir=./logs --port=6006
\`\`\`

## 🐳 Docker para AI/ML

### Ejecutar contenedor PyTorch

\`\`\`bash
docker run --gpus all -it --rm pytorch/pytorch:latest python -c "import torch; print(torch.cuda.is_available())"
\`\`\`

### Ejecutar contenedor TensorFlow

\`\`\`bash
docker run --gpus all -it --rm tensorflow/tensorflow:latest-gpu python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
\`\`\`

## 📊 Monitoreo del sistema

### GPU Usage

\`\`\`bash
# Información básica
nvidia-smi

# Monitoreo continuo
watch -n 1 nvidia-smi

# Solo memoria
nvidia-smi --query-gpu=memory.used,memory.total --format=csv
\`\`\`

### Recursos del sistema

\`\`\`bash
# CPU y memoria
htop

# Espacio en disco
df -h

# Procesos Python
ps aux | grep python
\`\`\`

## 🔍 Solución de problemas

### GPU no detectada

\`\`\`bash
# Verificar driver NVIDIA
nvidia-smi

# Reinstalar CUDA
sudo apt install --reinstall nvidia-cuda-toolkit

# Verificar en Python
python -c "import torch; print(torch.cuda.is_available())"
\`\`\`

### JupyterLab no inicia

\`\`\`bash
# Verificar entorno virtual
source ~/ai-projects/ai-env/bin/activate
which jupyter

# Reinstalar JupyterLab
pip install --upgrade jupyterlab

# Verificar puerto
netstat -tlnp | grep 8888
\`\`\`

### Problemas de memoria

\`\`\`bash
# Limpiar cache de pip
pip cache purge

# Limpiar cache de conda (si aplica)
conda clean --all

# Verificar memoria
free -h
\`\`\`

## 📚 Recursos adicionales

### Documentación oficial
- [PyTorch Docs](https://pytorch.org/docs/)
- [TensorFlow Docs](https://tensorflow.org/guide)
- [JupyterLab Docs](https://jupyterlab.readthedocs.io/)

### Tutoriales recomendados
- [PyTorch Tutorials](https://pytorch.org/tutorials/)
- [TensorFlow Tutorials](https://tensorflow.org/tutorials)
- [Scikit-learn Examples](https://scikit-learn.org/stable/auto_examples/)

### Comunidad
- [PyTorch Forums](https://discuss.pytorch.org/)
- [TensorFlow Community](https://tensorflow.org/community)
- [r/MachineLearning](https://reddit.com/r/MachineLearning)

## 🎯 Próximos pasos

1. **Explora** el notebook de bienvenida
2. **Prueba** los ejemplos de cada framework
3. **Crea** tu primer proyecto AI/ML
4. **Comparte** tus resultados con la comunidad

¡Disfruta tu entorno AI/ML optimizado! 🚀
\`\`\`
