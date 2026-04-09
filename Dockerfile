# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/ali-vilab/TeaCache-ComfyUI.git ComfyUI-TeaCache

# download models - using bf16 Animate model for best realism
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors --relative-path models/diffusion_models --filename wan2.2_animate_14B_bf16.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/text_encoders --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors --relative-path models/vae --filename wan_2.1_vae.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors --relative-path models/clip_vision --filename clip_vision_h.safetensors

# upscale model for 2-pass refinement
RUN comfy model download --url https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.1/RealESRGAN_x2plus.pth --relative-path models/upscale_models --filename RealESRGAN_x2plus.pth
