# fotoboek maker. 


## during development

The repo already contains the thumbnails. So you can just call: 

```
typst watch fotoboek.typ
```

this will show updates on saving the file. 

## final file

This takes longer as it needs to work with high resolution images. 
Also you need a copy of the full resolution files. Ask wouter. 

```
typst compile fotoboek.typ --input HQ=true
```

But we dont want this file. because it directly embeds the image with original resolution. 
```
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
    -dQUIET -dDetectDuplicateImages \
    -dCompressFonts=true -r300 -o fotoboek_gs.pdf fotoboek.pdf
```
