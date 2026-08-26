let
    Origen = #"gemini-code-1787767239539",
    #"Otras columnas quitadas" = Table.SelectColumns(Origen,{"id_cliente", "nombre_cliente", "telefono", "ciudad", "pais"}),
    #"Duplicados quitados" = Table.Distinct(#"Otras columnas quitadas", {"id_cliente"})
in
    #"Duplicados quitados"
