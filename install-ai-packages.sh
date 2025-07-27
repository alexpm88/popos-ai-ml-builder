#!/bin/bash
set -e

echo "🧠 Starting AI/ML packages installation..."

# Verify NVIDIA setup (drivers should be pre-installed in Pop!_OS NVIDIA ISO)
echo "🔍 Verificando configuración NVIDIA..."
if command -v nvidia-smi &> /dev/null; then
    echo "✅ NVIDIA drivers found:"
    nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader
    
    # Check for CUDA toolkit
    if command -v nvcc &> /dev/null; then
        echo "✅ CUDA toolkit already installed: $(nvcc --version | grep release)"
    else
        echo "📦 Installing minimal CUDA toolkit components..."
        apt-get update
        apt-get install -y cuda-toolkit-12-2 libcudnn8-dev
    fi
else
    echo "❌ Error: NVIDIA drivers not found. Using wrong ISO?"
    exit 1
fi

# Upgrade pip
echo "📦 Upgrading pip..."
python3 -m pip install --upgrade pip setuptools wheel

# Install PyTorch with CUDA support
echo "🔥 Installing PyTorch with CUDA support..."
python3 -m pip install --break-system-packages \
  torch torchvision torchaudio \
  --index-url https://download.pytorch.org/whl/cu121

# Install TensorFlow with GPU support
echo "🤖 Installing TensorFlow with GPU support..."
python3 -m pip install --break-system-packages \
  tensorflow[and-cuda]

# Install core ML libraries
echo "📊 Installing core ML libraries..."
python3 -m pip install --break-system-packages \
  scikit-learn \
  numpy \
  pandas \
  matplotlib \
  seaborn \
  plotly \
  scipy \
  statsmodels

# Install data processing libraries
echo "🔄 Installing data processing libraries..."
python3 -m pip install --break-system-packages \
  dask[complete] \
  polars \
  pyarrow \
  fastparquet \
  openpyxl \
  xlsxwriter

# Install Jupyter ecosystem
echo "📓 Installing Jupyter ecosystem..."
python3 -m pip install --break-system-packages \
  jupyterlab \
  jupyterlab-git \
  jupyterlab-lsp \
  jupyter-lsp-python \
  ipykernel \
  ipywidgets \
  voila

# Install MLOps tools
echo "🔧 Installing MLOps tools..."
python3 -m pip install --break-system-packages \
  mlflow \
  wandb \
  tensorboard \
  dvc \
  great-expectations

# Install deep learning extras
echo "🚀 Installing deep learning extras..."
python3 -m pip install --break-system-packages \
  transformers \
  datasets \
  accelerate \
  gradio \
  streamlit

# Install computer vision libraries
echo "👁️ Installing computer vision libraries..."
python3 -m pip install --break-system-packages \
  opencv-python \
  Pillow \
  albumentations \
  imgaug

# Install NLP libraries
echo "💬 Installing NLP libraries..."
python3 -m pip install --break-system-packages \
  nltk \
  spacy \
  gensim \
  textblob

# Install visualization tools
echo "📈 Installing visualization tools..."
python3 -m pip install --break-system-packages \
  bokeh \
  altair \
  holoviews \
  datashader

# Create system-wide directories
echo "📁 Creating AI project directories..."
mkdir -p /etc/skel/ai-projects/{notebooks,datasets,models,scripts,experiments,configs}
mkdir -p /etc/skel/.config/autostart
mkdir -p /etc/skel/.jupyter

# Create Jupyter config
echo "⚙️ Creating Jupyter configuration..."
cat > /etc/skel/.jupyter/jupyter_lab_config.py << 'EOF'
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_root = False
c.ServerApp.token = ''
c.ServerApp.password = ''
c.LabApp.default_url = '/lab'
EOF

echo "✅ AI/ML packages installation completed!"
