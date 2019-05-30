--------------------------------------------------------------------------------
-- T�TULO: Pr�ctica 3: La tienda de material deportivo.
-- ASIGNATURA: Estructuras de Datos - UIB
-- DESARROLLADORES: Eugenio Do�aque y Nadal Llabr�s.
-- FECHA: 07/06/2019
--------------------------------------------------------------------------------
-- DESCRIPCI�N: Se tiene que dise�ar un conjunto de estructuras de datos y con
-- ellas implemetar un programa que sirva para la simulaci�n del funcionamiento
-- del stock de una tienda. Se debe permitir insertar productos, borrar
-- productos, listar todo el stock ordenado por c�digo i listar el stock
-- clasificado por marcas.
--------------------------------------------------------------------------------
-- NOTAS: El programa tiene por defecto una generaci�n autom�tica de 50
-- productos. Si este valor se modifica hacia un valor muy peque�o, puede que
-- ser complicado verificar el correcto funcionamiento de la tienda.
--------------------------------------------------------------------------------

with Ada.Text_IO;
use Ada.Text_IO;
with ada.strings.unbounded;
use ada.strings.Unbounded;
pragma Wide_Character_Encoding(UTF8);
with destoc;
use destoc;

procedure tenda is

   --Variables de apoyo.
   s: estoc;
   N: natural := 50; --Cantidad de productos que se generar�n.
   Nc: natural;
   type array_range is new natural range 1..5;
   type codi_array is array(array_range) of codi;
   codis: codi_array := (8,21,33,39,98);

begin

   --INICIALIZACI�N DE STOCK.
   Put_Line("****************************************************************");
   Put_Line("Inicializacion de un stock..");
   Put_Line("estoc_buit(s);");
   estoc_buit(s);
   Put_Line("OK!");

   Put_Line("****************************************************************");

   --IMPRIMIR STOCK COMPLETO VACIO.
   Put_Line("Imprimir contenido del stock vacio");
   Put_Line("Imprimir stock total.. ");
   Put_Line("imprimir_estoc_total(s);");
   imprimir_estoc_total(s);
   Put_Line("****************************************************************");

   --IMPRIMIR STOCK VAC�O POR MARCAS.
   Put_Line("Imprimir stock por marcas..");

   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop;
   Put_Line("****************************************************************");

   --CARGAR STOCK CON N PRODUCTOS
   Nc := N/10;
   Put_Line("Cargar"&N'Image&" productos nuevos. "&Nc'Image &" de cada marca..");
   Put_Line("posar_producte(s, marca, codigo, unidades);");

   for i in 1..N loop
      posar_producte(s, marca'Val(i mod 10), codi(i), To_Unbounded_String("Producto"&i'Image), i+6);
   end loop;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   --IMPRIMIR STOCK CON ELEMENTOS
   Put_Line("Imprimir total stock.. ");
   Put_Line("imprimir_estoc_total(s);");
   New_Line;
   imprimir_estoc_total(s);
   New_Line;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   Put_Line("Imprimir stock por marcas..");
   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      New_Line;
      imprimir_productes_marca(s, i);
      New_Line;
   end loop;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   --BORRAR PRODUCTOS DEL STOCK
   Put_Line("Borrar productos por codigo..");

   for i in codis'Range loop
      Put_line("esborrar_producte(s, "&codis(i)'Image&")");
      esborrar_producte(s, codis(i));
   end loop;
   New_Line;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   --IMPRIMIR STOCK DESPU�S DE BORRAR PRODUCTOS.
      Put_Line("Imprimir total stock despues de borrados..");
   Put_Line("imprimir_estoc_total(s);");
   New_Line;
      imprimir_estoc_total(s);
      New_Line;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   --INTRODUCIR PRODUCTO CON UN CODIGO YA EXISTENTE
   Put_Line("Introducir producto con codigo ya existente..");
   Put_Line("posar_producte(estoc, marca, 50, nombre, unidades)");
   posar_producte(s, marca'Val(3), 50, To_Unbounded_String("p1"),208);
   New_Line;
   Put_Line("****************************************************************");

   --BORRAR PRODUCTO CON UN CODIGO INEXISTENTE
   Put_Line("Borrar un producto inexistente..");
   Put_Line("esborrar_producte(s, 100)");
   esborrar_producte(s, 100);
   New_Line;
   Put_Line("****************************************************************");

   --INTRODUCIR PRODUCTO CON 0 UNIDADES PARA BORRADO POSTERIOR
   put_line("Introducir producto con 0 unidades para borrar..");
   put_line("posar_producte(s, Nike, 102, Producto 102, 0);");
   posar_producte(s, marca(Nike), 102, To_Unbounded_String("Producto 102"), 0);
   new_line;
   put_line("Visualizar productos de la misma marca para verificar..");
   put_line("imprimir_productes_marca(s, Nike);");
   imprimir_productes_marca(s, marca(Nike));
   New_Line;
   put_line("borrar producto sin unidades..");
   put_line("esborrar_producte(s, 102);");
   esborrar_producte(s, 102);
   new_line;
   put_line("imprimir_productes_marca(s, Nike);");
   imprimir_productes_marca(s, marca(Nike));
   New_Line;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   --VACIAR STOCK DESPUES DE PRUEBAS
   Put_Line("Borrar stock despues de realizar pruebas..");
   Put_Line("Inicializacion de un stock..");
   Put_Line("estoc_buit(s);");
   estoc_buit(s);
   New_Line;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   --IMPRIMIR STOCK VACIO
   Put_Line("Imprimir contenido del stock vacio..");
   Put_Line("Imprimir total stock.. ");
   Put_Line("imprimir_estoc_total(s);");
   imprimir_estoc_total(s);
   New_Line;
   Put_Line("OK!");
   Put_Line("****************************************************************");

   Put_Line("Imprimir stock por marcas..");
   for i in marca'Range loop
      Put_Line("imprimir_productes_marcas(s, "& i'Image &");");
      imprimir_productes_marca(s, i);
      New_Line;
   end loop;
   Put_Line("OK!");
   Put_Line("****************************************************************");
end tenda;
