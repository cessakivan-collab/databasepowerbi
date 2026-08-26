let
    Origen = #"gemini-code-1787767239539",
    #"Otras columnas quitadas" = Table.SelectColumns(Origen,{"id_transaccion", "fecha_venta", "id_cliente", "id_producto", "cantidad", "monto_total"})
in
    #"Otras columnas quitadas"
