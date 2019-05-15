generic

   type elem is private;


package dlistadoble is

   -- Operaciones
   procedure lvacia (l: out pnodo);
   procedure insertar(primero: in out pnodo; x: in elem);
   procedure borrar (primero: in out pnodo);
   procedure consultar(p : in pnodo, i: Integer);

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
