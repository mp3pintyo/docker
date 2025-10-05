docker run --rm -it --gpus all --ipc=host -p 8000:8000 ^
  -v "D:\AI\trtllm_engines\qwen25-7b-fp16":/data/engine ^
  -v "D:\AI\models\Qwen2.5-7B-Instruct":/data/tokenizer ^
  nvcr.io/nvidia/tensorrt-llm/release:1.2.0rc0 ^
  bash -lc "trtllm-serve serve /data/engine --tokenizer /data/tokenizer --backend tensorrt --host 0.0.0.0 --port 8000 --max_batch_size 1 --max_num_tokens 4096 --kv_cache_free_gpu_memory_fraction 0.7"

