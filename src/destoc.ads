package destoc is
   type marca is ('Nike', 'Adidas', 'Reebok', 'Asics', 'Fila', 'Puma', 'Quiksilver', 'Kappa',
                  'Joma', 'Converse');
   type codi is new Natural range 0..5000000;
   type nom is new String(1..33);
   type estoc is limited private;

   procedure estoc_buit(c: out estoc);
   procedure posar_producte(c: in out estoc; m: in marca; k: in codi;
                            n: in nom; unitats: in integer);
   procedure esborrar_producte(c: in out estoc; k: in codi);
   procedure imprimir_productes_marca(c: in estoc; m: in marca);
   procedure imprimir_estoc_total(c: in estoc);

private

   type producte is record
      n: nom;
      m: marca;
      c: codi;
      u: integer;
      end record;

   type estoc is record
      p: integer;
   end record;

end destoc;
