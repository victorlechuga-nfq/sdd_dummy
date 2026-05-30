# Tools deterministas

Esta carpeta contiene **herramientas deterministas y repetibles** que el agente usa
para tareas que no deben resolverse "a ojo": validaciones, generadores, conversores,
comprobaciones de formato, etc.

Las menciona `CLAUDE.md`: si el agente necesita una tarea determinista y no existe la
herramienta, **debe crearla aquí** siguiendo esta convención.

## Convención

- **Un fichero por herramienta**, nombre descriptivo en `snake_case` (p.ej.
  `validate_jsonschema.py`).
- **Lenguaje**: Python 3.12 (coherente con el stack del proyecto).
- **Interfaz CLI**: la herramienta se invoca por línea de comandos. Entrada por
  argumentos o `stdin`; salida de resultado por `stdout`; errores por `stderr`.
- **Código de salida**: `0` éxito, distinto de `0` error.
- **Sin efectos colaterales ocultos**: una tool no modifica ficheros salvo que esa
  sea, explícitamente, su función.
- **Determinista**: misma entrada => misma salida.
- **Docstring** al inicio explicando qué hace, su entrada y su salida.

Ver `example_tool.py` como plantilla de referencia.
