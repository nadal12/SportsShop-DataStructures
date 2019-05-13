package body darbolavl is

   procedure cvacio (s: out conjunto) is
      raiz: pnodo renames s.raiz;
   begin
      raiz:= null;
   end cvacio;

   procedure consultar(s: in conjunto; k: in key; x: out item) is
      raiz: pnodo renames s.raiz;
   begin
      consultar(raiz, k, x);
   end consultar;

   procedure consultar(s: in pnodo; k: in key; x: out item) is
   begin
      if s=null then
         raise no_existe;
      else
         if k<s.k then consultar(s.lc, k, x);
         elsif k>s.k then consultar(s.rc, k, x);
         else x:= s.x;
         end if ;
      end if ;
   end consultar;

   procedure poner(s: in out conjunto; k: in key; x: in item) is
      raiz: pnode renames s.raiz;
      h: boolean; -- h dice si ha crecido el nivel por una inserción
   begin
      poner(raiz, k, x, h);
   end poner;

   procedure poner(p: in out pnodo; k: in key; x: in item; h: out boolean) is
   begin
      if p=null then
         p:= new nodo; p.all:= (k, x, 0, null, null); -- 0 está igualado
         h:= true;
      else
         if k<p.k then
            poner(p.lc, k, x, h); --subárbol izq
            if h then balanceo_izq (p, h, insert_mode); end if ;
         elsif k>p.k then
            poner(p.rc, k, x, h); --subárbol der
            if h then balanceo_der(p, h, insert_mode); end if ;
         else -- k=p.k
            raise ya_existe;
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
         true
      elsif p.bl=0 then --creció nivel por subárbol izq
         p.bl:= -1;
         if m=remove_mode then h:= false; end if ; -- else h se mantiene a
         true
      else -- p.bl=-1
         rebalanceo_izq(p, h, m);
      end if ;
   end balanceo_izq;

   procedure rebalanceo_izq(p: in out pnodo; h: out boolean; m: in modo) is
      -- O p.lc ha crecido en altura un nivel (por inserción) o p.rc ha decrecido un nivel (por
      borrado)
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
            if m=remove_ mode then h:= false; end if ; -- else h se mantiene a true
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

   procedure borrar(s: in out conjunto; k: in key) is
      raiz: pnode renames s.raiz;
      h: boolean;
   begin
      borrar(raiz, k, h);
   end borrar;

   procedure borrar(p: in out pnodo; k: in key; h: out boolean) is
   begin
      if p=null then raise no_existe; end if ;
      if k<p.k then
         borrar(p.lc, k, h);
         if h then balanceo_der(p, h, remove_mode); end if ;
      elsif k>p.k then
         borrar(p.rc, k, h);
         if h then balanceo_izq(p, h, remove_mode); end if ;
      else -- k=p.k
         borrado_real(p, h);
      end if ;
   end borrar;

   procedure borrado_real(p: in out pnodo; h: out boolean) is
      -- Prec.: p.k = k
      pmasbajo: pnodo;
   begin
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

end darbolavl;
