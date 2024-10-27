@echo off
echo Lehuzza a legfrissebb Docker kepet...
docker pull ghcr.io/swivid/f5-tts:main

echo Szerkeszti az infer_gradio.py fajlt...
powershell -Command "(Get-Content src\f5_tts\infer\infer_gradio.py).replace('hf://SWivid/F5-TTS/F5TTS_Base/model_1200000.safetensors', 'hf://sarpba/F5-TTS-Hun/model_270000_hun_v3.pt') | Set-Content src\f5_tts\infer\infer_gradio.py"

echo Megallitja az esetlegesen mar futo kontenert...
docker stop f5-tts-container

echo Eltavolitja az esetlegesen mar futo kontenert...
docker rm f5-tts-container

echo Elinditja a kontenert es Gradio alkalmazast...
docker run -d --gpus all --add-host=host.docker.internal:host-gateway --name f5-tts-container -p 7860:7860 ^
    -v "%cd%/f5-tts-models:/root/.cache" ^
    -v f5-tts-container:/app/backend/data ^
    ghcr.io/swivid/f5-tts:main f5-tts_infer-gradio --port 7860 --host 0.0.0.0 --api

echo Varakozas a Gradio feluletre...

:waitloop
timeout /t 3 >nul
powershell -Command "(Invoke-WebRequest -Uri http://localhost:7860 -UseBasicParsing).StatusCode" | findstr 200 >nul
if errorlevel 1 (goto waitloop)

echo Gradio felulet megnyitasa a bongeszoben...
start http://localhost:7860

echo Kesz!
pause