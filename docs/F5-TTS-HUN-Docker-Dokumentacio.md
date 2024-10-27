# F5-TTS Magyar Docker Dokumentáció

## start-f5-tts-hun-infer_gradio.bat használati útmutató

### Előfeltételek
- Telepített Docker
- GPU támogatás (NVIDIA driver)
- Internet kapcsolat
- Windows operációs rendszer

### A szkript funkciói

1. **Modell választás**
   - Két előre betanított magyar nyelvű modell közül választhatunk:
     - sarpba model (model_270000_hun_v3.pt)
     - mp3pintyo model (model_122000-hun.pt)

2. **Automatizált Docker környezet**
   - Letölti a legfrissebb F5-TTS Docker image-et
   - Leállítja és eltávolítja a korábban futó konténert
   - Új konténert indít a megfelelő beállításokkal
   - Konfigurálja a modell elérési útját

3. **Portok és kötetek**
   - Port: 7860 (Gradio webes felület)
   - Modellek tárolása: ./f5-tts-models könyvtár
   - Perzisztens adatok: f5-tts-container volume

### Használati útmutató

1. Indítsa el a .bat fájlt dupla kattintással
2. Válassza ki a használni kívánt modellt (1 vagy 2)
3. Várja meg amíg a rendszer:
   - Letölti a Docker image-et
   - Elindítja a konténert
   - Konfigurálja a környezetet
4. A böngésző automatikusan megnyílik a Gradio felülettel
5. Használja a webes felületet a szöveg-hang szintézishez

### Hibaelhárítás

- Ha a konténer nem indul el, ellenőrizze:
  - Fut-e a Docker szolgáltatás
  - Megfelelően van-e telepítve az NVIDIA driver
  - Van-e elegendő szabad hely a lemezen
  - Nincs-e már használatban a 7860-as port

### Rendszerkövetelmények

- Windows 10/11
- NVIDIA GPU (CUDA támogatással)
- Minimum 8GB RAM
- Minimum 10GB szabad lemezterület
- Docker Desktop telepítve
- NVIDIA Container Toolkit telepítve

### Megjegyzések

- A modellek első indításkor automatikusan letöltődnek
- A generált hangfájlok a konténeren belül tárolódnak
- A Gradio felület elérhető más eszközökről is a helyi hálózaton
