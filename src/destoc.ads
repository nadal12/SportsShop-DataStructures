with ada.Strings.Unbounded;
use ada.Strings.Unbounded;

package destoc is

   type estoc is limited private;
   type marca is (Nike, Adidas, Reebok, Asics, Fila, Puma, Quiksilver, Kappa, Joma, Converse);

   type codi is new Natural range 0..5000000;

   type nom is new Unbounded_String;

   --Excepciones
   ya_existe: exception;
   no_existe: exception;
   mal_uso: exception;
   espacio_desbordado: exception;

   --Procedimientos
   procedure estoc_buit(c: out estoc);
   procedure posar_producte(c: in out estoc; m: in marca; k: in codi;
                            n: in nom; unitats: in integer);
   procedure esborrar_producte(c: in out estoc; k: in codi);
   procedure imprimir_productes_marca(c: in estoc; m: in marca);
   procedure imprimir_estoc_total(c: in estoc);


private

   type modo is (insert_mode, remove_mode);

   type producte;
   type pproducte is access producte;

   -- Definición de un producto.
   type producte is record
      n: nom;
      m: marca;
      c: codi;
      u: integer;
   end record;

   type nodo;
   type pnodo is access nodo;
   type factor_balanceo is new integer range -1..1;

   type nodo is record
      ant: pnodo;
      sig: pnodo;
      item: pproducte;
      k: codi;
      bl: factor_balanceo;
      lc, rc: pnodo;
   end record;

   type marcas is array(marca'Range) of pnodo;

   type estoc is record
      ms: marcas;
      raiz: pnodo;
   end record;

   --Funciones auxiliares
   procedure print(p: in producte);
   procedure imprimir_estoc_total(r: in out pnodo);

   --Procedimientos arbol.
   procedure poner(p: in out pnodo; k: in codi; x: in pproducte; h: out boolean; sig: in pnodo; aux: out pnodo);
   procedure balanceo_izq(p: in out pnodo; h: in out boolean; m: in modo);
   procedure rebalanceo_izq(p: in out pnodo; h: out boolean; m: in modo);
   procedure balanceo_der(p: in out pnodo; h: in out boolean; m: in modo);
   procedure rebalanceo_der(p: in out pnodo; h: out boolean; m: in modo);
   procedure borrar(p: in out pnodo; k: in codi; h: out boolean; paux: out pnodo);
   procedure borrado_real(p: in out pnodo; h: out boolean; paux: out pnodo);
   procedure borrado_masbajo(p: in out pnodo; pmasbajo: out pnodo; h: out boolean);

end destoc;
