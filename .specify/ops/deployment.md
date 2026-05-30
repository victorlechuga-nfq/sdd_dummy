# Despliegue y Rollback

**Versión**: 1.0.0

<!-- SPEC DE OPERACIÓN. Flujos de despliegue. Cada regla lleva código `DEP-NN`. -->

## Entornos

- **DEP-01** — sandbox: pruebas, datos sintéticos.
- **DEP-02** — producción: datos reales.

## Flujo de despliegue

1. **DEP-03** — Release validada y etiquetada (`git tag vX.Y.Z`).
2. **DEP-04** — [Pipeline de build / publicación de imagen Docker.]
3. **DEP-05** — [Estrategia: canary / blue-green / rolling.]

## Rollback

- **DEP-06** — [Procedimiento de vuelta atrás y criterio de activación.]

## Contenedores

- **DEP-07** — El stack se levanta con Docker (ver `constitution.md`, *Technical Standards*).
