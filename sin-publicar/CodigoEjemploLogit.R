```r
# ============================================================
# 1. CARGAR LIBRERÍAS
# ============================================================

library(dplyr)
library(lubridate)


# ============================================================
# 2. CARGAR LA BASE DE DATOS
# ============================================================

df <- read.csv(
  "Motor_vehicle_insurance_data.csv",
  sep = ";",
  dec = ",",
  fileEncoding = "UTF-8"
)

head(df)


# ============================================================
# 3. CREAR LA VARIABLE DEPENDIENTE: Has_Claim
# ============================================================

df$Has_Claim <- as.integer(df$N_claims_year > 0)


# ============================================================
# 4. CONVERTIR LAS VARIABLES DE FECHA
# ============================================================

df <- df %>%
  mutate(
    Date_birth = dmy(Date_birth),
    Date_driving_license = dmy(Date_driving_licence),
    Date_contract = dmy(Date_start_contract),
    Date_last_renewal = dmy(Date_last_renewal)
  )


# ============================================================
# 5. FECHA ACTUAL
# ============================================================

fecha_actual <- Sys.Date()


# ============================================================
# 6. CREAR VARIABLES DE EDAD Y ANTIGÜEDAD
# ============================================================

df <- df %>%
  mutate(
    
    # Edad del asegurado
    Age = floor(
      time_length(
        interval(Date_birth, fecha_actual),
        unit = "years"
      )
    ),
    
    # Años desde la obtención del permiso de conducir
    Years_driving = floor(
      time_length(
        interval(Date_driving_license, fecha_actual),
        unit = "years"
      )
    ),
    
    # Antigüedad del contrato
    Contract_seniority = floor(
      time_length(
        interval(Date_contract, fecha_actual),
        unit = "years"
      )
    ),
    
    # Años desde la última renovación
    Years_since_last_renewal = floor(
      time_length(
        interval(Date_last_renewal, fecha_actual),
        unit = "years"
      )
    ),
    
    # Meses desde la última renovación
    Months_since_last_renewal = floor(
      time_length(
        interval(Date_last_renewal, fecha_actual),
        unit = "months"
      )
    ),
    
    # Edad del vehículo
    Vehicle_age = year(fecha_actual) - Year_matriculation
  )


# ============================================================
# 7. CREAR LA BASE DE DATOS FINAL
# ============================================================

# Eliminamos las variables que no queremos utilizar.
# Las variables nuevas creadas en el punto 6 SE CONSERVAN.

eliminarcol <- c(
  "ID",
  "Cost_claims_year",
  "N_claims_year",
  "Date_lapse",
  "Lapse",
  "Date_birth",
  "Date_driving_license",
  "Date_contract",
  "Date_last_renewal"
)

df_final <- df[, !(names(df) %in% eliminarcol)]


# Comprobar la base de datos final
head(df_final)
str(df_final)
dim(df_final)
summary(df_final)
```

# ============================================================
# 11. MODELO LOGIT
# ============================================================

# Variable dependiente:
#     Has_Claim
#
# Variables explicativas:
#     todas las demás variables de df_final

modelo_logit <- glm(
  Has_Claim ~ Vehicle_age,
  data = df_final,
  family = binomial(link = "logit")
)


# ============================================================
# 12. RESULTADOS DEL MODELO
# ============================================================

summary(modelo_logit)


# ============================================================
# 13. ODDS RATIOS
# ============================================================

# Coeficientes
coef(modelo_logit)

# Odds ratios
exp(coef(modelo_logit))


# Intervalos de confianza de los Odds Ratios
exp(confint(modelo_logit))


# ============================================================
# 14. ODDS RATIOS + INTERVALOS DE CONFIANZA
# ============================================================

resultados_logit <- data.frame(
  Variable = names(coef(modelo_logit)),
  Coeficiente = coef(modelo_logit),
  Odds_Ratio = exp(coef(modelo_logit)),
  IC_inferior = exp(confint(modelo_logit)[, 1]),
  IC_superior = exp(confint(modelo_logit)[, 2]),
  p_valor = summary(modelo_logit)$coefficients[, 4]
)

resultados_logit


# ============================================================
# 15. AIC DEL MODELO
# ============================================================

AIC(modelo_logit)
```
