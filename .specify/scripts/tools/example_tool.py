#!/usr/bin/env python3
"""example_tool — plantilla de referencia para tools deterministas.

Cuenta las líneas no vacías de un fichero de texto.

Uso:
    python example_tool.py <ruta_fichero>

Salida (stdout): el número de líneas no vacías.
Código de salida: 0 si todo va bien; 1 ante error.
"""
import sys
from pathlib import Path


def count_non_empty_lines(path: Path) -> int:
    """Devuelve el número de líneas no vacías del fichero indicado."""
    text = path.read_text(encoding="utf-8")
    return sum(1 for line in text.splitlines() if line.strip())


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print("uso: python example_tool.py <ruta_fichero>", file=sys.stderr)
        return 1
    path = Path(argv[1])
    if not path.is_file():
        print(f"error: no existe el fichero {path}", file=sys.stderr)
        return 1
    print(count_non_empty_lines(path))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
