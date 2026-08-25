#  Práctica: Lenguaje M y Editor Avanzado en Power Query

> **Repositorio de Práctica:** Extracción, manipulación manual en Lenguaje M y documentación analítica.  
> **Herramienta:** Power BI Desktop / Editor Avanzado de Power Query  
> **Dataset Utilizado:** *Superstore Sales and Inventory Dataset* (o dataset equivalente de comercio minorista).  
> **Fuente / URL:** [Kaggle - Superstore Sales Dataset](https://www.kaggle.com/datasets) *(Reemplazar con el link exacto del dataset que descargues)*

---

##  1. Selección y Justificación del Dataset

* **Origen:** Repositorio público abierto en formato CSV.
* **Cumplimiento de requisitos técnicos:**
  * Cuenta con más de 10 columnas con tipos de datos variados: identificadores textuales (`Order_ID`, `Customer_ID`), fechas (`Order_Date`, `Ship_Date`), valores categóricos (`Region`, `Category`) y métricas numéricas (`Sales`, `Quantity`, `Profit`).
  * Presenta filas con valores nulos en dimensiones de envío y columnas con nomenclatura técnica en mayúsculas/guiones bajos.
* **Justificación analítica:** Simula fielmente un caso real de extracción desde un ERP/CRM desordenado, requiriendo tipificación manual, filtros de depuración y normalización de nombres para habilitar el análisis de ventas.

---

##  2. Código M Final (Editor Avanzado)

A continuación se presenta el script M completo obtenido desde el **Editor Avanzado**, incluyendo el paso modificado manualmente (`#"MiTransformacionManual"`), la actualización de su referencia en el paso subsiguiente y los comentarios explicativos:

```powerquery
let
    // 1. Carga del archivo fuente CSV con delimitador por coma y codificación UTF-8
    Origen = Csv.Document(File.Contents("C:\Data\raw_sales_dataset.csv"), [Delimiter=",", Columns=8, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    
    // 2. Promoción de la primera fila como encabezados de columna
    #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars=true]),

### 2. Modelo Relacional en Estrella (Star Schema)
![Modelo Relacional](screenshots/02_modelo_relacional.png)
