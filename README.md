# 1. **Extracción y Promoción de Encabezados:** Se cargó el archivo en Power BI Desktop y se utilizó la primera fila como encabezado de columnas.
2. **Estandarización de Nombres:** Se reemplazaron los códigos técnicos del sistema por nombres claros en español usando formato `snake_case` (por ejemplo: de `COD_CLI_001` a `id_cliente`, de `FEC_VTA` a `fecha_venta`).
3. **Corrección de Tipos de Datos:** Se asignó el tipo de dato correspondiente a cada columna antes de realizar cualquier cálculo o separación.
4. **Depuración de Duplicados:** Se eliminaron las transacciones repetidas generadas por errores en la exportación original.
5. **Tratamiento de Valores Nulos:** Se filtraron registros transaccionales sin importe y se imputaron valores por defecto en datos cualitativos.
6. **Normalización (Bifurcación en 2 Tablas):** Se crearon dos tablas independientes (`dim_clientes` y `fact_ventas`) mediante referencias en Power Query para adoptar un modelo en estrella.

---

##  3. Justificación Técnica de Tipos de Datos

| Columna | Tipo Asignado | ¿Por qué se eligió este tipo? (Justificación) |
| :--- | :--- | :--- |
| `id_cliente`<br>`id_transaccion`<br>`id_producto` | **Texto (Text)** | Son identificadores y claves de relación, no representan cantidades operables. Tipificarlos como texto evita que Power BI intente sumarlos o promediarlos por error y conserva ceros a la izquierda. |
| `fecha_venta` | **Fecha (Date)** | Permite que Power BI cree jerarquías temporales automáticas (Año, Mes, Trimestre), conecte con tablas calendario y habilite fórmulas DAX de Inteligencia de Tiempo (`SAMEPERIODLASTYEAR`, `YTD`). |
| `monto_total`<br>`precio_unitario` | **Número Decimal Fijo / Decimal** | Garantiza precisión en cálculos monetarios y evita errores de redondeo en sumatorias financieras y métricas de margen. |
| `cantidad` | **Número Entero (Whole Number)** | Representa unidades discretas e indivisibles de producto vendido. |
| `nombre_cliente`<br>`ciudad`<br>`pais` | **Texto (Text)** | Atributos cualitativos usados para agrupar, filtrar y crear segmentadores demográficos. |

---

##  4. Tratamiento de Valores Nulos y Duplicados

### A. Filas Duplicadas
* **Criterio aplicado:** Se aplicó la acción **"Quitar duplicados"** evaluando el identificador único de la transacción (`id_transaccion`).
* **Justificación de negocio:** Mantener ventas duplicadas inflaría artificialmente la facturación total y la cantidad real de pedidos de la empresa.

### B. Valores Nulos (`null`)
Se aplicaron dos tratamientos según la naturaleza de la columna:
1. **Métricas cuantitativas (`monto_total`, `cantidad`):** Se eliminaron las filas con valores nulos que no pudieron ser imputadas, ya que una venta sin importe ni cantidad distorsiona promedios (`AVERAGE`) y totales (`SUM`).
2. **Columnas descriptivas (`ciudad`, `telefono`):** Se utilizó la opción *Reemplazar los valores* para convertir los nulos en `"No Especificado"`. Esto permite que los filtros y segmentadores visuales sigan funcionando sin mostrar opciones en blanco.

---

##  5. Criterio de Normalización: Separación de Tablas

Para evitar la redundancia y optimizar el rendimiento de Power BI (motor VertiPaq), el dataset plano original se dividió en dos entidades bajo el estándar de **Esquema en Estrella**:
