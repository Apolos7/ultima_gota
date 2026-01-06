#!/bin/bash

flavor="--release"
target="lib/main.dart"
flutter_bin="fvm flutter"

echo "=============================="
echo " Flutter Build Script"
echo "=============================="
echo ""
echo "Selecione o tipo de build:"
echo "1) APK"
echo "2) AppBundle"
read -p "Opção: " build_type

case $build_type in
  1)
    build_cmd="apk"
    ;;
  2)
    build_cmd="appbundle"
    ;;
  *)
    echo "Opção inválida!"
    exit 1
    ;;
esac

echo ""
echo "Executando build..."
echo "$flutter_bin build $build_cmd $flavor -t $target"
echo ""

$flutter_bin build $build_cmd $flavor -t $target

if [ $? -eq 0 ]; then
  echo "Build concluído com sucesso"
else
  echo "Erro no build!"
fi