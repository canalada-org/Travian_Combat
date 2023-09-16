with Formulas;
use Formulas;

package body Operaciones is
   procedure Calcular_Resultado (
         Pueblo_Atacante      :        T_Pueblos;        
         Atacante,                                       
         Defensor_Romano,                                
         Defensor_Galo,                                  
         Defensor_Germano     :        Ejercito;         
         Ratio_Habitantes     :        Float     := 1.0; 
         Nivel_Palacio        :        Integer   := 0;   
         Res_Atacante,                                   
         Res_Defensor_Romano,                            
         Res_Defensor_Galo,                              
         Res_Defensor_Germano :    out Ejercito          ) is 

      Ataque_Infanteria,  
      Ataque_Caballeria,  
      Ataque_Total      : Integer := 0;  

      Defensa_Infanteria,  
      Defensa_Caballeria,  
      Defensa_Total      : Integer := 0;  

      Bonus : Float := 0.0;  

      Numero_Soldados_Agresores : Integer := 0;  

      Acechar : Boolean := False;  
   begin

      ----------- Ataque básico
      case Pueblo_Atacante is
         when Romanos=>
            for I in 1..10 loop
               if Tablas_Romanos(I,4)=1 then
                  Ataque_Infanteria:=Ataque_Infanteria
                     +Integer(Float(Tablas_Romanos(I,1))*                            -- Valor de ataque de la unidad
                     Float(Atacante.Tropas(I).Cantidad)*                                   -- Numero de soldados
                     (1.0+(Float(Atacante.Tropas(I).Nivel)*Bonus_Ataque/100.0)));          -- Bonus de investigación
               else
                  Ataque_Caballeria:=Ataque_Caballeria
                     +Integer(Float(Tablas_Romanos(I,1))*                            -- Valor de ataque de la unidad
                     Float(Atacante.Tropas(I).Cantidad)*                                   -- Numero de soldados
                     (1.0+(Float(Atacante.Tropas(I).Nivel)*Bonus_Ataque/100.0)));          -- Bonus de investigación
               end if;

            end loop;
         when Galos=>
            for I in 1..10 loop
               if Tablas_Galos(I,4)=1 then
                  Ataque_Infanteria:=Ataque_Infanteria
                     +Integer(Float(Tablas_Galos(I,1))*                            -- Valor de ataque de la unidad
                     Float(Atacante.Tropas(I).Cantidad)*                                   -- Numero de soldados
                     (1.0+(Float(Atacante.Tropas(I).Nivel)*Bonus_Ataque/100.0)));          -- Bonus de investigación
               else
                  Ataque_Caballeria:=Ataque_Caballeria
                     +Integer(Float(Tablas_Galos(I,1))*                            -- Valor de ataque de la unidad
                     Float(Atacante.Tropas(I).Cantidad)*                                   -- Numero de soldados
                     (1.0+(Float(Atacante.Tropas(I).Nivel)*Bonus_Ataque/100.0)));          -- Bonus de investigación
               end if;

            end loop;

         when Germanos=>
            for I in 1..10 loop
               if Tablas_Germanos(I,4)=1 then
                  Ataque_Infanteria:=Ataque_Infanteria
                     +Integer(Float(Tablas_Germanos(I,1))*                            -- Valor de ataque de la unidad
                     Float(Atacante.Tropas(I).Cantidad)*                                   -- Numero de soldados
                     (1.0+(Float(Atacante.Tropas(I).Nivel)*Bonus_Ataque/100.0)));          -- Bonus de investigación
               else
                  Ataque_Caballeria:=Ataque_Caballeria
                     +Integer(Float(Tablas_Germanos(I,1))*                            -- Valor de ataque de la unidad
                     Float(Atacante.Tropas(I).Cantidad)*                                   -- Numero de soldados
                     (1.0+(Float(Atacante.Tropas(I).Nivel)*Bonus_Ataque/100.0)));          -- Bonus de investigación
               end if;

            end loop;
      end case;

      for I in 1..10 loop
         Numero_Soldados_Agresores:=Numero_Soldados_Agresores+Atacante.Tropas(I).Cantidad;
      end loop;

      Ataque_Total:=Ataque_Infanteria+Ataque_Caballeria;

      -- Miramos si es un ataque solo con batidores
      if Ataque_Total=0 then
         if Pueblo_Atacante=Galos and Atacante.Tropas(3).Cantidad>0 and Atacante.Tropas(10).Cantidad=0 then
            Acechar:=True;
            Ataque_Total:=Atacante.Tropas(3).Cantidad*Capacidad_Acechar;
         elsif Pueblo_Atacante/=Galos and Atacante.Tropas(4).Cantidad>0 and Atacante.Tropas(10).Cantidad=0 then
            Acechar:=True;
            Ataque_Total:=Atacante.Tropas(4).Cantidad*Capacidad_Acechar;
         else
            Acechar:=False;
         end if;
      end if;

      ---- Defensa básica
      if not Acechar then
         for I in 1..10 loop

            -- Defensor Romano
            Defensa_Infanteria:=Defensa_Infanteria
               +Integer(Float(Tablas_Romanos(I,2))*                                  -- Valor de defensade la unidad
               Float(Defensor_Romano.Tropas(I).Cantidad)*                            -- Numero de soldados
               (1.0+(Float(Defensor_Romano.Tropas(I).Nivel)*Bonus_Defensa/100.0)));   -- Bonus de investigación



            Defensa_Caballeria:=Defensa_Caballeria
               +Integer(Float(Tablas_Romanos(I,3))*                                     -- Valor de defensa de la unidad
               Float(Defensor_Romano.Tropas(I).Cantidad)*                               -- Numero de soldados
               (1.0+(Float(Defensor_Romano.Tropas(I).Nivel)*Bonus_Defensa/100.0)));      -- Bonus de investigación


            -- Defensor Galo
            Defensa_Infanteria:=Defensa_Infanteria
               +Integer(Float(Tablas_Galos(I,2))*                                  -- Valor de defensade la unidad
               Float(Defensor_Galo.Tropas(I).Cantidad)*                            -- Numero de soldados
               (1.0+(Float(Defensor_Galo.Tropas(I).Nivel)*Bonus_Defensa/100.0)));   -- Bonus de investigación

            Defensa_Caballeria:=Defensa_Caballeria
               +Integer(Float(Tablas_Galos(I,3))*                                     -- Valor de defensa de la unidad
               Float(Defensor_Galo.Tropas(I).Cantidad)*                               -- Numero de soldados
               (1.0+(Float(Defensor_Galo.Tropas(I).Nivel)*Bonus_Defensa/100.0)));      -- Bonus de investigación

            -- Defensor Germano
            Defensa_Infanteria:=Defensa_Infanteria
               +Integer(Float(Tablas_Germanos(I,2))*                                  -- Valor de defensade la unidad
               Float(Defensor_Germano.Tropas(I).Cantidad)*                            -- Numero de soldados
               (1.0+(Float(Defensor_Germano.Tropas(I).Nivel)*Bonus_Defensa/100.0)));   -- Bonus de investigación



            Defensa_Caballeria:=Defensa_Caballeria
               +Integer(Float(Tablas_Germanos(I,3))*                                     -- Valor de defensa de la unidad
               Float(Defensor_Germano.Tropas(I).Cantidad)*                               -- Numero de soldados
               (1.0+(Float(Defensor_Germano.Tropas(I).Nivel)*Bonus_Defensa/100.0)));      -- Bonus de investigación

         end loop;

         Defensa_Total:=Formulas.Defensa_Total (
            Ataque_Infanteria,
            Ataque_Caballeria,
            Defensa_Infanteria,
            Defensa_Caballeria )  ;

      else
         Defensa_Total:=(Defensor_Germano.Tropas(4).Cantidad*Defensa_Acechar)
            +(Defensor_Romano.Tropas(4).Cantidad*Defensa_Acechar)
            +(Defensor_Galo.Tropas(3).Cantidad*Defensa_Acechar);
      end if;







      ---- Defensa compleja

      -- Muralla
      if Defensor_Romano.Muralla/=0 then
         Bonus:=((1.0+(Bonus_Muralla_Romana/100.0))**Defensor_Romano.Muralla);
      elsif Defensor_Galo.Muralla/=0 then
         Bonus:=((1.0+(Bonus_Muralla_Gala/100.0))**Defensor_Galo.Muralla);
      elsif Defensor_Germano.Muralla/=0 then
         Bonus:=((1.0+(Bonus_Muralla_Germana/100.0))**Defensor_Germano.Muralla);
      else
         Bonus:=1.0;
      end if;
      Defensa_Total:=Integer(Float(Defensa_Total)*Bonus);

      -- La muralla no ayuda si no hay tropas. Agregamos ahora la defensa básica
      Defensa_Total:=Defensa_Total+ Defensa_Basica(Ataque_Total,Numero_Soldados_Agresores);

      -- Palacio
      Bonus:=Bonus_Palacio*Float(Nivel_Palacio);
      Defensa_Total:=Integer(Float(Defensa_Total)*(1.0+(Bonus/100.0)));



      -- Moral por habitantes
      Bonus:=Moral(Ratio_Habitantes);
      Defensa_Total:=Integer(Float(Defensa_Total)*(1.0+(Bonus/100.0)));



      if Gana_Atacante(Ataque_Total,Defensa_Total) then
         if not Acechar then
            Res_Defensor_Romano:=Defensor_Romano;
            Res_Defensor_Galo:=Defensor_Galo;
            Res_Defensor_Germano:=Defensor_Germano;
         else -- Ponemos a 0
            for I in 1..10 loop
               Res_Defensor_Romano.Tropas(I).Cantidad:=0;
               Res_Defensor_Galo.Tropas(I).Cantidad:=0;
               Res_Defensor_Germano.Tropas(I).Cantidad:=0;
            end loop;
         end if;
         for I in 1..10 loop
            Res_Atacante.Tropas(I).Cantidad:=
               Integer(Float(Atacante.Tropas(I).Cantidad)
               *Proporcion_Perdidas(Ataque_Total,Defensa_Total));
         end loop;

      else -- Gana el defensor
         Res_Atacante:=Atacante;
         if not Acechar then
            -- Apoyos romanos
            for I in 1..10 loop
               Res_Defensor_Romano.Tropas(I).Cantidad:=
                  Integer(Float(Defensor_Romano.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Defensa_Total,Ataque_Total));
            end loop;
            -- Apoyos Galos
            for I in 1..10 loop
               Res_Defensor_Galo.Tropas(I).Cantidad:=
                  Integer(Float(Defensor_Galo.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Defensa_Total,Ataque_Total));
            end loop;
            -- Apoyos Germanos
            for I in 1..10 loop
               Res_Defensor_Germano.Tropas(I).Cantidad:=
                  Integer(Float(Defensor_Germano.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Defensa_Total,Ataque_Total));
            end loop;
         else -- Ponemos a 0
            for I in 1..10 loop
               Res_Defensor_Romano.Tropas(I).Cantidad:=0;
               Res_Defensor_Galo.Tropas(I).Cantidad:=0;
               Res_Defensor_Germano.Tropas(I).Cantidad:=0;
            end loop;

         end if;
      end if;
   end Calcular_Resultado;



   -- Calcula el costo material del ejercito perdido. Las cantidades se suman 
   -- con lo que había antes así que hay que asegurarse de inicializarlas!!
   procedure Calcular_Perdidas (
         Pueblo :        T_Pueblos; 
         Tropas :        Ejercito;  
         Madera : in out Integer;   
         Barro  : in out Integer;   
         Hierro : in out Integer;   
         Cereal : in out Integer    ) is 

   begin
      case Pueblo is
         when Romanos =>
            for I in 1..10 loop
               Madera:=Madera+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,5));
               Barro:=Barro+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,6));
               Hierro:=Hierro+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,7));
               Cereal:=Cereal+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,8));
            end loop;
         when Galos =>
            for I in 1..10 loop
               Madera:=Madera+(Tropas.Tropas(I).Cantidad*Tablas_Galos(I,5));
               Barro:=Barro+(Tropas.Tropas(I).Cantidad*Tablas_Galos(I,6));
               Hierro:=Hierro+(Tropas.Tropas(I).Cantidad*Tablas_Galos(I,7));
               Cereal:=Cereal+(Tropas.Tropas(I).Cantidad*Tablas_Galos(I,8));
            end loop;
         when Germanos=>
            for I in 1..10 loop
               Madera:=Madera+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(I,5));
               Barro:=Barro+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(I,6));
               Hierro:=Hierro+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(I,7));
               Cereal:=Cereal+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(I,8));
            end loop;
      end case;
   end Calcular_Perdidas;


   function Velocidad_Ejercito (
         Pueblo : T_Pueblos; 
         E      : Ejercito   ) 
     return Integer is 
      Vel : Integer := 1000;  
   begin
      for I in 1..10 loop
         if E.Tropas(I).Cantidad>0 then
            case Pueblo is
               when Romanos=>
                  if Vel>Tablas_Romanos(I,9) then
                     Vel:=Tablas_Romanos(I,9);
                  end if;
               when Galos=>
                  if Vel>Tablas_Galos(I,9) then
                     Vel:=Tablas_Galos(I,9);
                  end if;
               when Germanos=>
                  if Vel>Tablas_Germanos(I,9) then
                     Vel:=Tablas_Germanos(I,9);
                  end if;
            end case;
         end if;
      end loop;
      if Vel=1000 then
         return 0;
      else
         return Vel;
      end if;

   end Velocidad_Ejercito;

end Operaciones;