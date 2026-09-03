library(quantmod)
library(dplyr)

# Descargar datos de Yahoo Finance
getSymbols(c("^IBEX", "^STOXX50E", "^GSPC"), src = "yahoo")

# Función para obtener cierres mensuales
mensual <- function(x){
  Cl(to.monthly(x, indexAt = "lastof", OHLC = FALSE))
}

# Cierres mensuales
ibex <- mensual(IBEX)
eurostoxx <- mensual(STOXX50E)
sp500 <- mensual(GSPC)

# Unir las tres series
datos <- merge(ibex, eurostoxx, sp500)

# Renombrar columnas
colnames(datos) <- c("IBEX", "EUROSTOXX50", "SP500")

# Conservar los últimos 72 meses
datos <- tail(datos, 72)

# Convertir a data.frame
datos <- data.frame(
  Fecha = index(datos),
  coredata(datos)
)

# Calcular rendimientos mensuales (%)
datos <- datos %>%
  mutate(
    Rend_IBEX = 100 * log(IBEX / lag(IBEX)),
    Rend_EUROSTOXX50 = 100 * log(EUROSTOXX50 / lag(EUROSTOXX50)),
    Rend_SP500 = 100 * log(SP500 / lag(SP500))
  ) %>%
  na.omit()

# Ver la base de datos
head(datos)


modelo <- lm(Rend_IBEX ~ Rend_EUROSTOXX50 + Rend_SP500, data = datos)

summary(modelo)

library(openxlsx)

write.xlsx(datos, "data/BD_IBEX.xlsx", rowNames = FALSE)
