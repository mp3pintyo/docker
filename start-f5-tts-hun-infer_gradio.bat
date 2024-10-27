@echo off
echo Lehuzza a legfrissebb Docker kepet...
docker pull ghcr.io/swivid/f5-tts:main

echo Megallitja az esetlegesen mar futo kontenert...
docker stop f5-tts-container

echo Eltavolitja az esetlegesen mar futo kontenert...
docker rm f5-tts-container

echo Elinditja a kontenert es Gradio alkalmazast...
docker run -d --gpus all --add-host=host.docker.internal:host-gateway --name f5-tts-container -p 7860:7860 ^
    -v "%cd%/f5-tts-models:/root/.cache" ^
    -v f5-tts-container:/app/backend/data ^
    ghcr.io/swivid/f5-tts:main

echo Modositja az infer_gradio.py fajlt a konteneren belul...
docker exec f5-tts-container bash -c "sed -i 's|hf://SWivid/F5-TTS/F5TTS_Base/model_1200000.safetensors|hf://custom/path/to/your_model.safetensors|g' /workspace/F5-TTS/src/f5_tts/infer/infer_gradio.py"

echo Elinditja a Gradio alkalmazast a konteneren belul...
docker exec -d f5-tts-container f5-tts_infer-gradio --port 7860 --host 0.0.0.0 --api

echo Varakozas a Gradio feluletre...

:waitloop
timeout /t 3 >nul
powershell -Command "(Invoke-WebRequest -Uri http://localhost:7860 -UseBasicParsing).StatusCode" | findstr 200 >nul
if errorlevel 1 (goto waitloop)

echo Gradio felulet megnyitasa a bongeszoben...
start http://localhost:7860

echo Kesz!
pause
