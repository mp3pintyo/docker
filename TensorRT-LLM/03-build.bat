set "ENGINE_DIR=D:\AI\trtllm_engines\qwen25-7b-fp16"
set "CKPT_DIR=D:\AI\trtllm_checkpoints\qwen25-7b"
mkdir "%ENGINE_DIR%" 2>nul

docker run --rm -it --gpus all --ipc=host ^
  -v "%CKPT_DIR%":/data/ckpt ^
  -v "%ENGINE_DIR%":/data/engine ^
  nvcr.io/nvidia/tensorrt-llm/release:1.2.0rc0 ^
  bash -lc "trtllm-build --checkpoint_dir /data/ckpt --output_dir /data/engine --max_batch_size 1 --max_input_len 4096 --max_seq_len 4096 --gpt_attention_plugin auto --gemm_plugin auto --remove_input_padding enable --context_fmha enable"
