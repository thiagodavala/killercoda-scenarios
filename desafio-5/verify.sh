#!/bin/bash

# URL a ser testada
URL="world.universe.mine/argentina"

# Realiza a solicitação e captura o resultado
RESPONSE=$(curl -s "$URL")

# Verifica o conteúdo da resposta
if [ "$RESPONSE" == "hello, you reached Argentina" ]; then
  exit 0
else
  exit 1
fi
