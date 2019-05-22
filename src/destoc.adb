with Ada.Text_IO;
use Ada.Text_IO;

package body destoc is

   package mi_enum is new Ada.Text_IO.Enumeration_IO(marca);
   use mi_enum;

   -- Prepara la estructura vacía para almacenar los productos.
   procedure estoc_buit(c: out estoc) is

      ms: marcas renames c.ms;

   begin
      c.raiz := null;

      for i in c.ms'Range loop
         ms(i) := null;
      end loop;

   end estoc_buit;

   -- Introduce un producto con una marca, un código, un nombre y un número
   -- de unidades.
   procedure posar_producte(c: in out estoc; m: in marca; k: in codi;
                            n: in nom; unitats: in integer) is

      raiz: pnodo renames c.raiz;
      ms: marcas renames c.ms;
      h: boolean;
      p: pproducte;
      paux: pnodo;

   begin

      p:= new producte;

      --Se asignan los datos al nuevo producto.
      p.all := (n, m, k, unitats);

      --Se pone el producto en la estructura.
      poner(raiz, k, p, h, ms(m), paux);

      if paux /= null then
         ms(m) := paux;

         if paux.sig /= null then
            paux.sig.ant := paux;
         end if;

      end if;


   end posar_producte;

   -- Borra el producto a través del código dado. Sólo se tiene que poder
   -- borrar si el número de unidades es 0.
   procedure esborrar_producte(c: in out estoc; k: in codi) is
      h: boolean;
      raiz: pnodo renames c.raiz;
      ms: marcas renames c.ms;
      paux: pnodo;
   begin
      borrar(raiz, k, h, paux);

      if paux/=null then
         --Enlazar pnodo anterior con siguiente si toca
         if paux.ant /= null then
            paux.ant.sig := paux.sig;
         else
            --paux.sig.ant := null;
            ms(paux.item.m) := paux.sig;
         end if;

         if paux.sig /= null then
            paux.sig.ant := paux.ant;
         end if;
      end if;

   end esborrar_producte;

   -- Imprime todos los productos de una marca (código, nombre y unidades) sin
   -- la necesidad de seguir ningún orden.
   procedure imprimir_productes_marca(c: in estoc; m: in marca) is
      ms: marcas renames c.ms;
      p: pnodo;
      i: pproducte;
   begin
      --Check si la lista para dicha marca existe
      if ms(m) = null then Put_Line("Estoc de aquesta marca buit"); return; end if;

      p := ms(m);

      while p/= null loop
         i := p.item;
         print(i.all);
         p := p.sig;
      end loop;

   end imprimir_productes_marca;

   -- Imprime todos los productos de la tienda (código, nombre y unidades)
   -- ordenados ascendientemente por su código.
   procedure imprimir_estoc_total(c: in estoc) is

      raiz: pnodo renames c.raiz;
      r: pnodo := raiz;

   begin

      if r = null then Put_Line("Estoc buit"); return; end if;

      imprimir_estoc_total(r);

   end imprimir_estoc_total;

   procedure imprimir_estoc_total(r: in out pnodo) is


   begin

      --Aplicar recorrido inorden sobre el arbol del estoc.
      if r.lc/=null then
         imprimir_estoc_total(r.lc);
      end if;

      --Operación de procesamiento de nodo (o visita).
      print(r.item.all);

      if r.rc/=null then
         imprimir_estoc_total(r.rc);
      end if;

   end imprimir_estoc_total;


   procedure poner(p: in out pnodo; k: in codi; x: in pproducte; h: out boolean; sig: in pnodo; aux: out pnodo) is
   begin
      if p=null then
         p:= new nodo; p.all:= (null, sig, x, k, 0, null, null); -- 0 está igualado
         aux := p;
         h:= true;
      else
         if k<p.k then
            poner(p.lc, k, x, h, sig, aux); --subárbol izq
            if h then balanceo_izq (p, h, insert_mode); end if ;
         elsif k>p.k then
            poner(p.rc, k, x, h, sig, aux); --subárbol der
            if h then balanceo_der(p, h, insert_mode); end if ;
         else -- k=p.k
            Put_Line("Producto ya existente"); return;
         end if ;
      end if ;
   exception
      when storage_error => raise espacio_desbordado;
   end poner;

   procedure balanceo_izq(p: in out pnodo; h: in out boolean; m: in modo) is
      -- O p.lc ha crecido en altura un nivel (por inserción)
      -- o p.rc ha decrecido un nivel (por borrado)
   begin
      if p.bl=1 then
         p.bl:= 0;
         if m=insert_mode then h:= false; end if ; -- else h se mantiene a
      elsif p.bl=0 then --creció nivel por subárbol izq
         p.bl:= -1;
         if m=remove_mode then h:= false; end if ; -- else h se mantiene a
      else -- p.bl=-1
         rebalanceo_izq(p, h, m);
      end if ;
   end balanceo_izq;

   procedure rebalanceo_izq(p: in out pnodo; h: out boolean; m: in modo) is
      -- O p.lc ha crecido en altura un nivel (por inserción) o p.rc ha decrecido un nivel (por
      --borrado)
        a: pnodo; -- el nodo inicialmente en la raiz
      b: pnodo; -- hijo izq de a
      c, b2: pnodo; -- hijo der de b
      c1, c2: pnodo; -- hijos izq y der de c
   begin
      a:= p; b:= a.lc;
      if b.bl<=0 then -- promociona b
         b2:= b.rc; -- asigna nombre
         a.lc:= b2; b.rc:=a; p:= b; -- reestructura
         if b.bl=0 then -- actualiza bl y h
            a.bl:= -1; b.bl:= 1;
            if m=remove_mode then h:= false; end if ; -- else h se mantiene a true
         else -- b.bl= -1
            a.bl:= 0; b.bl:= 0;
            if m=insert_mode then h:= false; end if ; -- else h se mantiene a true
         end if ;
      else
         c:= b.rc; c1:= c.lc; c2:= c.rc; -- asigna nombres
         b.rc:= c1; a.lc:= c2; c.lc:= b; c.rc:= a; p:= c; -- reestructura
         if c.bl<=0 then b.bl:= 0; else b.bl:=-1; end if ; -- actualiza bl y h
         if c.bl>=0 then a.bl:= 0; else a.bl:= 1; end if ;
         c.bl:= 0;
         if m=insert_mode then h:= false; end if ; -- else h se mantiene a true
      end if ;
   end rebalanceo_izq;


   procedure balanceo_der(p: in out pnodo; h: in out boolean; m: in modo) is
      -- O p.rc ha crecido en altura un nivel (por inserción)
      -- o p.lc ha decrecido un nivel (por borrado)
   begin
      if p.bl=-1 then
         p.bl:= 0;
         if m=insert_mode then h:= false; end if ; -- else h se mantiene a true
      elsif p.bl=0 then --creció nivel por subárbol der
         p.bl:= 1;
         if m=remove_mode then h:= false; end if ; -- else h se mantiene a true
      else -- p.bl=1
         rebalanceo_der(p, h, m);
      end if ;
   end balanceo_der;

   procedure rebalanceo_der(p: in out pnodo; h: out boolean; m: in modo) is
      -- O p.rc ha crecido en altura un nivel (por inserción)
      -- o p.lc ha decrecido un nivel (por borrado)
      a: pnodo; -- el nodo inicialmente en la raiz
      b: pnodo; -- hijo izq de a
      c, b2: pnodo; -- hijo der de b
      c1, c2: pnodo; -- hijos izq y der de c
   begin
      a:= p; b:= a.rc;
      if b.bl>=0 then -- promociona b
         b2:= b.lc; -- asigna nombre
         a.rc:= b2; b.lc:=a; p:= b; -- reestructura
         if b.bl=0 then -- actualiza bl y h
            a.bl:= 1; b.bl:= -1;
            if m=remove_mode then h:= false; end if ; -- else h se mantiene a true
         else -- b.bl= 1
            a.bl:= 0; b.bl:= 0;
            if m=insert_mode then h:= false; end if ; -- else h se mantiene a true
         end if ;
      else
         c:= b.rc; c1:= c.lc; c2:= c.rc; -- asigna nombres
         b.rc:= c1; a.lc:= c2; c.lc:= b; c.rc:= a; p:= c; -- reestructura
         if c.bl<=0 then b.bl:= 0; else b.bl:=-1; end if ; -- actualiza bl y h
         if c.bl>=0 then a.bl:= 0; else a.bl:=1; end if ;
         c.bl:= 0;
         if m=insert_mode then h:= false; end if; -- else h se mantiene a true
      end if;
   end rebalanceo_der;


   procedure borrar(p: in out pnodo; k: in codi; h: out boolean; paux: out pnodo) is
   begin

      if p=null then Put_Line("No existe"); h:= false; return; end if ;
      if k<p.k then
         borrar(p.lc, k, h, paux);
         if h then balanceo_der(p, h, remove_mode); end if ;
      elsif k>p.k then
         borrar(p.rc, k, h, paux);
         if h then balanceo_izq(p, h, remove_mode); end if ;
      else -- k=p.k
         borrado_real(p, h, paux);
      end if ;
   end borrar;

   procedure borrado_real(p: in out pnodo; h: out boolean; paux: out pnodo) is
      -- Prec.: p.k = k
      pmasbajo: pnodo;
   begin

      paux := p;

      --Borrado segun cantidad de hijos que tenga el pnodo
      if p.lc= null and p.rc= null then
         p:= null; h:= true;
      elsif p.lc =null and p.rc/=null then
         p:= p.rc; h:= true;
      elsif p.lc/=null and p.rc =null then
         p:= p.lc; h:= true;
      else -- s.lc/=null and s.rc/=null
         borrado_masbajo(p.rc, pmasbajo, h);
         pmasbajo.lc:= p.lc; pmasbajo.rc:= p.rc; pmasbajo.bl:= p.bl;
         p:= pmasbajo;
         if h then balanceo_izq(p, h, remove_mode); end if ;
      end if ;
   end borrado_real;

   procedure borrado_masbajo(p: in out pnodo; pmasbajo: out pnodo; h: out boolean) is
      -- Prec.: p/=null
   begin
      if p.lc/=null then
         borrado_masbajo(p.lc, pmasbajo, h);
         if h then balanceo_der(p, h, remove_mode); end if ;
      else
         pmasbajo:= p; p:= p.rc; h:= true;
      end if ;
   end borrado_masbajo;

   procedure print(p: in producte) is
      s: string(1..33);
   begin
      mi_enum.put(s, p.m);
      Put_Line("Nombre: " & s & "|Marca: " & natural(p.c)'Image & " |Codigo: " & p.c'Image & " | Unidades: " & p.u'Image);
   end print;

end destoc;
