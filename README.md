# Proyecto SDD — SpecKit + Claude Code (scaffold `sdd_v1`)

Punto de entrada para personas y agentes nuevos en el proyecto.

Este repositorio sigue **Spec-Driven Development (SDD)** con estrategia
**Spec-as-Source**: la especificación es la fuente de verdad y el código, los tests
y la documentación se **derivan** de ella. La herramienta de orquestación es
[SpecKit](https://github.com/github/spec-kit) sobre Claude Code.

## Convención de comandos

> Los slash-commands en Claude Code usan **guion**: `/speckit-constitution`,
> `/speckit-specify`, `/speckit-plan`, `/speckit-tasks`, etc.
>
> La notación con **punto** (`speckit.specify`) es la nomenclatura interna que
> aparece en `.specify/extensions.yml` y los eventos de hook (SpecKit la convierte
> automáticamente en guion al construir el slash command para Claude Code).

## Estructura del repositorio

```text
repo/
├── spec_pr.md                  Spec original del proyecto (HITL, inmutable)
├── CLAUDE.md                    Instrucciones para el agente
├── README.md  CHANGELOG.md      Entrada y registro de cambios
├── pyproject.toml  mkdocs.yml   Config de deps/tests/lint y de documentación
├── .env.example                 Plantilla de variables de entorno
│
├── specs/                       SPECS DE FEATURE (oficial SpecKit, raíz del repo)
│   └── NNN-feature/             Una carpeta por feature (spec.md, plan.md, tasks.md, contracts/)
│
├── .claude/                     Configuración de Claude Code
│   ├── settings.json            Permisos + hooks de Claude Code (PostToolUse, Stop, SessionStart)
│   ├── hooks/                   *.sh + *.ps1 (paridad bash/PowerShell)
│   └── skills/                  Comandos speckit-* (incluido speckit-docs)
│
├── .specify/                    Framework SpecKit
│   ├── memory/                  constitution.md (oficial) · context.md (EXTENSIÓN: ADRs)
│   ├── ops/                     EXTENSIÓN: specs de operación y seguridad
│   ├── templates/               Plantillas base de spec/plan/tasks/...
│   ├── scripts/                 scripts/bash/ + scripts/powershell/ (paridad obligatoria)
│   ├── extensions/git/          EXTENSIÓN SpecKit para auto-commit por evento
│   ├── extensions.yml           Hooks de SpecKit (before_specify, after_plan, …)
│   ├── workflows/speckit/       Workflow declarativo full SDD
│   └── init-options.json        speckit_version, script, branch_numbering, …
│
├── .github/workflows/           EXTENSIÓN CI (ci.yml) + puerta Spec-as-Source (spec-guard.yml)
└── docs/                        EXTENSIÓN Documentación Diátaxis (la genera /speckit-docs)
```

> **Nota sobre hooks**: hay dos sistemas distintos en este repo:
>
> 1. **Hooks de Claude Code** (`.claude/settings.json`): se disparan por eventos
>    de Claude (PostToolUse, Stop, SessionStart). Ejecutan scripts locales.
> 2. **Hooks de SpecKit** (`.specify/extensions.yml`): se disparan por eventos del
>    flujo SDD (`before_specify`, `after_plan`, …). Invocan comandos de extensiones
>    (típicamente `speckit.git.commit`).

## Puesta en marcha

Requisitos: Git, Python 3.11+, uv, jq, Claude Code CLI y Specify CLI.

```bash
cd <ruta-del-proyecto>
specify check                       # verifica el entorno
claude                              # abre Claude Code en el repo
```

## Flujo SDD

```text
/speckit-constitution   principios del proyecto (una vez)
/speckit-specify        una spec por feature
/speckit-clarify        resuelve ambigüedades [NEEDS CLARIFICATION]
/speckit-plan           plan técnico + data-model + contracts/
/speckit-analyze        consistencia (repetible)
/speckit-tasks          tareas atómicas
/speckit-analyze        opcional: re-análisis antes de implementar
/speckit-implement      ejecución autónoma
/speckit-checklist      validación de calidad de requisitos (en cualquier momento)
/speckit-docs           documentación Diátaxis al cerrar release (extensión propia)
```

El detalle operativo está en [`CLAUDE.md`](CLAUDE.md).

## Automatización (hooks de Claude Code)

Definidos en `.claude/settings.json`, se ejecutan solos:

- **auto-lint** (tras cada edición en `src/` o `tests/`): formatea el código.
- **auto-test** (tras editar Python en `src/` o `tests/`): corre tests unitarios;
  si fallan, el agente recibe el error y corrige.
- **final-validation** (al cerrar turno): corre la suite completa y registra el
  resultado en `.specify/progress.md`.
- **reinjection** (al iniciar sesión): recarga la spec original, la constitution y el context.

Los hooks son **portables y multiplataforma**: cada uno existe como `.sh` (bash) y
`.ps1` (PowerShell); `settings.json` invoca el bash y cae al PowerShell si falla.

## Extensiones propias (no SpecKit oficial)

Este scaffold añade convenciones organizativas que **no** son parte de SpecKit oficial:

- `.specify/memory/context.md` — ADRs vivos y estado de épicas.
- `.specify/ops/` — specs de operación: `slos.md`, `testing-strategy.md`,
  `deployment.md`, `secrets.md`, `incidents.md`.
- Skill `/speckit-docs` — generador de documentación Diátaxis.
- Códigos de trazabilidad `EP-NN`, `FT-NNN`, `CA-USnnn-nn`, `FUN-NNN`, `ADR-NNN`,
  `SLO-NN`, `DEP-NN`, `SEC-NN`, `INC-NN`, `TST-NN`, `SEV-N`.
- Workflow CI `spec-guard.yml`.

Las extensiones son útiles, pero recuerda: si actualizas SpecKit con `specify upgrade`,
estas piezas las mantienes tú.

## Releases

Una rama y una carpeta `specs/NNN-nombre/` por release. `main` solo recibe
releases validadas y etiquetadas (`vX.Y.Z`). La puerta `spec-guard` rechaza en CI
cualquier PR que cambie código sin un delta de spec que lo respalde (con
excepciones explícitas para docs/, tooling y archivos de configuración).
