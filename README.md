# covidApp
Repositorio remoto para el Examen de tc2007b

Marco Iván Flores Villanueva A01276586 IOS

## Estándares de Commits

Este proyecto sigue [Conventional Commits](https://www.conventionalcommits.org/).

Para detalles completos, consulta [CONTRIBUTING.md](CONTRIBUTING.md#estándares-de-commits).

**Formato básico:**

```
<type>[optional scope]: <description>
```

**Tipos principales:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

**Ejemplos:**

```bash
git commit -m "feat: add user authentication"
git commit -m "fix(api): resolve timeout error"
git commit -m "docs: update installation guide"
```

## Estrategia de Branching

Este proyecto utiliza **Git Flow**.

**Branches principales:**

- `main` - Producción
- `develop` - Integración

**Branches de soporte:**

- `feature/<name>` - Nuevas funcionalidades
- `bugfix/<name>` - Corrección de bugs
- `hotfix/<name>` - Fixes urgentes en producción
- `release/<version>` - Preparación de releases

**Workflow básico:**

```bash
git checkout develop
git checkout -b feature/my-feature
git commit -m "feat: implement my feature"
git push origin feature/my-feature
# Crear Pull Request
```
