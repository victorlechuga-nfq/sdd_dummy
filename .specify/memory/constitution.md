# Project Constitution: [PROJECT_NAME]

**Version**: 1.0.0
**Ratified**: [YYYY-MM-DD]
**Last Amended**: [YYYY-MM-DD]

<!--
  La constitution es la SPEC DE COMPORTAMIENTO del proyecto: la capa base que todo
  agente lee antes de generar cualquier artefacto. La genera y actualiza el comando
  /speckit.constitution. No se rehace: se enmienda.

  Cada principio se identifica como `PR-NN` y se referencia desde spec.md
  (Constitution Alignment) y plan.md (Constitution Check).
  Cada principio tiene SIEMPRE tres campos. Sin "Enforcement" un principio es un deseo,
  no una regla. El "Enforcement" debe ser verificable por una maquina o por un revisor
  concreto (un test en CI, una regla de lint, un check de plantilla de PR).
-->

---

## Core Principles

### PR-01 — [NOMBRE_CORTO]

- **Statement**: [Que se exige, formulado como regla clara y no negociable.]
- **Rationale**: [Por que es no negociable; que coste evita.]
- **Enforcement**: [Como se valida: test en CI, regla de lint, revision de PR...]

### PR-02 — [NOMBRE_CORTO]

- **Statement**: [...]
- **Rationale**: [...]
- **Enforcement**: [...]

### PR-03 — [NOMBRE_CORTO]

- **Statement**: [...]
- **Rationale**: [...]
- **Enforcement**: [...]

<!-- Anade o quita principios segun el proyecto. Solo va aqui lo NO negociable:
     si lo vas a renegociar cada feature, es una preferencia, no un principio. -->

---

## Technical Standards

### Stack Aprobado

<!-- El Stack Aprobado se elige del CATALOGO DE ARQUETIPOS TECNICOS de la
     organizacion (catalogo transversal, mantenido aparte de los proyectos:
     PostgreSQL, MongoDB, Snowflake, BigQuery, Kafka, FastAPI, React).
     No se inventan tecnologias sueltas: se elige un arquetipo por capa y se
     cita. Ejemplo de referencia (app MDQ): -->

- Runtime: [lenguaje + version, p.ej. Python 3.12+]
- Framework: [p.ej. FastAPI]
- Base de datos: [p.ej. MongoDB (Docker local) / Snowflake (produccion)]
- Mensajeria: [p.ej. Kafka, o N/A]
- Tests: [p.ej. pytest + coverage >= 80%]
- Linting / formato: [p.ej. ruff]

### Patrones Permitidos

- [Patron 1]: [cuando usarlo]
- [Patron 2]: [cuando usarlo]

### Anti-Patrones Prohibidos

- [Anti-patron 1]: [motivo]
- [Anti-patron 2]: [motivo]

---

## Quality Gates

- Cobertura minima de tests unitarios: [NN]% (recomendado >= 80%).
- Sin merge si CI esta en rojo.
- Todo endpoint documentado con contrato (OpenAPI 3.x / AsyncAPI).
- Sin PII en claro en logs ni en respuestas de API.
- Todo cambio de comportamiento llega acompanado de su test.

---

## Spec-as-Source Rules [OBLIGATORIO]

- Ningun fichero en `src/` (o el paquete de codigo) ni en `tests/` se modifica
  directamente por humanos. El codigo y los tests se derivan de las specs.
- Todo cambio de comportamiento comienza en esta constitution o en una spec de feature.
- Si un agente detecta un bug, abre una nueva spec `fix-NNN` en lugar de parchear el
  codigo directamente.
- Cada PR viaja completo: spec + plan + tasks + codigo derivado.

---

## Governance

- **Enmiendas**: requieren PR con revision (tech lead + steward) y plan de migracion
  si afectan a artefactos existentes.
- **Versionado semantico de la constitution**:
  - MAJOR: se elimina o redefine un principio (cambio incompatible).
  - MINOR: se anade un principio o seccion, o se amplia guia de forma material.
  - PATCH: aclaraciones, correccion de erratas, ajustes no semanticos.
- **Revision periodica**: trimestral.
- Esta constitution prevalece sobre cualquier otra practica. Toda complejidad debe
  justificarse frente a estos principios.
