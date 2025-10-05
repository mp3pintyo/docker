REM --- Útvonalak ---
set "HF_DIR=D:\AI\models\Qwen2.5-7B-Instruct"
set "CKPT_DIR=D:\AI\trtllm_checkpoints\qwen25-7b-int4_awq"
mkdir "%CKPT_DIR%" 2>nul

docker run --rm -it --gpus all --ipc=host ^
  -v "%HF_DIR%":/data/hf ^
  -v "%CKPT_DIR%":/data/ckpt ^
  nvcr.io/nvidia/tensorrt-llm/release:1.2.0rc0 ^
  bash -lc "python3 /app/tensorrt_llm/examples/models/core/qwen/convert_checkpoint.py --model_dir /data/hf --output_dir /data/ckpt --dtype float16 --use_weight_only --weight_only_precision int4 --int8_kv_cache"