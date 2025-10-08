# 📊 Análisis Estadístico de las Causas de Muerte en España (INE)
---

## 📘 Descripción del Proyecto

Este repositorio contiene un **script en R** para realizar un análisis descriptivo y exploratorio sobre los **datos de causas de muerte en España**, obtenidos del **Instituto Nacional de Estadística (INE)**.  

El objetivo es identificar patrones relevantes en las defunciones según **sexo**, **edad**, **año** y **tipo de causa**, mediante el uso de **visualizaciones y medidas estadísticas básicas**.

---
### Variables principales
| Variable | Tipo | Descripción |
|-----------|------|-------------|
| `Causa de muerte` | Categórica | Causa específica de la defunción |
| `Sexo` | Categórica | Hombre / Mujer / Total |
| `Edad` | Categórica | Grupo de edad o “Todas las edades” |
| `Periodo` | Numérica / Factor | Año de registro |
| `Total` | Numérica | Número total de fallecimientos |

---
## 📊 Análisis Descriptivo y Exploratorio

### 🔹 Análisis Univariante
- **Histograma** de fallecimientos por año.  
- **Gráfico de barras** de las principales causas de muerte.  

### 🔹 Análisis Bivariante
- **Diagrama de barras apiladas:** relación entre causa de muerte y sexo.  
- **Barras múltiples:** comparación entre grupos de edad y sexo.  
- **Gráfico de líneas:** evolución temporal de fallecimientos por sexo.

### 🔹 Calidad de los Datos
- Detección y tratamiento de valores nulos o atípicos.  
- Estandarización de categorías (“Edad” y “Causa de muerte”).  

**Conclusiones principales:**
- Las **enfermedades circulatorias** y los **tumores** son las principales causas de muerte.  
- Los **hombres** presentan mayor mortalidad por causas externas y respiratorias.  
- La **mortalidad aumenta con la edad**, sobre todo a partir de los 70 años.  
- El **aumento en 2020–2021** se asocia con la pandemia de COVID-19.

---
