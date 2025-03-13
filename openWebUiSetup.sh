#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Try: sudo $0"
    exit 1
fi

# Step 1: Install NVIDIA Driver and CUDA Toolkit
echo "Installing NVIDIA Driver and CUDA Toolkit..."
apt-get update
apt-get install -y nvidia-driver-535 nvidia-cuda-toolkit

# Step 2: Add NVIDIA Container Toolkit Repository
echo "Adding NVIDIA Container Toolkit repository..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Step 3: Update package lists
echo "Updating package lists..."
apt-get update

# Step 4: Install NVIDIA Container Toolkit
echo "Installing NVIDIA Container Toolkit..."
apt-get install -y nvidia-container-toolkit

# Step 5: Configure NVIDIA Runtime for Docker
echo "Configuring NVIDIA runtime for Docker..."
nvidia-ctk runtime configure --runtime=docker

# Step 6: Restart Docker
echo "Restarting Docker service..."
systemctl restart docker

# Step 7: Test NVIDIA GPU inside Docker
echo "Testing NVIDIA GPU inside Docker..."
docker run --rm --runtime=nvidia nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi

# Step 8: Run OpenWebUI
echo "Starting OpenWebUI container..."
docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama

# Step 9: Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "Follow the Tailscale setup instructions."
tailscale up --ssh

# Step 10: Enable HTTPS for OpenWebUI via Tailscale; necessary to use STT via the webApp
echo "Enabling HTTPS for OpenWebUI via Tailscale..."
tailscale serve --https=443 http://127.0.0.1:3000

echo "Setup complete! Go to your Tailscale address to authorize the connection."
