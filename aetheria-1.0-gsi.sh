#!/bin/bash
rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/AetheriaOS/aetheria_manifest.git -b aetheria-1.0 --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

#Local Manifest
git clone https://github.com/N1709/local_manifest.git .repo/local_manifests -b gsi
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

git clone https://github.com/Doze-off/fuck-bpf.git -b sixteen-qpr2
./fuck-bpf/apply.sh --mb
echo "============="
echo "BPF patch applied"
echo "============="

# Export
export BUILD_USERNAME=N1709
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch - GSI target
lunch gsi_arm64-userdebug

# Build
mka systemimage

# Copy hasil
mkdir -p imgs_output
cp out/target/product/*/system.img imgs_output/
