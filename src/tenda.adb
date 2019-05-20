with Ada.Text_IO;
use Ada.Text_IO;
pragma Wide_Character_Encoding(UTF8);
with destoc;
use destoc;

procedure tenda is
   s: estoc;
   c: codi;
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
   imprimir:
   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop imprimir;

   --CARGAR STOCK CON 100 PRODUCTOS
   Put_Line("Cargar 100 productos nuevos; diez de cada marca..");
   Put_Line("posar_producte(estoc, marca, codigo, unidades);");
   Poner:
   for i in 0..99 loop
      c:=i+5;
      posar_producte(s, marca'Val(i mod 10), i, (i mod 10)*5 + 50, c);
   end loop Poner;
   New_Line;

   --IMPRIMIR STOCK CON ELEMENTOS
   Put_Line("Imprimir total stock.. ");
   Put_Line("imprimir_estoc_total(s);");
   imprimir_estoc_total(s);
   New_Line;

   Put_Line("Imprimir stock por marcas..");
   imprimir2:
   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop imprimir2;

   --BORRAR PRODUCTOS DEL STOCK
   Put_Line("Borrar productos por codigo..");
   borrar:
   for i in (15, 43, 65, 86, 98) loop
      Put_line("esborrar_producte(s, "&i'Image&")");
      esborrar_producte(s, i);
      --IMPRIMIR STOCK DESPUÉS DE BORRAR UN ELEMENTO
      Put_Line("Imprimir total stock despues de borrado de producto de codigo " & i'Image);
      Put_Line("imprimir_estoc_total(s);");
      imprimir_estoc_total(s);
      New_Line;

      Put_Line("Imprimir stock por marcas despues de borrado de producto de codigo "&i'Image&"..");
      imprimir3:
      for i in marca'Range loop
         Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
         imprimir_productes_marca(s, i);
         New_Line;
      end loop imprimir3;
   end loop borrar;
   New_Line;

   --INTRODUCIR PRODUCTO CON UN CODIGO YA EXISTENTE
   Put_Line("Introducir producto con codigo ya existente..");
   Put_Line("posar_producte(estoc, marca, 50, unidades)");
   posar_producte(s, marca'Val(3), 50, "p1" ,208);
   New_Line;

   --BORRAR PRODUCTO CON UN CODIGO INEXISTENTE
   Put_Line("Borrar un producto inexistente..");
   Put_Line("esborrar_producte(s, 15)");
   esborrar_producte(s, 15);
   Put_Line("esborrar_producte(s, 100)");
   esborrar_producte(s, 100);
   New_Line;

end tenda;
