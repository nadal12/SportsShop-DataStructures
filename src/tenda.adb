with Ada.Text_IO;
use Ada.Text_IO;
with ada.strings.unbounded;
use ada.strings.Unbounded;
pragma Wide_Character_Encoding(UTF8);
with destoc;
use destoc;

procedure tenda is

   s: estoc;
   j: Natural;
   N: natural := 50;
   Nc: natural;
   type array_range is new natural range 1..5;
   type codi_array is array(array_range) of codi;
   codis: codi_array := (8,21,33,39,98);

begin

   --INICIALIZACIÓN DE STOCK
   Put_Line("Inicializacion de un stock..");
   Put_Line("estoc_buit(s);");
   estoc_buit(s);
   New_Line;

   --IMPRIMIR STOCK VACIO
   Put_Line("Imprimir contenido del stock vacio..");
   Put_Line("Imprimir total stock.. ");
   Put_Line("imprimir_estoc_total(s);");
   imprimir_estoc_total(s);
   New_Line;

   Put_Line("Imprimir stock por marcas..");

   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop;

   --CARGAR STOCK CON N PRODUCTOS
   Nc := N/10;
   Put_Line("Cargar "&N'Image&" productos nuevos; "&Nc'Image &" de cada marca..");
   Put_Line("posar_producte(estoc, marca, codigo, unidades);");

   for i in 0..N loop
      posar_producte(s, marca'Val(i mod 10), codi(i), To_Unbounded_String("Prod"&i'Image), i+5);
   end loop;
   New_Line;

   --IMPRIMIR STOCK CON ELEMENTOS
   Put_Line("Imprimir total stock.. ");
   Put_Line("imprimir_estoc_total(s);");
   imprimir_estoc_total(s);
   New_Line;

   Put_Line("Imprimir stock por marcas..");
   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop;

   --BORRAR PRODUCTOS DEL STOCK
   Put_Line("Borrar productos por codigo..");
   borrar:
   for i in codis'Range loop
      Put_line("esborrar_producte(s, "&codis(i)'Image&")");
      esborrar_producte(s, codis(i));
   end loop borrar;
   New_Line;

   --IMPRIMIR STOCK DESPUÉS DE BORRAR UN ELEMENTO
      Put_Line("Imprimir total stock despues de borrados..");
      Put_Line("imprimir_estoc_total(s);");
      imprimir_estoc_total(s);
      New_Line;

      Put_Line("Imprimir stock por marcas despues de borrados..");
      for j in marca'Range loop
         Put_Line("imprimir_productes_marcas(s, "& j'Image &");");
         imprimir_productes_marca(s, j);
         New_Line;
      end loop;

   --INTRODUCIR PRODUCTO CON UN CODIGO YA EXISTENTE
   Put_Line("Introducir producto con codigo ya existente..");
   Put_Line("posar_producte(estoc, marca, 50, unidades)");
   posar_producte(s, marca'Val(3), 50, To_Unbounded_String("p1"),208);
   New_Line;

   --BORRAR PRODUCTO CON UN CODIGO INEXISTENTE
   Put_Line("Borrar un producto inexistente..");
   Put_Line("esborrar_producte(s, 15)");
   esborrar_producte(s, 8);
   Put_Line("esborrar_producte(s, 100)");
   esborrar_producte(s, 100);
   New_Line;

   --BORRAR TODOS LOS PRODUCTOS DE UNA MARCA
   Put_Line("Borrar todos los productos de una marca..");
   j := 3;
   while j <= N loop
      Put_Line("esborrar_producte(s, "&j'Image&");");
      esborrar_producte(s, codi(j));
      j := j + 10;

   end loop;

         Put_Line("Imprimir stock por marcas despues de borrados..");

      for j in marca'Range loop
         Put_Line("imprimir_productes_marcas(s, "& j'Image &");");
         imprimir_productes_marca(s, j);
         New_Line;
      end loop;

   --VACIAR STOCK DESPUES DE PRUEBAS
   Put_Line("Borrar stock despues de realizar pruebas..");
   Put_Line("Inicializacion de un stock..");
   Put_Line("estoc_buit(s);");
   estoc_buit(s);
   New_Line;

   --IMPRIMIR STOCK VACIO
   Put_Line("Imprimir contenido del stock vacio..");
   Put_Line("Imprimir total stock.. ");
   Put_Line("imprimir_estoc_total(s);");
   imprimir_estoc_total(s);
   New_Line;

   Put_Line("Imprimir stock por marcas..");

   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop;
end tenda;
