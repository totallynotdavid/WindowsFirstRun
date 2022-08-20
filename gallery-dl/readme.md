Este archivo puede ser guardado en ```~/gallery-dl/config.json```

Esta configuración agrupa las descargas por sitio y usuario.
Por ejemplo, si deseas descargar todas las imágenes de dos usuarios en Instagram (@usuario_1 y @usuario_2) y Reddit (@usuario_3). Con esta configuración se agruparán del siguiente modo.

```
reddit/
├─ _u_usuario_1/
│  ├─ u_usuario_1/  <-- Imágenes en la misma cuenta del usuario
│  ├─ subreddit1/
│  │  ├─ redgifs/
│  │  │  ├─ redgifs_idurl.mp4
│  │  ├─ subreddit1_usuario1_descripción1_fecha hora.png
│  │  ├─ subreddit1_usuario1_descripción2_fecha hora.png
│  ├─ subreddit2/
│  │  ├─ subreddit2_usuario1_descripción3_fecha hora.png
├─ _u_usuario_2/
│  ├─ u_usuario_2/  <-- Imágenes en la misma cuenta del usuario
│  │  ├─ subreddit1_usuario2_descripción4_fecha hora.png
instagram/
├─ usuario/
│  ├─ IGTV/
│  ├─ Posts/
│  │  │  ├─ (fecha) (id_post) - titulo/
│  │  │  │  ├─ (fecha)_usuario_titulo.jpg
```