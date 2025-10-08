# Instalar y cargar las librerías necesarias
install.packages("ggplot2")
install.packages("dplyr")
install.packages("scales") # Para formatear los números
library(ggplot2)
library(dplyr)
library(readxl)
library(scales)

# Leer el archivo Excel
file_path <- "C:/Users//OneDrive/Escritorio/causasdemuerte.xlsx"
datos <- read_excel(file_path, sheet = "datos")
# Estadísticas descriptivas
summary(datos)            # Resumen general de todas las variables
mean(datos$Total, na.rm = TRUE)   # Media del total de fallecimientos
sd(datos$Total, na.rm = TRUE)     # Desviación estándar de fallecimientos

# Convertir el Periodo a factor
datos$Periodo <- as.factor(datos$Periodo)
#Univariantes
# 1. Histograma de fallecimientos por año (Periodo)
ggplot(datos, aes(x = Periodo, y = Total)) +
  geom_col(fill = "purple", width = 0.9) + # Ajustar el ancho de las barras
  scale_y_continuous(labels = comma) +
  labs(title = "Histograma de fallecimientos por año",
       x = "Año",
       y = "Número de fallecimientos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotar etiquetas del eje X

# 2. Gráfico de barras de las principales causas de muerte
# Filtrar las 10 principales causas (excluyendo "Todas las causas")
principales_causas <- datos %>%
  filter(`Causa de muerte` != "001-102  I-XXII.Todas las causas") %>%
  group_by(`Causa de muerte`) %>%
  summarise(Total = sum(Total, na.rm = TRUE)) %>%
  arrange(desc(Total)) %>%
  head(10)

ggplot(principales_causas, aes(x = reorder(`Causa de muerte`, -Total), y = Total)) +
  geom_bar(stat = "identity", fill = "pink") +
  coord_flip() +
  scale_y_continuous(labels = comma) + # Evitar notación científica
  labs(title = "Top 10 causas de muerte",
       x = "Causa de muerte",
       y = "Total de fallecimientos") +
  theme_minimal()


#Bivariantes
# 3. Diagrama de barras por sexo y edad
# Filtrar datos excluyendo "Todas las edades"
sexo_edad <- datos %>%
  filter(Edad != "Todas las edades", Sexo != "Total")

ggplot(sexo_edad, aes(x = Edad, y = Total, fill = Sexo)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) + # Ajustar el ancho de las barras
  scale_y_continuous(labels = comma) +
  labs(title = "Fallecimientos por sexo y grupo de edad",
       x = "Grupo de edad",
       y = "Total de fallecimientos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotar etiquetas del eje X


# 4. Gráfico de línea para el total de fallecimientos por año, separado por Sexo
fallecimientos_anuales_sexo <- datos %>%
  group_by(Periodo, Sexo) %>%
  summarise(Total = sum(Total, na.rm = TRUE))

ggplot(fallecimientos_anuales_sexo, aes(x = Periodo, y = Total, color = Sexo, group = Sexo)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_y_continuous(labels = comma) + # Evitar notación científica
  labs(title = "Tendencia de fallecimientos por año y sexo",
       x = "Año",
       y = "Total de fallecimientos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotar etiquetas del eje X


#grafico 5 Filtrar las causas principales de muerte, excluyendo "Todas las causas"
# y agrupar por causa de muerte y sexo
causas_sexo <- datos %>%
  filter(`Causa de muerte` != "001-102  I-XXII.Todas las causas") %>%
  group_by(`Causa de muerte`, Sexo) %>%
  summarise(Total = sum(Total, na.rm = TRUE)) %>%
  arrange(desc(Total))

# Seleccionar las 10 causas principales para una visualización más clara
top_causas <- causas_sexo %>%
  group_by(`Causa de muerte`) %>%
  summarise(Total = sum(Total)) %>%
  arrange(desc(Total)) %>%
  slice(1:10) %>%
  pull(`Causa de muerte`)

# Filtrar el dataset para solo incluir las 10 causas principales
causas_sexo_top <- causas_sexo %>%
  filter(`Causa de muerte` %in% top_causas)

# Crear gráfico de barras apiladas
ggplot(causas_sexo_top, aes(x = reorder(`Causa de muerte`, -Total), y = Total, fill = Sexo)) +
  geom_bar(stat = "identity", position = "stack") + # Cambiar a "dodge" para barras lado a lado
  coord_flip() +
  labs(title = "Distribución de las 10 principales causas de muerte por sexo",
       x = "Causa de muerte",
       y = "Total de fallecimientos",
       fill = "Sexo") +
  theme_minimal() +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

boxplot(datos$Total, main = "Revisión de valores atípicos en Total")
sum(is.na(datos))         # Contar valores nulos
sum(duplicated(datos))    # Contar duplicados
unique(datos$`Causa de muerte`)  # Revisión de nombres de causas
unique(datos$Edad)               # Revisión de rangos de edad
