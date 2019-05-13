package body destoc is

   -- Prepara la estructura vac�a para almacenar los productos.
   procedure estoc_buit(c: out estoc) is

   end estoc_buid;

   -- Introduce un producto con una marca, un c�digo, un nombre y un n�mero
   -- de unidades.
   procedure posar_producte(c: in out estoc; m: in marca; k: in codi;
                            n: in nom; unitats: in integer) is
   end posar_producte;

   -- Borra el producto a trav�s del c�digo dado. S�lo se tiene que poder
   -- borrar si el n�mero de unidades es 0.
   procedure esborrar_producte(c: in out estoc; k: in codi) is

   end esborrar_producte;

   -- Imprime todos los productos de una marca (c�digo, nombre y unidades) sin
   -- la necesidad de seguir ning�n orden.
   procedure imprimir_productes_marca(c: in estoc; m: in marca) is
   end imprimir_productes_marca;

   -- Imprime todos los productos de la tienda (c�digo, nombre y unidades)
   -- ordenados ascendientemente por su c�digo.
   procedure imprimir_estoc_total(c: in estoc) is

   end imprimir_estoc_total;

end destoc;
