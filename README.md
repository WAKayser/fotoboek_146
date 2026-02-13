# fotoboek maker. 

Set up. 

1. Install typst en iets van python.
2. zorg dat fotos vol staat met alles. 
3. run generate_fotos_typ.py

## during development

typst watch fotoboek.typ

## final file

This takes longer as it needs to work with high resolution images. 

```
typst compile fotoboek.typ --input HQ=true
```

But we dont want this file. because it directly embeds the image with original resolution. 
```
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
    -dQUIET -dDetectDuplicateImages \
    -dCompressFonts=true -r300 -o fotoboek_gs.pdf fotoboek.pdf
```
