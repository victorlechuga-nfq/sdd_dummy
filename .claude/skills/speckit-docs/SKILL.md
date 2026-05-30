---
name: "speckit-docs"
description: "Genera documentacion tecnica completa siguiendo el framework Diataxis (tutorials, how-to, reference, explanation) para una release. Lee spec.md, contracts/, tasks.md completadas y docstrings del codigo. Produce los .md listos para MkDocs y actualiza el CHANGELOG."
argument-hint: "Opcional: la release o feature a documentar (por defecto, la activa)"
compatibility: "Requires spec-kit project structure with .specify/ directory"
metadata:
  author: "sdd-v1 (custom)"
  source: "PDF 002 - Configuracion SDD con SpecKit"
user-invocable: true
disable-model-invocation: false
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

# speckit-docs

Genera documentacion tecnica siguiendo el framework **Diataxis** para la release actual.
Se ejecuta al **final de cada release**, despues de `/speckit.implement`.

## Fuentes de verdad (leer en este orden)

1. `specs/NNN-xxx/spec.md` -- que hace el sistema y por que
2. `specs/NNN-xxx/contracts/` -- interfaces y contratos
3. `specs/NNN-xxx/tasks.md` -- solo tareas marcadas `[x]`, para el CHANGELOG
4. Docstrings del codigo -- para `reference/api/`
5. `.specify/memory/constitution.md` y `CLAUDE.md` -- principios de arquitectura
6. `.specify/memory/context.md` -- decisiones / ADRs, para `explanation/`

## Reglas absolutas

- NO inventar funcionalidades que no esten en `spec.md` o en `contracts/`.
- NO mezclar tipos Diataxis: tutorial != how-to != reference != explanation.
- Los ejemplos deben ser ejecutables con la implementacion actual.
- El onboarding debe llevar a un "primer run exitoso" en menos de 10 pasos.
- NO ejecutar tests ni modificar codigo: este skill solo escribe documentacion.

## Output obligatorio por release

### 1. docs/index.md
Punto de entrada: que es el proyecto, para quien, y enlaces a las 4 secciones Diataxis.

### 2. docs/tutorials/first-<feature>.md
- Un tutorial por User Story principal. Estilo "vamos a hacer X juntos".
- El lector hace algo real y obtiene un resultado visible. NO explicar el por que.

### 3. docs/how-to/*.md
- Una guia por accion / subcomando publico (extraer de `contracts/`).
- Formato: problema -> pasos numerados -> resultado esperado. Incluir errores comunes.

### 4. docs/reference/*.md
- `reference/cli.md` (o `api.md`): tabla de comandos/endpoints, flags, defaults, tipos.
- `reference/data-model.md`: esquema documentado campo a campo (desde `data-model.md`).
- `reference/api/`: generado por mkdocstrings desde los docstrings del codigo.

### 5. docs/explanation/architecture.md
- Las decisiones de diseno clave y su porque, a partir de los ADRs de `context.md`
  y de `decisions.md` de la feature.

### 6. CHANGELOG.md
- Una entrada por release basada en las tareas `[x]` de `tasks.md`.
- Formato Keep a Changelog: `## [version] - fecha` / `### Added` / `### Fixed` / `### Changed`.

## Proceso de ejecucion

1. Leer todas las fuentes de verdad.
2. Identificar que User Stories estan completas (`[x]` en `tasks.md`).
3. Generar los outputs anteriores.
4. NO ejecutar tests ni modificar codigo.
5. Informar de que secciones quedaron vacias por falta de spec.

## Verificacion antes de escribir

Para cada fichero a generar, confirmar:
- El contenido viene de `spec.md` o `contracts/`  ->  escribir.
- Se esta inventando comportamiento  ->  NO escribir; marcarlo como `TODO`.

## Despues de generar

Sugerir al usuario:

```text
mkdocs serve     # preview en http://127.0.0.1:8000
mkdocs build     # genera el site estatico en site/
git add docs/ CHANGELOG.md
git commit -m "docs(release): vX.Y.Z"
```
