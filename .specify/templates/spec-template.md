# Feature: [NOMBRE DE LA FEATURE]

**Épica**: `EP-NN` · **Feature**: `FT-NNN` · **Estado**: borrador | en curso | cerrada

<!--
  SPEC DE PRODUCTO. La genera /speckit-specify a partir de la spec original del
  proyecto (spec_pr.md) o de la descripción del usuario.
  Ruta destino: specs/NNN-nombre-feature/spec.md

  REGLA DE ORO: la spec contesta QUÉ y POR QUÉ, nunca CÓMO. El "cómo" va a plan.md.
  Si aparece stack, librería o framework en este fichero, está mal ubicado.
  Las ocho secciones de abajo son obligatorias y van en este orden.
-->

> **Trazabilidad oficial SpecKit** · `FR-NNN` (functional requirement) ·
> `SC-NNN` (success criteria) · `US1`, `US2`, … (user stories) · `T001` (task).
>
> **Trazabilidad de extensión (este scaffold)** · `EP-NN` → `FT-NNN` →
> `CA-USnnn-nn` (criterio de aceptación) → `T0NN` → commit. Principios:
> `PR-NN`. Cada `CA` se convierte en exactamente un test ejecutable.

## 1. Overview

[Descripción de alto nivel del problema y la solución, en 2-4 frases. Sin jerga
técnica. Legible por negocio.]

## 2. Context

[Por qué se construye esto AHORA. Contexto de negocio relevante, restricciones
temporales, oportunidad.]

## 3. User Stories

<!--
  Una historia por cada journey de usuario, priorizada (P1 = más crítica).
  Cada historia debe ser testable de forma independiente (puede deployarse
  como MVP por sí sola).

  Criterios de aceptación: notación DADO / CUANDO / ENTONCES (Gherkin) o EARS.
-->

### US1: [Acción principal] (Prioridad: P1)

**Como** [tipo de usuario],
**quiero** [acción],
**para** [beneficio medible].

**Acceptance Scenarios:**

- **CA-US001-01** — DADO [contexto] CUANDO [acción] ENTONCES [resultado esperado]
- **CA-US001-02** — DADO [contexto de error/borde] CUANDO [acción] ENTONCES [comportamiento de error]

### US2: [Otra historia] (Prioridad: P2)

**Como** [...], **quiero** [...], **para** [...].

**Acceptance Scenarios:**

- **CA-US002-01** — DADO [...] CUANDO [...] ENTONCES [...]

## 4. Requirements

<!--
  Functional Requirements: códigos FR-NNN oficiales de SpecKit. Cada FR mapea a
  comportamiento del sistema. Si describe HOW o tecnología, está mal ubicado.
-->

- **FR-001**: [El sistema debe …]
- **FR-002**: [El sistema debe …]

### Key Entities (opcional)

- **[Entidad]**: [campos clave, relación principal].

## 5. Success Criteria

<!--
  Antes llamado NFR. Métricas cuantificables y verificables, tecnológicamente
  agnósticas. Códigos SC-NNN oficiales de SpecKit.
-->

- **SC-001** — [Métrica cuantificable, p.ej. "p99 de respuesta < 200 ms"]
- **SC-002** — [Otra métrica, p.ej. "cobertura de la US > 85%"]

## 6. Edge Cases

- [Caso límite 1, p.ej. entrada vacía]: [comportamiento esperado]
- [Caso límite 2, p.ej. valor nulo / overflow]: [comportamiento esperado]

## 7. Out of Scope

- [Lo que esta feature explícitamente NO cubre. Previene el scope-creep.]

## 8. Dependencies

- **Requiere**: [features o servicios previos necesarios]
- **Bloquea**: [features futuras que dependen de esta]

## 9. NEEDS CLARIFICATION

<!--
  Ambigüedades abiertas. /speckit-clarify las convierte en preguntas dirigidas.
  El agente NO debe inventar donde haya una marca [NEEDS CLARIFICATION] sin resolver.
  Máximo recomendado: 3 marcas; prioriza por impacto (alcance > seguridad > UX).
  Cuando todas estén resueltas, deja la sección vacía con "Ninguna".
-->

- [NEEDS CLARIFICATION: pregunta abierta concreta]

## 10. Constitution Alignment

<!-- Ata explícitamente la spec a los principios de .specify/memory/constitution.md -->

- **PR-01**: [cómo cumple esta spec con el principio]
- **PR-02**: [cómo cumple esta spec con el principio]

## Glossary

<!-- Opcional pero recomendado: traduce la jerga de dominio. -->

- **[Término]**: [definición]
