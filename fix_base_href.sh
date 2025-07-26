#!/bin/bash
# Corrige o base href no index.html para funcionar com GitHub Pages

FILE="web/index.html"
PROJECT_NAME="andre_e_elisa"

if [ -f "$FILE" ]; then
  echo "⏳ Corrigindo base href no $FILE..."
  sed -i '' "s|<base href=\"/\">|<base href=\"/$PROJECT_NAME/\">|" "$FILE"
  echo "✅ Base href corrigido para /$PROJECT_NAME/"
else
  echo "❌ Arquivo $FILE não encontrado!"
fi