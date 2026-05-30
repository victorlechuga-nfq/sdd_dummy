# Estrategia de Tests

**Versión**: 1.0.0

<!-- SPEC DE OPERACIÓN. Define cómo se prueba el sistema. Cada regla lleva código
     `TST-NN` para poder referenciarla desde specs, planes y tareas. -->

## Niveles de test

- **TST-01** — **Unit** (`tests/unit/`): lógica aislada, sin infraestructura. Los
  corre el hook `auto-test` tras cada edición.
- **TST-02** — **Contract** (`tests/contract/`): validan los ficheros de `contracts/`
  (OpenAPI, JSON Schema, AsyncAPI).
- **TST-03** — **Integration** (`tests/integration/`): integración con dependencias
  reales (base de datos en Docker, colas, etc.).
- **TST-04** — **End-to-end**: escenarios completos descritos en `quickstart.md`.

## TDD

- **TST-05** — Los tests se escriben **antes** que el código y deben fallar primero.
  Cada criterio de aceptación (`CA-US0NN-NN`) de una spec se traduce en al menos un test.

## Umbrales

- **TST-06** — Cobertura mínima unitaria: 80% (ver `constitution.md` y `slos.md` `SLO-07`).
- **TST-07** — Sin merge con CI en rojo.

## Eval sets (componentes con IA)

- **TST-08** — [Definir el eval set: casos dorados, métricas, frecuencia de revisión.]
