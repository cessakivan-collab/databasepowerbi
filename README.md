---

## 💻 Evidencia Técnica: Código M (Power Query)

### Script M — `dim_clientes`
```powerquery
let
    // 1. Carga de origen y selección de columnas del cliente
    Origen = ventas_raw,
    ColumnasSeleccionadas = Table.SelectColumns(Origen, {"id_cliente", "nombre_cliente", "correo", "telefono", "ciudad", "pais"}),
    
    // 2. Tipificación estricta
    TipoCambiado = Table.TransformColumnTypes(ColumnasSeleccionadas, {
        {"id_cliente", type text},
        {"nombre_cliente", type text},
        {"correo", type text},
        {"telefono", type text},
        {"ciudad", type text},
        {"pais", type text}
    }),
    
    // 3. Clave primaria única (eliminación de duplicados)
    DuplicadosQuitados = Table.Distinct(TipoCambiado, {"id_cliente"}),
    
    // 4. Imputación de nulos
    NulosReemplazados = Table.ReplaceValue(DuplicadosQuitados, null, "No Especificado", Replacer.ReplaceValue, {"ciudad", "pais", "telefono"})
in
    NulosReemplazados
```

### Script M — `fact_ventas`
```powerquery
let
    // 1. Carga de origen y remoción de atributos redundantes del cliente
    Origen = ventas_raw,
    ColumnasSeleccionadas = Table.SelectColumns(Origen, {"id_transaccion", "fecha_venta", "id_cliente", "id_producto", "cantidad", "monto_total"}),
    
    // 2. Tipificación
    TipoCambiado = Table.TransformColumnTypes(ColumnasSeleccionadas, {
        {"id_transaccion", type text},
        {"fecha_venta", type date},
        {"id_cliente", type text},
        {"id_producto", type text},
        {"cantidad", Int64.Type},
        {"monto_total", type number}
    }),
    
    // 3. Limpieza de transacciones duplicadas y métricas nulas
    DuplicadosQuitados = Table.Distinct(TipoCambiado, {"id_transaccion"}),
    FilasSinNulos = Table.SelectRows(DuplicadosQuitados, each [monto_total] <> null and [cantidad] <> null)
in
    FilasSinNulos
```

---

## 🖼️ Evidencia de Ejecución en Power BI Desktop

### 1. Pasos Aplicados en Power Query
![Pasos Aplicados](screenshots/01_power_query_pasos.png)

### 2. Modelo Relacional en Estrella (Star Schema)
![Modelo Relacional](screenshots/02_modelo_relacional.png)
