#!/bin/bash
set -e

echo "🔍 Verificando configuración NVIDIA en Pop!_OS..."

# Verificar drivers NVIDIA
if command -v nvidia-smi &> /dev/null; then
    echo "✅ NVIDIA drivers encontrados:"
    nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader,nounits
    
    # Verificar versión del driver
    DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader,nounits | head -1)
    echo "📋 Versión del driver: $DRIVER_VERSION"
    
    # Verificar CUDA
    if command -v nvcc &> /dev/null; then
        CUDA_VERSION=$(nvcc --version | grep "release" | sed 's/.*release $$[0-9]\+\.[0-9]\+$$.*/\1/')
        echo "✅ CUDA toolkit encontrado: $CUDA_VERSION"
    else
        echo "⚠️ CUDA toolkit no encontrado - se instalará componentes mínimos"
    fi
    
    # Verificar librerías CUDA
    if ldconfig -p | grep -q libcuda.so; then
        echo "✅ Librerías CUDA encontradas"
    else
        echo "⚠️ Librerías CUDA no encontradas"
    fi
    
    # Verificar cuDNN
    if ldconfig -p | grep -q libcudnn.so; then
        echo "✅ cuDNN encontrado"
    else
        echo "⚠️ cuDNN no encontrado - se instalará"
    fi
    
else
    echo "❌ Error: nvidia-smi no encontrado"
    echo "❌ Asegúrate de usar la ISO de Pop!_OS NVIDIA"
    exit 1
fi

echo "🎯 Verificación completada"
