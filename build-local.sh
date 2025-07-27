#!/bin/bash
set -e

echo "🏗️ Pop!_OS AI/ML Local Builder"
echo "================================"

# Verificar dependencias
check_dependencies() {
    local deps=("debootstrap" "squashfs-tools" "xorriso" "wget")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "❌ Falta dependencia: $dep"
            echo "Instalar con: sudo apt install $dep"
            exit 1
        fi
    done
    echo "✅ Dependencias verificadas"
}

# Verificar espacio en disco
check_disk_space() {
    local available=$(df . | tail -1 | awk '{print $4}')
    local required=20971520  # 20GB en KB
    
    if [ "$available" -lt "$required" ]; then
        echo "❌ Espacio insuficiente. Necesitas al menos 20GB libres"
        exit 1
    fi
    echo "✅ Espacio en disco suficiente"
}

# Descargar ISO base
download_base_iso() {
    if [ ! -f "pop-os-base.iso" ]; then
        echo "📥 Descargando Pop!_OS base ISO..."
        wget -O pop-os-base.iso "https://iso.pop-os.org/22.04/amd64/nvidia/55/pop-os_22.04_amd64_nvidia_55.iso"
    else
        echo "✅ ISO base ya existe"
    fi
}

# Función principal de construcción
build_iso() {
    echo "🔧 Iniciando construcción del ISO..."
    
    # Crear directorios
    mkdir -p iso-extract mount-point
    
    # Montar ISO base
    echo "📂 Montando ISO base..."
    sudo mount -o loop pop-os-base.iso mount-point
    sudo cp -rT mount-point/ iso-extract/
    sudo umount mount-point
    
    # Extraer filesystem
    echo "📦 Extrayendo filesystem..."
    cd iso-extract
    sudo unsquashfs casper/filesystem.squashfs
    sudo mv squashfs-root custom-root
    
    # Preparar chroot
    echo "🔧 Preparando entorno chroot..."
    sudo cp /etc/resolv.conf custom-root/etc/resolv.conf
    sudo cp ../customize-system.sh custom-root/tmp/
    sudo cp ../install-ai-packages.sh custom-root/tmp/
    sudo cp ../verify-nvidia.sh custom-root/tmp/
    sudo cp ../setup-ai-env.sh custom-root/tmp/
    sudo cp ../start-jupyter.sh custom-root/tmp/
    sudo cp ../ai-first-setup.desktop custom-root/tmp/
    
    # Personalizar sistema
    echo "🤖 Personalizando sistema..."
    sudo chroot custom-root /bin/bash -c "
        export DEBIAN_FRONTEND=noninteractive
        bash /tmp/customize-system.sh
        bash /tmp/install-ai-packages.sh
        
        # Setup user templates
        cp /tmp/setup-ai-env.sh /etc/skel/
        cp /tmp/start-jupyter.sh /etc/skel/
        mkdir -p /etc/skel/.config/autostart
        cp /tmp/ai-first-setup.desktop /etc/skel/.config/autostart/
        chmod +x /etc/skel/setup-ai-env.sh
        chmod +x /etc/skel/start-jupyter.sh
        
        # Limpieza
        rm -rf /tmp/*
        apt-get autoremove -y
        apt-get autoclean
        rm -rf /var/lib/apt/lists/*
        rm -f /etc/resolv.conf
    "
    
    # Reconstruir filesystem
    echo "📦 Reconstruyendo filesystem..."
    sudo du -sx --block-size=1 custom-root | cut -f1 > casper/filesystem.size
    sudo rm -f casper/filesystem.squashfs
    sudo mksquashfs custom-root casper/filesystem.squashfs -comp xz -b 1M
    
    # Crear ISO final
    echo "🔥 Creando ISO final..."
    sudo xorriso -as mkisofs \
        -r -V "Pop!_OS AI/ML Edition" \
        -o ../pop-os-ai-ml-custom-$(date +%Y%m%d).iso \
        -J -l -cache-inodes \
        -b isolinux/isolinux.bin -c isolinux/boot.cat \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot \
        -isohybrid-gpt-basdat .
    
    cd ..
    
    # Generar checksums
    echo "📋 Generando checksums..."
    sha256sum pop-os-ai-ml-custom-*.iso > checksums.txt
    
    echo "🎉 ¡Construcción completada!"
    echo "📦 ISO creado: pop-os-ai-ml-custom-$(date +%Y%m%d).iso"
    ls -lh pop-os-ai-ml-custom-*.iso
}

# Función de limpieza
cleanup() {
    echo "🧹 Limpiando archivos temporales..."
    sudo rm -rf iso-extract mount-point
    echo "✅ Limpieza completada"
}

# Menú principal
main() {
    case "${1:-}" in
        "check")
            check_dependencies
            check_disk_space
            ;;
        "download")
            download_base_iso
            ;;
        "build")
            check_dependencies
            check_disk_space
            download_base_iso
            build_iso
            ;;
        "clean")
            cleanup
            ;;
        *)
            echo "🚀 Pop!_OS AI/ML Local Builder"
            echo ""
            echo "Uso: $0 [comando]"
            echo ""
            echo "Comandos:"
            echo "  check     - Verificar dependencias y espacio"
            echo "  download  - Descargar ISO base"
            echo "  build     - Construir ISO completo"
            echo "  clean     - Limpiar archivos temporales"
            echo ""
            echo "Ejemplo:"
            echo "  $0 build    # Construir ISO completo"
            ;;
    esac
}

# Manejar Ctrl+C
trap cleanup EXIT

# Ejecutar función principal
main "$@"
