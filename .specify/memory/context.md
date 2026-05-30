# Context — decisiones y ADRs del proyecto

<!--
  MEMORIA PERSISTENTE del proyecto. La mantienen el equipo y el agente de forma
  continua. El hook reinjection.ps1 reinyecta este fichero al iniciar sesión.

  Aquí se registra:
  - El estado actual del proyecto (release activa, qué está en curso).
  - Las decisiones de arquitectura (ADRs) con su razón.
  - Cualquier desviación o excepción acordada respecto a las specs.
-->

## Estado actual

- **Release activa**: [NNN-nombre] — [estado]
- **Última validación**: ver `.specify/progress.md`

## Épicas

<!-- Agrupacion de alto nivel. Cada epica `EP-NN` agrupa varias features `FT-NNN`
     (carpetas `specs/NNN-feature/`). -->

### EP-01: [Título de la épica]

- **Objetivo**: [resultado de negocio que persigue]
- **Features**: `FT-NNN`, `FT-NNN`

## Decisiones / ADRs

### ADR-001: [Título de la decisión]

- **Fecha**: [YYYY-MM-DD]
- **Estado**: propuesta | aceptada | sustituida
- **Contexto**: [qué problema motivó la decisión]
- **Decisión**: [qué se decidió]
- **Consecuencias**: [efectos, trade-offs]

<!-- Añade un ADR nuevo por cada decisión técnica relevante. -->
