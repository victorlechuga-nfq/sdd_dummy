# Respuesta a Incidentes

**Versión**: 1.0.0

<!-- SPEC DE OPERACIÓN. Severidades `SEV-N`; pasos del procedimiento `INC-NN`. -->

## Severidades

| Nivel | Definición | Tiempo de respuesta |
|-------|------------|---------------------|
| SEV-1 | Caída total / pérdida de datos | inmediato |
| SEV-2 | Degradación grave | < 1 h |
| SEV-3 | Degradación menor | < 1 día |

## Procedimiento

1. **INC-01** — Detección y declaración del incidente.
2. **INC-02** — Mitigación (priorizar restaurar servicio).
3. **INC-03** — Comunicación a interesados.
4. **INC-04** — Resolución.
5. **INC-05** — Post-mortem sin culpa; las acciones derivadas se registran como
   specs `fix-NNN` o como decisiones en `.specify/memory/context.md`.
