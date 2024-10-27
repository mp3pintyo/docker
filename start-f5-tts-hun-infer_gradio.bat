@echo off
echo Valassza ki a hasznalni kivant modellt:
echo 1: sarpba model - hf://sarpba/F5-TTS-Hun/model_270000_hun_v3.pt
echo 2: mp3pintyo model - hf://mp3pintyo/F5-TTS-Hun/model_122000-hun.pt
set /p model_choice="Irja be a modell szamat (1 vagy 2): "

if "%model_choice%"=="1" (
    set MODEL_PATH="hf://sarpba/F5-TTS-Hun/model_270000_hun_v3.pt"
) else if "%model_choice%"=="2" (
    set MODEL_PATH="hf://mp3pintyo/F5-TTS-Hun/model_122000-hun.pt"
) else (
    echo Ervenytelen valasztas, kilepes...
    pause
    exit /b
)

echo A valasztott modell: %MODEL_PATH%

echo Lehuzza a legfrissebb Docker kepet...
docker pull ghcr.io/swivid/f5-tts:main

echo Megallitja es eltavolitja az esetlegesen mar futo kontenert...
docker stop f5-tts-container
docker rm f5-tts-container

echo Elinditja a kontenert...
docker run -d --gpus all --add-host=host.docker.internal:host-gateway --name f5-tts-container -p 7860:7860 -v "%cd%/f5-tts-models:/root/.cache" -v f5-tts-container:/app/backend/data ghcr.io/swivid/f5-tts:main tail -f /dev/null

echo Varakozas a kontener elindulasara...
timeout /t 5

echo Modositja az infer_gradio.py fajlt a konteneren belul...
docker exec f5-tts-container bash -c "sed -i 's|hf://SWivid/F5-TTS/F5TTS_Base/model_1200000.safetensors|%MODEL_PATH%|g' /workspace/F5-TTS/src/f5_tts/infer/infer_gradio.py"

echo Elinditja a Gradio alkalmazast...
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
