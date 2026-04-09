# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow lists only unknown-registry custom node types with no aux_id (GitHub repo) provided.
# Each of these could not be resolved automatically and therefore is skipped here. If you have
# the GitHub repo names (aux_id) or registry IDs for these nodes, provide them and the Dockerfile
# can be updated to clone/install them.
# Could not resolve custom node: UNETLoader (unknown registry, no aux_id)
# Could not resolve custom node: CLIPLoader (unknown registry, no aux_id)
# Could not resolve custom node: VAELoader (unknown registry, no aux_id)
# Could not resolve custom node: CLIPVisionLoader (unknown registry, no aux_id)
# Could not resolve custom node: CLIPTextEncode (unknown registry, no aux_id)
# Could not resolve custom node: CLIPTextEncode (unknown registry, no aux_id)
# Could not resolve custom node: LoadImage (unknown registry, no aux_id)
# Could not resolve custom node: LoadVideo (unknown registry, no aux_id)
# Could not resolve custom node: GetVideoComponents (unknown registry, no aux_id)
# Could not resolve custom node: CLIPVisionEncode (unknown registry, no aux_id)
# Could not resolve custom node: WanAnimateToVideo (unknown registry, no aux_id)
# Could not resolve custom node: KSampler (unknown registry, no aux_id)
# Could not resolve custom node: VAEDecode (unknown registry, no aux_id)
# Could not resolve custom node: CreateVideo (unknown registry, no aux_id)
# Could not resolve custom node: SaveVideo (unknown registry, no aux_id)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/blob/main/Wan22Animate/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors --relative-path models/diffusion_models --filename Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/clip --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors --relative-path models/vae --filename wan_2.1_vae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/blob/main/split_files/clip_vision/clip_vision_h.safetensors --relative-path models/clip --filename clip_vision_h.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
