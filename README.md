# Econometría para Finanzas y Contabilidad con R

Material docente para la asignatura de Econometría del Grado en Finanzas y Contabilidad, escrito por **Catalina B. García-García** y **Román Salmerón-Gómez** (Universidad de Granada).

El libro introduce los fundamentos de la Econometría (regresión lineal, variables dicotómicas y cambio estructural, colinealidad, heterocedasticidad y autocorrelación) aplicados a problemas reales de análisis financiero y contable, con ejemplos y código en R.

📖 **Libro publicado:** <https://cbgarciaugr.github.io/EconometriaBasica/>

## Contenidos

- Presentación del material docente
- Tema 1. Introducción a la Econometría
- Tema 2. Modelo de regresión lineal
- Tema 3. Variables dicotómicas y cambio estructural
- Tema 4. Colinealidad
- Tema 5. Heterocedasticidad
- Tema 6. Autocorrelación
- Apéndice. Bases de datos utilizadas en el libro
- Apéndice. Conceptos básicos de álgebra matricial
- Apéndice. Distribuciones estadísticas y valores críticos

## Estructura del repositorio

```
.
├── index.qmd              # Portada / presentación (requerido en la raíz por Quarto)
├── chapters/              # Capítulos y apéndices del libro (.qmd)
├── data/                  # Bases de datos usadas en los ejemplos (.xlsx, .csv, .txt)
├── R/                     # Scripts de R auxiliares (construcción de bases de datos, etc.)
├── recursos/              # Recursos estáticos incluidos en el libro (tablas de valores críticos, etc.)
├── sin-publicar/          # Material en preparación, excluido de la versión publicada
├── _quarto.yml            # Configuración del proyecto Quarto (estructura, formatos, bibliografía)
├── book.bib / packages.bib
├── style.css / preamble.tex
└── .github/workflows/     # Automatización de la publicación en GitHub Pages
```

## Cómo compilar el libro localmente

1. Instala [Quarto](https://quarto.org/docs/get-started/) y R (≥ 4.4).
2. Instala los paquetes de R utilizados en los capítulos:

   ```r
   install.packages(c(
     "car", "dplyr", "ggplot2", "lmtest", "multiColl", "openxlsx",
     "plotly", "quantmod", "readxl", "rvif", "sandwich", "strucchange"
   ))
   ```

3. Renderiza el libro desde la raíz del proyecto:

   ```
   quarto render
   ```

   El resultado (HTML y PDF) se genera en `docs/` (formato PDF requiere `xelatex`, p. ej. vía TinyTeX: `quarto install tinytex`).

## Publicación automática

Cada `push` a `main` dispara el workflow [`quarto-publish.yml`](.github/workflows/quarto-publish.yml), que renderiza el libro en HTML y lo publica en la rama `gh-pages`. El estado de las ejecuciones puede consultarse en la pestaña [Actions](https://github.com/cbgarciaugr/EconometriaBasica/actions).

## Datos

Las bases de datos empleadas en los ejemplos se encuentran en [`data/`](data/) y se describen con detalle en el apéndice *Bases de datos utilizadas en el libro*.

## Licencia y cita

Este material está pensado para uso docente. Si lo utilizas o citas, referencia a los autores: García-García, C.B. y Salmerón-Gómez, R., *Econometría para Finanzas y Contabilidad con R*.
