# Política de Secretos y Accesos

**Versión**: 1.0.0

<!-- SPEC DE OPERACIÓN. Cada regla lleva código `SEC-NN`. -->

## Reglas

- **SEC-01** — Ningún secreto en el repositorio. `.env` está en `.gitignore`; se
  versiona solo `.env.example` con las claves vacías.
- **SEC-02** — Ningún secreto ni PII en claro en logs ni en respuestas de API.
- **SEC-03** — [Gestor de secretos usado: variables de entorno / vault / gestor cloud.]

## Accesos

- **SEC-04** — [Roles, principio de mínimo privilegio, rotación de credenciales.]
