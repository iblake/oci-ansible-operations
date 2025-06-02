#!/bin/bash

echo "📦 Generando main.yml en cada role..."

cd roles

for role in */ ; do
  task_dir="${role}tasks"
  if [[ -d "$task_dir" ]]; then
    main_file="$task_dir/main.yml"
    echo "---" > "$main_file"
    for yml in "$task_dir"/*.yml; do
      filename=$(basename "$yml")
      if [[ "$filename" != "main.yml" ]]; then
        echo "- import_tasks: $filename" >> "$main_file"
      fi
    done
    echo "✅ $main_file generado con éxito"
  fi
done

echo "✅ Todos los main.yml han sido creados correctamente."
