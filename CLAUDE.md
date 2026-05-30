<!-- SPECKIT START -->
<!--
  Este bloque lo mantiene SpecKit. El comando /speckit-plan lo actualiza para
  apuntar al plan activo. Cuando exista un plan de feature, lee
  specs/NNN-feature/plan.md para el contexto técnico.
-->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan.
<!-- SPECKIT END -->

# Proyecto SDD — instrucciones para el agente

Este proyecto sigue el paradigma **Spec-Driven Development (SDD)**: la especificación
es la fuente de verdad y el código, los tests y la documentación se **derivan** de
ella. Estas instrucciones son de obligado cumplimiento.

## 0. Convención de invocación de comandos

> Los slash-commands en Claude Code usan **guion** (no punto):
> `/speckit-constitution`, `/speckit-specify`, `/speckit-plan`, etc.
>
> La notación con **punto** (`speckit.specify`, `speckit.git.commit`) es la
> nomenclatura interna usada en `.specify/extensions.yml` y eventos de hook.
> El integrador Claude convierte el punto en guion al construir el slash command
> (`speckit.git.commit` → `/speckit-git-commit`).

## 1. Fuente de verdad

**Lee siempre, antes de cualquier tarea y en este orden:**

1. `spec_pr.md` (raíz del repo) — la spec original del proyecto, escrita por humanos.
   Es inmutable: no se edita salvo decisión explícita registrada.
2. `.specify/memory/constitution.md` — los principios y guardarrailes no negociables.
3. `.specify/memory/context.md` *(extensión propia del scaffold, no SpecKit oficial)* — decisiones y ADRs vivos del proyecto.
4. La spec de la feature activa: `specs/NNN-feature/spec.md`, `plan.md`,
   `tasks.md`, `decisions.md` y `contracts/`.
5. `.specify/ops/` *(extensión propia del scaffold)* — specs de **operación y seguridad**, guardarrailes vinculantes
   para toda implementación: `slos.md`, `testing-strategy.md`, `deployment.md`,
   `secrets.md` e `incidents.md`. Ninguna spec de feature puede contradecirlas.

La implementación debe cumplir **exactamente** los requisitos de la spec. No añadas
funcionalidades que no estén en la spec sin consultarlo primero. Si la spec es
ambigua, no inventes: marca `[NEEDS CLARIFICATION]` y usa `/speckit-clarify`.

## 2. Regla Spec-as-Source

- El código (`src/` o el paquete) y los `tests/` **se derivan de las specs**; no se
  editan a mano por humanos.
- Todo cambio de comportamiento empieza en la `constitution.md` o en una spec de
  feature, nunca directamente en el código.
- Si detectas un bug, abre una nueva spec `fix-NNN`; no parchees el código sin spec.
- Cada PR viaja completo: spec + plan + tasks + código derivado.

## 3. Flujo SDD (orden de comandos)

```text
/speckit-constitution   # una vez por proyecto (+ enmiendas)
/speckit-specify        # una spec por feature
/speckit-clarify        # resolver ambigüedades [NEEDS CLARIFICATION]
/speckit-plan           # plan técnico + data-model + contracts/
/speckit-analyze        # revisión de consistencia (puede repetirse)
/speckit-tasks          # desglose en tareas atómicas
/speckit-analyze        # opcional: re-análisis antes de implementar
/speckit-implement      # ejecución autónoma
/speckit-checklist      # validación de calidad de requisitos (en cualquier momento)
/speckit-docs           # documentación Diátaxis al cerrar release (extensión propia)
```

`/speckit-analyze` puede ejecutarse varias veces; no es un paso único.

## 4. Flujo de validación (TDD)

Este proyecto **impone TDD como Principio constitucional vinculante** (ver
`.specify/memory/constitution.md`, PR-XX, con enforcement en CI).

1. Los tests se escriben **antes** que el código y deben fallar primero (rojo).
2. Antes de cada commit, ejecuta los tests del proyecto.
3. Si los tests fallan, corrige el error en la misma tarea antes de continuar.
4. No marques una tarea como completada si sus tests no pasan.
5. El progreso se registra automáticamente en `.specify/progress.md` (hook
   `final-validation`). No edites ese fichero a mano.

> Nota: en SpecKit oficial los tests son OPCIONALES por defecto. Aquí los hacemos
> obligatorios porque la constitución lo declara así con enforcement verificable.

Los niveles de test, los eval sets y el umbral de cobertura los fija
`.specify/ops/testing-strategy.md`.

Los hooks de `.claude/settings.json` automatizan lint y tests tras cada edición; no
los desactives. Hay **dos sistemas de hooks** distintos en este repo:

- **Hooks de Claude Code** (`.claude/settings.json`): PostToolUse / Stop / SessionStart, ejecutan scripts locales.
- **Hooks de SpecKit** (`.specify/extensions.yml`): `before_specify`, `after_plan`, etc., invocan comandos de extensiones como `speckit.git.commit`.

## 5. Convenciones de commit

Commits **atómicos**: una tarea = un commit. Formato:

```text
tipo(scope): descripción breve
```

`tipo` en `feat | fix | test | refactor | docs | chore`. Ejemplos:
`feat(auth): endpoint de login`, `fix(api): null pointer en users`,
`test(api): cobertura de endpoints REST`. Cada commit referencia el ID de la tarea
y, cuando aplique, el criterio de spec que cubre. No mezcles cambios de tooling con
cambios funcionales en el mismo commit.

## 6. Ramas y releases

- Una rama por feature/release, con su carpeta `specs/NNN-nombre/`.
- `main` solo contiene releases validadas y etiquetadas (tags `vX.Y.Z`).
- El agente trabaja siempre en la rama de la spec activa, **nunca en `main`**.
- Una única spec activa por sesión.
- El merge a `main` y los tags los hace el humano tras validar.

## 7. Tools deterministas

Para tareas deterministas y repetibles consulta `.specify/scripts/tools/`. Si la
herramienta que necesitas no existe, créala siguiendo la convención descrita en
`.specify/scripts/tools/README.md`.

## 8. Infraestructura

Usa **Docker Desktop** (instalado en el anfitrión) para levantar **en local** los
contenedores necesarios de desarrollo y prueba. El stack concreto lo define
`.specify/memory/constitution.md` (sección *Technical Standards*).

## 9. Contratos

Los contratos (`contracts/`) son interfaces **versionadas**, no inmutables absolutas.
Si un contrato debe romperse, hazlo de forma deliberada: nueva versión, compatibilidad
hacia atrás cuando sea posible, y la decisión registrada en `decisions.md`.

## 10. Trazabilidad

### 10.1 Códigos oficiales de SpecKit (los genera el flujo)

- `FR-NNN` — Functional Requirement (en `spec.md` sección *Requirements*).
- `SC-NNN` — Success Criteria (en `spec.md` sección *Success Criteria*; antes era NFR).
- `US1`, `US2`, … — User Story (sin ceros, sin guion; aparece como tag `[US1]` en tasks).
- `T001`, `T002`, … — Task ID (en `tasks.md`).

### 10.2 Códigos de extensión organizativa (este scaffold)

> Estos códigos **no son SpecKit oficial**. Son una convención propia de este proyecto
> para reforzar trazabilidad. Si /speckit-specify no los genera automáticamente, añádelos
> manualmente o usa los oficiales.

- `EP-NN` — épica (agrupación de alto nivel; en `.specify/memory/context.md`).
- `FT-NNN` — feature; es la carpeta `specs/NNN-feature/` (mismo número).
- `PR-NN` — principio de la constitution.
- `CA-USnnn-nn` — criterio de aceptación de una US (1 CA = 1 test ejecutable).
- `FUN-NNN` — función de sistema (opcional, en `plan.md`).
- `ADR-NNN` — decisión de arquitectura (en `context.md` o `decisions.md`).
- `SLO-NN` / `TST-NN` / `DEP-NN` / `SEC-NN` / `INC-NN` — reglas de las specs de
  operación de `.specify/ops/`. Severidades de incidente: `SEV-N`.

### 10.3 Cadena completa

`EP-NN → FT-NNN → US-NNN → CA-USnnn-nn → T0NN → commit → vX.Y.Z`

Cada commit referencia el ID de la tarea y el criterio de spec que cubre. No
inventes códigos nuevos fuera de este esquema.
