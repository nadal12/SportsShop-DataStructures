generic
   type elem is private;

package dlistadoble is

   -- Operaciones



private

   type nodo;
   type pnodo is access nodo;

   type nodo is record
      x: elem;
      sig: pnodo;
      prev: pnodos
   end record;
   type lista_doble is record
      primero: pnodo;
   end record;

end dlistadoble;
