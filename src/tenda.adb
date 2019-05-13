with Ada.Text_IO;
use Ada.Text_IO;
pragma Wide_Character_Encoding(UTF8);

procedure tenda is

   --Procedimientos
   procedure imprimir_menu is

   begin

      Put_Line("--------------------------------------------------------------");
      Put_Line("-          MENU PRINCIPAL DE LA GESTION DEL STOCK            -");
      Put_Line("--------------------------------------------------------------");
      New_line;
      Put_Line("1. Anadir productos.");
      Put_Line("2. Eliminar productos.");
      Put_line("3. Mostrar productos de una marca.");
      Put_line("4. Mostras todos los productos.");
      Put_Line("5. Salir.");
      New_line;

   end imprimir_menu;

   --Declaración de variables.
   escape: boolean := false;
   option: Integer;

begin

   while not escape loop

      imprimir_menu;
      Put("Seleccione un valor: ");
      option := Integer'Value(Get_Line);
      New_Line;

      case option is

         when 1 => null;
         when 2 => null;
         when 3 => null;
         when 4 => null;
         when 5 => escape:=true;
         when others => Put("Valor incorrecto.");
            New_Line;
      end case;


   end loop;



end tenda;
