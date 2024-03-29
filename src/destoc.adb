------------------------PAQUETE DE IMPLEMENTACI�N DESTOC-----------------------

with Ada.Text_IO;
use Ada.Text_IO;

package body destoc is


   no_vacio: exception; --Excepcion para borrado

   package mi_enum is new Ada.Text_IO.Enumeration_IO(marca);
   use mi_enum;


   -----------------------------------------------------------------------------
   --
   --      FUNCIONES AUXILIARES Y DE BALANCEO DE ARBOL AVL
   --
   -----------------------------------------------------------------------------


   --Funcion de balanceo de un arbol cuando el factor de balanceo de un
   --nodo queda fuera de rango
   procedure rebalanceo_izq(p: in out pnodo; h: out boolean; m: in modo) is
      -- O p.lc ha crecido en altura un nivel (por inserci�n) o p.rc ha decrecido un nivel (por
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


   --Funcion que actualiza el factor de balanceo del nodo y dependiendo del caso
   --llama a rebalanceo_izq
   procedure balanceo_izq(p: in out pnodo; h: in out boolean; m: in modo) is
      -- O p.lc ha crecido en altura un nivel (por inserci�n)
      -- o p.rc ha decrecido un nivel (por borrado)
   begin
      if p.bl=1 then
         p.bl:= 0;
         if m=insert_mode then h:= false; end if ; -- else h se mantiene a
      elsif p.bl=0 then --creci� nivel por sub�rbol izq
         p.bl:= -1;
         if m=remove_mode then h:= false; end if ; -- else h se mantiene a
      else -- p.bl=-1
         rebalanceo_izq(p, h, m);
      end if ;
   end balanceo_izq;


   --Funcion de balanceo de un arbol cuando el factor de balanceo de un
   --nodo queda fuera de rango
   procedure rebalanceo_der(p: in out pnodo; h: out boolean; m: in modo) is
      -- O p.rc ha crecido en altura un nivel (por inserci�n)
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


   --Funcion que actualiza el factor de balanceo del nodo y dependiendo del caso
   --llama a rebalanceo_der
   procedure balanceo_der(p: in out pnodo; h: in out boolean; m: in modo) is
      -- O p.rc ha crecido en altura un nivel (por inserci�n)
      -- o p.lc ha decrecido un nivel (por borrado)
   begin
      if p.bl=-1 then
         p.bl:= 0;
         if m=insert_mode then h:= false; end if ; -- else h se mantiene a true
      elsif p.bl=0 then --creci� nivel por sub�rbol der
         p.bl:= 1;
         if m=remove_mode then h:= false; end if ; -- else h se mantiene a true
      else -- p.bl=1
         rebalanceo_der(p, h, m);
      end if ;
   end balanceo_der;


   --Procedimiento que consigue el nodo m�s a la izquierda, bajando por el hijo
   --derecho del pnodo
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


   --Procedimiento que desenlaza el pnodo a borrar de la estructura arbol
   procedure borrado_real(p: in out pnodo; h: out boolean; paux: out pnodo) is
      -- Prec.: p.k = k
      pmasbajo: pnodo;
   begin

      paux := p;
      if p.item.u /= 0 then raise no_vacio; end if;

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


   --Procedimiento que va bajando por una rama del arbol hasta conseguir el
   --pnodo a borrar
   procedure borrar(p: in out pnodo; k: in codi; h: out boolean; paux: out pnodo) is
   begin

      if p=null then Put_Line("Error: El producto no existe"); h:= false; return; end if;

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


   --Procedimiento que baja por una rama hasta encontrar a partir de qu� nodo
   --ha de colgar el nuevo nodo a agregar.
   procedure poner(p: in out pnodo; k: in codi; x: in producte; h: out boolean; aux: out pnodo) is
   begin
      if p=null then
         p:= new nodo; p.all:= (null, null, x, k, 0, null, null); -- 0 est� igualado
         aux := p;
         h:= true;
      else
         if k<p.k then
            poner(p.lc, k, x, h, aux); --sub�rbol izq
            if h then balanceo_izq (p, h, insert_mode); end if ;
         elsif k>p.k then
            poner(p.rc, k, x, h, aux); --sub�rbol der
            if h then balanceo_der(p, h, insert_mode); end if ;
         else -- k=p.k
            Put_Line("Error: Producto ya existente."); return;
         end if ;
      end if ;
   exception
      when storage_error => raise espacio_desbordado;
   end poner;


   --Funcion auxiliar que imprime la informacion contenida en un nodo.
   procedure print(p: in pnodo) is
   begin
      Put_Line("Nombre: " & To_String(p.item.n) & "| Marca: " & p.item.m'Image & " | Codigo: " & p.k'Image & " | Unidades: " & p.item.u'Image);
   end print;


   -----------------------------------------------------------------------------
   --
   --      FUNCIONES DE TIPO DE DATOS ESTOC
   --
   -----------------------------------------------------------------------------


   -- Prepara la estructura vac�a para almacenar los productos.
   procedure estoc_buit(c: out estoc) is

      ms: marcas renames c.ms;

   begin
      c.raiz := null;

      for i in c.ms'Range loop
         ms(i) := null;
      end loop;

   end estoc_buit;


   -- Introduce un producto con una marca, un c�digo, un nombre y un n�mero
   -- de unidades.
   procedure posar_producte(c: in out estoc; m: in marca; k: in codi;
                            n: in nom; unitats: in integer) is

      raiz: pnodo renames c.raiz;
      ms: marcas renames c.ms;
      h: boolean;
      p: producte;
      paux: pnodo;

   begin


      --Se asignan los datos al nuevo producto.
      p := (n, m, unitats);

      --Se pone el producto en la estructura de arbol
      poner(raiz, k, p, h, paux);

      --Se enlaza el nuevo producto creado a la lista correspondiente a su marca
      if paux /= null then
         paux.sig := ms(m);
         ms(m) := paux;

         if paux.sig /= null then
            paux.sig.ant := paux;
         end if;

      end if;

   end posar_producte;


   -- Borra el producto a trav�s del c�digo dado. S�lo se tiene que poder
   -- borrar si el n�mero de unidades es 0.
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

   exception
         when no_vacio => Put_line("Error: no se puede borrar un producto que del haya existencias.");

   end esborrar_producte;


   -- Imprime todos los productos de una marca (c�digo, nombre y unidades) sin
   -- la necesidad de seguir ning�n orden.
   procedure imprimir_productes_marca(c: in estoc; m: in marca) is

      ms: marcas renames c.ms;
      p: pnodo;

   begin
      --Check si la lista para dicha marca existe
      if ms(m) = null then Put_Line("Error: El stock de esta marca esta vacio"); return; end if;

      p := ms(m);

      while p/= null loop
         print(p);
         p := p.sig;
      end loop;

   end imprimir_productes_marca;


   -- Imprime todos los productos de la tienda (c�digo, nombre y unidades)
   -- ordenados ascendientemente por su c�digo.
   procedure imprimir_estoc_total(c: in estoc) is

      raiz: pnodo renames c.raiz;
      r: pnodo := raiz;

      --Procedimiento para realizar el recorrido inorden del arbol de manera
      --recursiva
      procedure imprimir_estoc_total(r: in out pnodo) is
      begin

         --Aplicar recorrido inorden sobre el arbol del estoc.
         if r.lc/=null then
            imprimir_estoc_total(r.lc);
         end if;

         --Operaci�n de procesamiento de nodo (o visita).
         print(r);

         if r.rc/=null then
            imprimir_estoc_total(r.rc);
         end if;

      end imprimir_estoc_total;

   begin

      if r = null then Put_Line("Error: Stock vacio."); return; end if;

      imprimir_estoc_total(r);

   end imprimir_estoc_total;


end destoc;
