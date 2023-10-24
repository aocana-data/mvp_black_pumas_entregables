#!/bin/bash


echo "SE HA CREADO EL REPOSITORIO GIT Y LA CARPETA"

rm -rf typ-entregables-tbp

mkdir typ-entregables-tbp           \
&&  cd typ-entregables-tbp          \
&&  git init && git branch -M main  \
&&  cd ..

cd MVPS-BP 

find . -maxdepth 1 -type d \( ! -name . \) \
-exec bash -c  \
"cd '{}' \
&& pwd \
&& ls -1 | wc -l \
&& mkdir assets && mv -v *.{pdf,py,ipynb,xlsx,csv,log,docx}  ./assets \
" \;

echo "RESOLVIENDO PROBLEMAS DE ESPACIOS PRIMERA CAPA CARPETAS"
for f in *; do mv -v "$f" "${f//. /.}"; done

echo "LIMPIEZA DE ESPACIOS EN SEGUNDA CAPA"
for f in */*; do mv "$f" "${f//  / }"; done 

echo "LIMPIEZA DE ESPACIOS DOBLES EN TERCERA CAPA"
for f in */*/*; do mv -v "$f" "${f//  / }"; done 


echo "LIMPIEZA DE LEADING SPACES"

find  * -depth -name ' *' -execdir bash -c '
shopt -s extglob
for f; do
    mv -v "$f" "${f#./+([[:space:]])}"
done' _ {} +

find  */* -depth -name ' *' -execdir bash -c '
shopt -s extglob
for f; do
    mv -v "$f" "${f#./+([[:space:]])}"
done' _ {} +

find  */*/* -depth -name ' *' -execdir bash -c '
shopt -s extglob
for f; do
    mv -v "$f" "${f#./+([[:space:]])}"
done' _ {} +

echo $PWD



