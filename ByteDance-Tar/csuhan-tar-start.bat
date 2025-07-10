@echo off
set CONTAINER_NAME=tar-7b-app
set IMAGE_NAME=registry.hf.space/csuhan-tar-7b:latest

echo.
echo Kontener leallitasa es eltavolitasa (ha mar letezik)...
docker stop %CONTAINER_NAME%
docker rm %CONTAINER_NAME%

echo.
echo Image frissitese a legujabb verziora...
docker pull %IMAGE_NAME%

echo.
echo Uj kontener inditasa...
:: A ^ jel csak a sortores a jobb olvashatosagert.
docker run --name %CONTAINER_NAME% -it -p 7860:7860 ^
  -v huggingface-cache:/root/.cache/huggingface ^
  --platform=linux/amd64 --gpus all ^
  -e HF_TOKEN="xxx" ^
  %IMAGE_NAME% python app.py
  
echo.
echo A szkript befejezte a futast.
pause