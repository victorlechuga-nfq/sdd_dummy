# SLOs y Límites Operativos

**Versión**: 1.0.0
**Revisión**: trimestral

<!-- SPEC DE OPERACIÓN. Mantenida a mano (SpecKit no la genera). Plantilla: rellena
     con los valores reales del proyecto. Cada SLO lleva código `SLO-NN` para que
     specs, planes y tests puedan referenciarlo. -->

## Disponibilidad

- **SLO-01** — API pública: 99.9% mensual
- **SLO-02** — Agente principal: 99.5% mensual

## Latencia

- **SLO-03** — p95 API: < 300 ms
- **SLO-04** — p95 ejecución de agente: < 5 s

## Coste

- **SLO-05** — Coste máximo por ejecución de agente: 0,05 €
- **SLO-06** — Alerta si el coste diario supera 50 €

## Tests y Cobertura

- **SLO-07** — Cobertura mínima unitaria: 80%
- **SLO-08** — Eval set estático de agentes: revisión semanal
- **SLO-09** — Tasa de alucinaciones tolerable: < 2%

## Procedimiento de Alerta

| SLO vigilado | Umbral | Acción |
|--------------|--------|--------|
| `SLO-NN` | [Métrica supera X] | [Acción / responsable / canal] |
