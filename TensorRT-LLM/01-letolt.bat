:: HF CLI telepítés (ha még nincs)
python -m pip install -U "huggingface_hub[hf_transfer]"

:: Jelentkezz be, ha kell:
huggingface-cli login

:: Válassz célmappát a hoston
set "MODEL_DIR=D:\AI\models\Qwen2.5-7B-Instruct"

:: Töltsd le a teljes modellt (config.json, tokenizer.*, *.safetensors, stb.)
huggingface-cli download Qwen/Qwen2.5-7B-Instruct --local-dir "%MODEL_DIR%" --local-dir-use-symlinks False
