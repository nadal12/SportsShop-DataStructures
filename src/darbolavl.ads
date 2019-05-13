generic
   type key is private;
   type item is private;
   with function "<"(k1, k2: in key) return boolean;
   with function ">"(k1, k2: in key) return boolean;
package darbolavl is

   type arbolavl is limited private;

   --Excepciones


   --Operaciones
   procedure cvacio (s: out conjunto);
   procedure consultar(s: in conjunto; k: in key; x: out item);
   procedure consultar(s: in pnodo; k: in key; x: out item);
   procedure poner(s: in out conjunto; k: in key; x: in item);
   procedure poner(p: in out pnodo; k: in key; x: in item; h: out boolean);
   procedure balanceo_izq(p: in out pnodo; h: in out boolean; m: in modo);
   procedure rebalanceo_izq(p: in out pnodo; h: out boolean; m: in modo);
   procedure borrar(p: in out pnodo; k: in key; h: out boolean);
   procedure borrado_real(p: in out pnodo; h: out boolean);
   procedure borrado_masbajo(p: in out pnodo; pmasbajo: out pnodo; h: out boolean);

private

   type nodo;

   type pnodo is access nodo;

   type factor_balanceo is new integer range -1..1;

   type nodo is record
      k: key;
      x: item;
      bl: factor_balanceo;
      lc, rc: pnodo;
   end record;

   type arbolavl is record
      raiz: pnodo;
   end record;

end darbolavl;
