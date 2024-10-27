# F5-TTS Alap Docker Dokumentáció

## start-f5-tts-infer_gradio.bat használati útmutató

### Előfeltételek
- Telepített Docker
- GPU támogatás (NVIDIA driver)
- Internet kapcsolat
- Windows operációs rendszer

### A szkript funkciói

1. **Automatizált Docker környezet**
   - Letölti a legfrissebb F5-TTS Docker image-et
   - Leállítja és eltávolítja a korábban futó konténert
   - Új konténert indít a megfelelő beállításokkal
   - Automatikusan elindítja a Gradio felületet

2. **Portok és kötetek**
   - Port: 7860 (Gradio webes felület)
   - Modellek tárolása: ./f5-tts-models könyvtár
   - Perzisztens adatok: f5-tts-container volume

### Használati útmutató

1. Indítsa el a .bat fájlt dupla kattintással
2. Várja meg amíg a rendszer:
   - Letölti a Docker image-et
   - Elindítja a konténert
   - Elindítja a Gradio alkalmazást
3. A böngésző automatikusan megnyílik a Gradio felülettel
4. Használja a webes felületet a szöveg-hang szintézishez

### Különbségek a Magyar verzióhoz képest

- Nincs modellválasztási lehetőség
- Az alapértelmezett modellt használja
- Egyszerűbb konfigurációs folyamat
- Közvetlen indítás extra beállítások nélkül

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
