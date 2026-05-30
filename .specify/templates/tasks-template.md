# Tasks: [NOMBRE DE LA FEATURE]

<!--
  SPEC DE EJECUCIÓN. La genera /speckit-tasks a partir de plan.md y spec.md.
  Ruta: specs/NNN-nombre-feature/tasks.md
  Es el fichero que ejecuta el agente en /speckit-implement.
-->

> **Regla Spec-as-source**: estas tareas las ejecuta el agente IA.
> No se modifican `src/` ni `tests/` manualmente.
>
> **TDD**: en SpecKit oficial los tests son **opcionales** salvo que la
> constitution del proyecto declare lo contrario. Este scaffold los hace
> obligatorios mediante Principio PR-XX con enforcement en CI; los tests se
> escriben ANTES que el código y deben fallar primero (rojo).
>
> **Commits atómicos**: 1 tarea = 1 commit. Formato `tipo(scope): descripción`.
> Cada commit enlaza el ID de la tarea y el criterio de spec que cubre.

## Formato de tarea

`- [ ] [TID] [P?] [USN?] Descripción (ruta de fichero) -> verifica [CA-USnnn-nn?]`

- **[TID]**: identificador de tarea `T001`, `T002`… (oficial SpecKit).
- **[P]**: paralelizable (ficheros distintos, sin dependencias pendientes).
- **[USN]**: user story a la que pertenece (`[US1]`, `[US2]` sin guion ni ceros,
  oficial SpecKit). Obligatorio en las fases de implementación.
- **[CA-USnnn-nn]**: criterio de aceptación cubierto (extensión propia; en las
  tareas de test, cada test mapea a exactamente un criterio).

## Phase 1: Setup

- [ ] T001 [P] Inicializar estructura del paquete y configuración de tooling
- [ ] T002 [P] Configurar entorno de desarrollo (Docker, dependencias)

## Phase 2: Foundational (bloquea historias)

- [ ] T010 Crear `data-model.md` con entidades, campos, índices e invariantes
- [ ] T011 Crear `contracts/api-spec.json` (OpenAPI 3.x) y/o `contracts/events.yaml`
- [ ] T012 Crear `quickstart.md` con los escenarios de validación end-to-end

## Phase 3: User Story 1 — [Nombre breve] (Prioridad: P1) 🎯 MVP

**Goal**: [resultado observable de esta US como MVP independiente]

### Tests (TDD — primero los tests, deben fallar)

- [ ] T100 [P] [US1] Test unitario `tests/unit/test_[X].py` -> verifica `CA-US001-01`
- [ ] T101 [P] [US1] Test de contrato `tests/contract/test_[X].py` -> verifica `CA-US001-02`

### Implementation

- [ ] T110 [US1] Implementar modelo `src/models/[X].py`
- [ ] T111 [US1] Implementar repositorio `src/repositories/[X]_repo.py` (depende: T110)
- [ ] T112 [US1] Implementar servicio `src/services/[X]_service.py` (depende: T111)

**Checkpoint**: tests US1 en VERDE, US1 deployable como MVP.

## Phase 4: User Story 2 — [Nombre breve] (Prioridad: P2)

**Goal**: [resultado observable]

### Tests

- [ ] T200 [P] [US2] Test de integración `tests/integration/test_[X]_api.py` -> verifica `CA-US002-01`

### Implementation

- [ ] T210 [US2] Implementar router/endpoint `src/routers/[X]_router.py`

**Checkpoint**: tests US2 en VERDE; US1 sigue funcionando.

## Phase N: Polish

- [ ] T900 Ejecutar la suite completa; cobertura >= [NN]% (umbral de la constitution)
- [ ] T901 Verificar alineamiento de `contracts/` con la implementación
- [ ] T902 Verificar que cada `CA-USnnn-nn` de spec.md tiene su test verde

## Notas

- `[P]` = tareas paralelizables (ficheros distintos, sin dependencias mutuas).
- Cada tarea es lo bastante concreta como para ejecutarse sin contexto adicional.
- Si se aplica TDD, confirmar que los tests fallan antes de implementar.
- Un commit atómico por tarea completada; marcar la tarea como `[x]` al cerrarla.
- **No introducir dependencias cruzadas entre user stories**: cada US debe ser
  testeable y deployable por separado.
