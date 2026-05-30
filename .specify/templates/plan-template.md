# Technical Plan: [NOMBRE DE LA FEATURE]

<!--
  SPEC TECNICA. La genera /speckit.plan a partir de spec.md.
  Ruta: specs/NNN-nombre-feature/plan.md
  Aqui SI se habla de COMO: stack, arquitectura, decisiones tecnicas.
  Cada decision tecnica debe atarse a un criterio de la spec o a un principio
  de la constitution. Sin huerfanos. Si aparece codigo, esta mal ubicado.
-->

**Feature**: `[NNN-nombre-feature]` | **Fecha**: [YYYY-MM-DD] | **Spec**: [ruta a spec.md]

## Constitution Check

<!-- GATE: debe pasar antes de la Fase 0. Re-evaluar tras la Fase 1. -->

- **PR-01**: [como cumple este plan] -- estado
- **PR-02**: [como cumple este plan] -- estado

## Architecture Decision

[Decision tecnica principal y su justificacion. Si se han evaluado alternativas,
referencia `research.md`.]

## Stack para esta Feature

- [Componente]: [tecnologia + version]
- [Componente]: [tecnologia + version]

<!-- El stack debe ser un subconjunto del "Stack Aprobado" de la constitution.
     Cualquier desviacion se justifica aqui y se registra en decisions.md. -->

## Component Design

### [Componente 1]

- **Responsabilidad**: [que hace]
- **Interfaz**: [metodos / endpoints publicos]
- **Dependencias**: [que necesita]

### [Componente 2]

- **Responsabilidad**: [...]
- **Interfaz**: [...]
- **Dependencias**: [...]

## Function Map

<!-- Opcional. Vista de SISTEMA: cada FUN traduce una o varias US a comportamiento
     de sistema. Referencia hacia arriba (US/CA); NO crea numeracion paralela. -->

| Funcion | Implementa | Cubre criterios |
|---------|-----------|-----------------|
| `FUN-001` [nombre] | `US-001` | `CA-US001-01`, `CA-US001-02` |
| `FUN-002` [nombre] | `US-002` | `CA-US002-01` |

## Phase 0: Research (si aplica)

[Resumen de la investigacion previa. Detalle en `research.md`. Resolver aqui toda
marca [NEEDS CLARIFICATION] tecnica.]

## Phase 1: Foundation

- **Data model**: ver `data-model.md`
- **API / event contracts**: ver `contracts/`
- **Quickstart scenarios**: ver `quickstart.md`

## Phase 2: Implementation

[Descripcion de lo que se implementa y en que orden de capas. El desglose
ejecutable en tareas atomicas lo produce /speckit.tasks en `tasks.md`.]

## Risk Assessment

| Riesgo | Probabilidad | Impacto | Mitigacion |
|--------|--------------|---------|------------|
| [Riesgo 1] | Alta / Media / Baja | Alto / Medio / Bajo | [Accion] |
| [Riesgo 2] | Alta / Media / Baja | Alto / Medio / Bajo | [Accion] |

## Complexity Tracking

<!-- Rellenar SOLO si el Constitution Check tiene violaciones que justificar. -->

| Violacion | Por que es necesaria | Alternativa mas simple descartada porque |
|-----------|----------------------|------------------------------------------|
| [...] | [...] | [...] |
