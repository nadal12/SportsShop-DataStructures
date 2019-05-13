package body destoc is

   -- Prepara la estructura vacía para almacenar los productos.
   procedure estoc_buit(c: out estoc) is

   end estoc_buid;

   -- Introduce un producto con una marca, un código, un nombre y un número
   -- de unidades.
   procedure posar_producte(c: in out estoc; m: in marca; k: in codi;
                            n: in nom; unitats: in integer) is
   end posar_producte;

   -- Borra el producto a través del código dado. Sólo se tiene que poder
   -- borrar si el número de unidades es 0.
   procedure esborrar_producte(c: in out estoc; k: in codi) is

   end esborrar_producte;

   -- Imprime todos los productos de una marca (código, nombre y unidades) sin
   -- la necesidad de seguir ningún orden.
   procedure imprimir_productes_marca(c: in estoc; m: in marca) is
   end imprimir_productes_marca;

   -- Imprime todos los productos de la tienda (código, nombre y unidades)
   -- ordenados ascendientemente por su código.
   procedure imprimir_estoc_total(c: in estoc) is

   end imprimir_estoc_total;

end destoc;
