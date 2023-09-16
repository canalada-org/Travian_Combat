with Formulas;
use Formulas;

with Tablas;
use Tablas;

with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

-- with ada.Text_IO; use ada.Text_IO;

package body Operaciones is
   procedure Calcular_Resultado (
         Pueblo_Atacante      :        T_Pueblos;                  
         Atacante,                                                 
         Defensor_Romano,                                          
         Defensor_Galo,                                            
         Defensor_Germano     :        Ejercito;                   
         Ratio_Habitantes     :        Float             := 1.0;   
         Nivel_Palacio        :        Integer           := 0;     
         Res_Atacante,                                             
         Res_Defensor_Romano,                                      
         Res_Defensor_Galo,                                        
         Res_Defensor_Germano :    out Ejercito;                   
         Atraco               :        Boolean           := False; 
         Naturaleza           :        Boolean           := False; 
         V                    :        T_Version_Travian := V2     ) is 

      Ataque_Infanteria,  
      Ataque_Caballeria,  
      Ataque_Total      : Integer := 0;  

      Defensa_Infanteria,  
      Defensa_Caballeria,  
      Defensa_Total      : Integer := 0;  

      Bonus : Float := 0.0;  

      Numero_Soldados_Total,  
      Numero_Soldados_Agresores : Integer := 0;  

      Acechar : Boolean := False;  

   begin

      -- Calculamos el número de soldados
      for I in 1..10 loop
         Numero_Soldados_Total:=Numero_Soldados_Total+Atacante.Tropas(I).
            Cantidad;
         Numero_Soldados_Total:=Numero_Soldados_Total+
            Defensor_Romano.Tropas(I).Cantidad;
         Numero_Soldados_Total:=Numero_Soldados_Total+
            Defensor_Germano.Tropas(I).Cantidad;
         Numero_Soldados_Total:=Numero_Soldados_Total+
            Defensor_Galo.Tropas(I).Cantidad;
      end loop;

      ----------- Ataque básico
      case Pueblo_Atacante is
         when Romanos=>
            for I in 1..10 loop
               if Tablas_Romanos(I,4)=1 then
                  Ataque_Infanteria:=Ataque_Infanteria + Integer(
                     -- Valor de ataque de la unidad
                     (
                        Float(Tablas_Romanos(I,1)) -- Ataque base

                        -- La defensa o ataque de armamentería/armería es:
                        -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                        +
                        (
                           (
                              (Cte_Bonus_Defensa_Ataque *Float(
                                    Tablas_Romanos(I,10))) + (0.015*Float(
                                    Tablas_Romanos(I,1)))
                              )  * Float(Atacante.Tropas(I).Nivel)/2.0
                           -- Mejoras 
                           )
                        -- Numero de soldados
                        )
                     * Float(Atacante.Tropas(I).Cantidad)
                     );



               else
                  Ataque_Caballeria:=Ataque_Caballeria + Integer(
                     -- Valor de ataque de la unidad
                     (
                        Float(Tablas_Romanos(I,1)) -- Ataque base

                        -- La defensa o ataque de armamentería/armería es:
                        -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                        +
                        (
                           (
                              (Cte_Bonus_Defensa_Ataque *Float(
                                    Tablas_Romanos(I,10))) + (0.015*Float(
                                    Tablas_Romanos(I,1)))
                              )  * Float(Atacante.Tropas(I).Nivel)/2.0
                           -- Mejoras 
                           )
                        -- Numero de soldados
                        )
                     * Float(Atacante.Tropas(I).Cantidad)
                     );



               end if;

            end loop;
         when Galos=>
            for I in 1..10 loop
               if Tablas_Galos(I,4)=1 then
                  Ataque_Infanteria:=Ataque_Infanteria + Integer(
                     -- Valor de ataque de la unidad
                     (
                        Float(Tablas_Galos(I,1)) -- Ataque base

                        -- La defensa o ataque de armamentería/armería es:
                        -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                        +
                        (
                           (
                              (Cte_Bonus_Defensa_Ataque *Float(
                                    Tablas_Galos(I,10))) + (0.015*Float(
                                    Tablas_Galos(I,1)))
                              )  * Float(Atacante.Tropas(I).Nivel)/2.0
                           -- Mejoras 
                           )
                        -- Numero de soldados
                        )
                     * Float(Atacante.Tropas(I).Cantidad)
                     );

               else
                  Ataque_Caballeria:=Ataque_Caballeria + Integer(
                     -- Valor de ataque de la unidad
                     (
                        Float(Tablas_Galos(I,1)) -- Ataque base

                        -- La defensa o ataque de armamentería/armería es:
                        -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                        +
                        (
                           (
                              (Cte_Bonus_Defensa_Ataque *Float(
                                    Tablas_Galos(I,10))) + (0.015*Float(
                                    Tablas_Galos(I,1)))
                              )  * Float(Atacante.Tropas(I).Nivel)/2.0
                           -- Mejoras 
                           )
                        -- Numero de soldados
                        )
                     * Float(Atacante.Tropas(I).Cantidad)
                     );

               end if;

            end loop;

         when Germanos=>
            for I in 1..10 loop
               if Tablas_Germanos(I,4)=1 then
                  Ataque_Infanteria:=Ataque_Infanteria + Integer(
                     -- Valor de ataque de la unidad
                     (
                        Float(Tablas_Germanos(I,1)) -- Ataque base

                        -- La defensa o ataque de armamentería/armería es:
                        -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                        +
                        (
                           (
                              (Cte_Bonus_Defensa_Ataque *Float(
                                    Tablas_Germanos(I,10))) + (0.015*
                                 Float(Tablas_Germanos(I,1)))
                              )  * Float(Atacante.Tropas(I).Nivel)/2.0
                           -- Mejoras 
                           )
                        -- Numero de soldados
                        )
                     * Float(Atacante.Tropas(I).Cantidad)
                     );

               else
                  Ataque_Caballeria:=Ataque_Caballeria + Integer(
                     -- Valor de ataque de la unidad
                     (
                        Float(Tablas_Germanos(I,1)) -- Ataque base

                        -- La defensa o ataque de armamentería/armería es:
                        -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                        +
                        (
                           (
                              (Cte_Bonus_Defensa_Ataque *Float(
                                    Tablas_Germanos(I,10))) + (0.015*
                                 Float(Tablas_Germanos(I,1)))
                              )  * Float(Atacante.Tropas(I).Nivel)/2.0
                           -- Mejoras 
                           )
                        -- Numero de soldados
                        )
                     * Float(Atacante.Tropas(I).Cantidad)
                     );
               end if;

            end loop;
      end case;

      for I in 1..10 loop
         Numero_Soldados_Agresores:=Numero_Soldados_Agresores+
            Atacante.Tropas(I).Cantidad;
      end loop;

      Ataque_Total:=Ataque_Infanteria+Ataque_Caballeria;



      -- Miramos si es un ataque solo con batidores
      if (Atacante.Tropas(1).Cantidad=0 and
            Atacante.Tropas(2).Cantidad=0 and
            Atacante.Tropas(3).Cantidad=0 and
            Atacante.Tropas(5).Cantidad=0 and
            Atacante.Tropas(6).Cantidad=0 and
            Atacante.Tropas(7).Cantidad=0 and
            Atacante.Tropas(8).Cantidad=0 and
            Atacante.Tropas(9).Cantidad=0 and
            Atacante.Tropas(10).Cantidad=0 and
            Pueblo_Atacante/=Galos) or
            (Atacante.Tropas(1).Cantidad=0 and
            Atacante.Tropas(2).Cantidad=0 and
            Atacante.Tropas(4).Cantidad=0 and
            Atacante.Tropas(5).Cantidad=0 and
            Atacante.Tropas(6).Cantidad=0 and
            Atacante.Tropas(7).Cantidad=0 and
            Atacante.Tropas(8).Cantidad=0 and
            Atacante.Tropas(9).Cantidad=0 and
            Atacante.Tropas(10).Cantidad=0 and
            Pueblo_Atacante=Galos) then

         if Pueblo_Atacante=Galos and Atacante.Tropas(3).Cantidad>0 and
               Atacante.Tropas(10).Cantidad=0 then
            Acechar:=True;

            Ataque_Total:= Integer(
               -- Valor de ataque del batidor
               (
                  Float(Capacidad_Acechar) -- Ataque base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Galos (3,
                                 10))) + (0.015*Float(Capacidad_Acechar))
                        )  * Float(Atacante.Tropas(3).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de batidores
                  )
               * Float(Atacante.Tropas(3).Cantidad)
               );

         elsif Pueblo_Atacante=Romanos and Atacante.Tropas(4).Cantidad>0 and
               Atacante.Tropas(10).Cantidad=0 then
            Acechar:=True;


            Ataque_Total:= Integer(
               -- Valor de ataque del legati
               (
                  Float(Capacidad_Acechar) -- Ataque base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Romanos (
                                 4,10))) + (0.015*Float(Capacidad_Acechar))
                        )  * Float(Atacante.Tropas(4).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de legatis
                  )
               * Float(Atacante.Tropas(4).Cantidad)
               );

         elsif Pueblo_Atacante=Germanos and Atacante.Tropas(4).Cantidad>0 and
               Atacante.Tropas(10).Cantidad=0 then
            Acechar:=True;

            Ataque_Total:= Integer(
               -- Valor de ataque del emisario
               (
                  Float(Capacidad_Acechar) -- Ataque base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Germanos (
                                 4,10))) + (0.015*Float(Capacidad_Acechar))
                        )  * Float(Atacante.Tropas(4).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de emisarios
                  )
               * Float(Atacante.Tropas(4).Cantidad)
               );

         else
            Acechar:=False;
         end if;
      end if;




      ----------------------
      ---- Defensa básica
      ----------------------
      
      if (not Acechar) and (not Naturaleza) then
         -- No acecho, es decir ataque NORMAL/ATRACO
         for I in 1..10 loop

            -- Defensor Romano
            Defensa_Infanteria:=Defensa_Infanteria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Romanos(I,2)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Romanos(I,
                                 10))) + (0.015*Float(Tablas_Romanos(I,2)))
                        )  * Float(Defensor_Romano.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Romano.Tropas(I).Cantidad)
               );




            Defensa_Caballeria:=Defensa_Caballeria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Romanos(I,3)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Romanos(I,
                                 10))) + (0.015*Float(Tablas_Romanos(I,3)))
                        )  * Float(Defensor_Romano.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Romano.Tropas(I).Cantidad)
               );





            -- Defensor Galo
            Defensa_Infanteria:=Defensa_Infanteria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Galos(I,2)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Galos(I,
                                 10))) + (0.015*Float(Tablas_Galos(I,2)))
                        )  * Float(Defensor_Galo.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Galo.Tropas(I).Cantidad)
               );




            Defensa_Caballeria:=Defensa_Caballeria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Galos(I,3)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Galos(I,
                                 10))) + (0.015*Float(Tablas_Galos(I,3)))
                        )  * Float(Defensor_Galo.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Galo.Tropas(I).Cantidad)
               );


            -- Defensor Germano
            Defensa_Infanteria:=Defensa_Infanteria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Germanos(I,2)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Germanos(
                                 I,10))) + (0.015*Float(Tablas_Germanos(I,
                                 2)))
                        )  * Float(Defensor_Germano.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Germano.Tropas(I).Cantidad)
               );




            Defensa_Caballeria:=Defensa_Caballeria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Germanos(I,3)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Germanos(
                                 I,10))) + (0.015*Float(Tablas_Germanos(I,
                                 3)))
                        )  * Float(Defensor_Germano.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Germano.Tropas(I).Cantidad)
               );



         end loop;

         Defensa_Total:=Formulas.Defensa_Total (
            Ataque_Infanteria,
            Ataque_Caballeria,
            Defensa_Infanteria,
            Defensa_Caballeria )  ;



      elsif Naturaleza then -- Atraco contra naturaleza
         for I in 1..10 loop

            -- En un principio los animales no tienen mejoras, pero lo dejamos por si hay que 
            -- agregarlas en un futuro...

            Defensa_Infanteria:=Defensa_Infanteria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Naturaleza(I,2)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(
                              Tablas_Naturaleza(I,10))) + (0.015*Float(
                              Tablas_Naturaleza(I,2)))
                        )  * Float(Defensor_Romano.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Romano.Tropas(I).Cantidad)
               );




            Defensa_Caballeria:=Defensa_Caballeria + Integer(
               -- Valor de defensa de la unidad
               (
                  Float(Tablas_Naturaleza(I,3)) -- Defensa base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(
                              Tablas_Naturaleza(I,10))) + (0.015*Float(
                              Tablas_Naturaleza(I,3)))
                        )  * Float(Defensor_Romano.Tropas(I).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de soldados
                  )
               * Float(Defensor_Romano.Tropas(I).Cantidad)
               );

         end loop;

         Defensa_Total:=Formulas.Defensa_Total (
            Ataque_Infanteria,
            Ataque_Caballeria,
            Defensa_Infanteria,
            Defensa_Caballeria )  ;

      else -- Defensa de ACECHOS

         if Naturaleza then
            Defensa_Total:=0;
         else
            Defensa_Total:=
               -- Defensa acechos de Germanos
               Integer(
               -- Valor de ataque del emisario
               (
                  Float(Defensa_Acechar) -- Ataque base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Germanos (
                                 4,10))) + (0.015*Float(Defensa_Acechar))
                        )  * Float(Defensor_Germano.Tropas(4).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de emisarios
                  )
               * Float(Defensor_Germano.Tropas(4).Cantidad)
               )
               -- Defensa acechos de Romanos
               +  Integer(
               -- Valor de ataque del legatis
               (
                  Float(Defensa_Acechar) -- Ataque base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Romanos(4,
                                 10))) + (0.015*Float(Defensa_Acechar))
                        )  * Float(Defensor_Romano.Tropas(4).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de legatis
                  )
               * Float(Defensor_Romano.Tropas(4).Cantidad)
               )
               -- Defensa acechos de Galos
               +  Integer(
               -- Valor de ataque del batidor
               (
                  Float(Defensa_Acechar) -- Ataque base

                  -- La defensa o ataque de armamentería/armería es:
                  -- (Cte*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
                  +
                  (
                     (
                        (Cte_Bonus_Defensa_Ataque *Float(Tablas_Galos(3,
                                 10))) + (0.015*Float(Defensa_Acechar))
                        )  * Float(Defensor_Galo.Tropas(3).Nivel)/2.0
                     -- Mejoras 
                     )
                  -- Numero de batidores
                  )
               * Float(Defensor_Galo.Tropas(3).Cantidad)
               );
         end if;

      end if;







      ---- Defensa compleja

      -- Palacio - solo si no es un acecho
      if not Acechar then
         Defensa_Total:=Defensa_Total+2*(Nivel_Palacio**2);
      end if;


      -- Muralla
      if Defensor_Romano.Muralla/=0 then
         Bonus:=((1.0+(Bonus_Muralla_Romana/100.0))**
            Defensor_Romano.Muralla);
      elsif Defensor_Galo.Muralla/=0 then
         Bonus:=((1.0+(Bonus_Muralla_Gala/100.0))**
            Defensor_Galo.Muralla);
      elsif Defensor_Germano.Muralla/=0 then
         Bonus:=((1.0+(Bonus_Muralla_Germana/100.0))**
            Defensor_Germano.Muralla);
      else
         Bonus:=1.0;
      end if;
      Defensa_Total:=Integer(Float(Defensa_Total)*Bonus);

      -- La muralla no ayuda si no hay tropas. Agregamos ahora la defensa básica si no es un acecho
      if not Acechar then
         Defensa_Total:=Defensa_Total+ Defensa_Basica(Ataque_Total,
            Numero_Soldados_Agresores);
      end if;



      -- Moral por habitantes
      if Ataque_Total=0 then
         Ataque_Total:=1; -- Evitamos una división por cero
      end if;
      Bonus:=Moral(Ratio_Habitantes,Float(Defensa_Total)/Float(
            Ataque_Total));
      Defensa_Total:=Integer(Float(Defensa_Total)*(1.0+Bonus));




      if Gana_Atacante(Ataque_Total,Defensa_Total) then
         if Acechar then
            -- ACECHO
            for I in 1..10 loop
               Res_Defensor_Romano.Tropas(I).Cantidad:=0;
               Res_Defensor_Galo.Tropas(I).Cantidad:=0;
               Res_Defensor_Germano.Tropas(I).Cantidad:=0;
            end loop;
            for I in 1..10 loop
               Res_Atacante.Tropas(I).Cantidad:=
                  Integer(Float(Atacante.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Ataque_Total,Defensa_Total,False,
                     Numero_Soldados_Total,V));
            end loop;

         else -- ATAQUE O ATRACO


            if not Atraco then-- El defensor pierde todas las tropas
               Res_Defensor_Romano:=Defensor_Romano;
               Res_Defensor_Galo:=Defensor_Galo;
               Res_Defensor_Germano:=Defensor_Germano;
            else
               -- Atraco: ponemos los porcentajes de tropas muertas
               -- Apoyos romanos
               for I in 1..10 loop
                  Res_Defensor_Romano.Tropas(I).Cantidad:=
                     Integer(Float(Defensor_Romano.Tropas(I).Cantidad)
                     *(1.0-Proporcion_Perdidas(Ataque_Total,Defensa_Total,
                           Atraco,Numero_Soldados_Total,V)));
               end loop;
               -- Apoyos Galos
               for I in 1..10 loop
                  Res_Defensor_Galo.Tropas(I).Cantidad:=
                     Integer(Float(Defensor_Galo.Tropas(I).Cantidad)
                     *(1.0-Proporcion_Perdidas(Ataque_Total,Defensa_Total,
                           Atraco,Numero_Soldados_Total,V)));
               end loop;
               -- Apoyos Germanos
               for I in 1..10 loop
                  Res_Defensor_Germano.Tropas(I).Cantidad:=
                     Integer(Float(Defensor_Germano.Tropas(I).Cantidad)
                     *(1.0-Proporcion_Perdidas(Ataque_Total,Defensa_Total,
                           Atraco,Numero_Soldados_Total,V)));
               end loop;
            end if;
            for I in 1..10 loop
               Res_Atacante.Tropas(I).Cantidad:=
                  Integer(Float(Atacante.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Ataque_Total,Defensa_Total,Atraco,
                     Numero_Soldados_Total,V));
            end loop;


         end if;


      else -- Gana el defensor

         if not Acechar then

            -- Apoyos romanos
            for I in 1..10 loop
               Res_Defensor_Romano.Tropas(I).Cantidad:=
                  Integer(Float(Defensor_Romano.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Defensa_Total,Ataque_Total,Atraco,
                     Numero_Soldados_Total,V));
            end loop;
            -- Apoyos Galos
            for I in 1..10 loop
               Res_Defensor_Galo.Tropas(I).Cantidad:=
                  Integer(Float(Defensor_Galo.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Defensa_Total,Ataque_Total,Atraco,
                     Numero_Soldados_Total,V));
            end loop;
            -- Apoyos Germanos
            for I in 1..10 loop
               Res_Defensor_Germano.Tropas(I).Cantidad:=
                  Integer(Float(Defensor_Germano.Tropas(I).Cantidad)
                  *Proporcion_Perdidas(Defensa_Total,Ataque_Total,Atraco,
                     Numero_Soldados_Total,V));
            end loop;

            if Atraco then
               for I in 1..10 loop
                  Res_Atacante.Tropas(I).Cantidad:=
                     Integer(Float(Atacante.Tropas(I).Cantidad)
                     *(1.0-Proporcion_Perdidas(Defensa_Total,Ataque_Total,
                           Atraco,Numero_Soldados_Total,V)));
               end loop;
            else -- El atacante pierde TODO
               Res_Atacante:=Atacante;
            end if;
         else -- El defensor no pierde nada
            for I in 1..10 loop
               Res_Defensor_Romano.Tropas(I).Cantidad:=0;
               Res_Defensor_Galo.Tropas(I).Cantidad:=0;
               Res_Defensor_Germano.Tropas(I).Cantidad:=0;
            end loop;
            -- El espia pierde todo
            Res_Atacante:=Atacante;
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
               Madera:=Madera+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,
                     5));
               Barro:=Barro+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,6));
               Hierro:=Hierro+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,
                     7));
               Cereal:=Cereal+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,
                     8));
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
               Madera:=Madera+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(
                     I,5));
               Barro:=Barro+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(I,
                     6));
               Hierro:=Hierro+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(
                     I,7));
               Cereal:=Cereal+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(
                     I,8));
            end loop;
      end case;
   exception
      when Constraint_Error=>
         Madera:=-1;
         Barro:=-1;
         Hierro:=-1;
         Cereal:=-1;
   end Calcular_Perdidas;


   function Velocidad_Ejercito (
         Pueblo    : T_Pueblos;         
         E         : Ejercito;          
         Artefacto : Boolean   := False ) 
     return Integer is 
      Vel           : Integer := 10000;  
      Multiplicador : Integer := 1;  
   begin
      -- Artefacto de doble velocidad
      if Artefacto then
         Multiplicador:=2;
      else
         Multiplicador:=1;
      end if;

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
      if Vel=10000 then
         return 0;
      else
         return Vel*Multiplicador;
      end if;

   end Velocidad_Ejercito;







   -- Calcula la distancia en casillas entre dos aldeas 1 y 2.
   -- X1 Y1 son las coordenadas de la aldea 1
   -- X2 Y2 son las coordenadas de la aldea 2
   function Calcular_Distancia (
         X1,                                     
         Y1,                                     
         X2,                                     
         Y2,                                     
         Plaza_Torneos : Integer;                
         V             : T_Version_Travian := V2 ) 
     return Float is 
      Dx1,  
      Dx2,  
      Dy1,  
      Dy2       : Integer;  
      Distancia : Float;  
      Max       : Integer;  


      function Distancia_Por_Izquierda (
            A : Integer; 
            B : Integer  ) 
        return Integer is 
      begin
         if A=B then
            return 0;
         elsif A>B then
            return A-B;
         elsif A<B then
            return 1+(2*Max)+A-B;
         end if;
         return 0;
      end Distancia_Por_Izquierda;



   begin
      if V=V2 then
         Max:=Distancia_X_V2;
      elsif V=V3 then
         Max:=Distancia_X_V3;
      end if;

      -- Distancia en el eje x entre los dos puntos si vamos por la izquierda
      Dx1:= Distancia_Por_Izquierda ( X1, X2);
      -- Distancia en el eje x entre los dos puntos si vamos por la derecha (izquierda al reves)
      Dx2:= Distancia_Por_Izquierda ( X2, X1);
      -- Cogemos la menor distancia
      if Dx2<Dx1 then
         Dx1:=Dx2;
      end if;


      -- Distancia en el eje y entre los dos puntos si vamos por arriba
      Dy1:= Distancia_Por_Izquierda ( Y1, Y2);
      -- Distancia en el eje y entre los dos puntos si vamos por abajo (arriba al reves)
      Dy2:= Distancia_Por_Izquierda ( Y2, Y1);
      -- Cogemos la menor distancia
      if Dy2<Dy1 then
         Dy1:=Dy2;
      end if;

      Distancia:=Sqrt(Float(Dx1)**2 + Float(Dy1)**2);


      if Distancia>=20.0 then
         Distancia:= 20.0 + ((Distancia- 20.0)/(1.0 + (Float(Plaza_Torneos) * 0.1)));
      end if;
      return Distancia;

   end Calcular_Distancia;




   -- Devuelve la cultura necesaria para fundar o conquistar una nueva aldea 
   -- según la versión de Travian
   -- Ej: para V2
   -- Aldea: 1; Devuelve 0;
   -- Aldea: 2; Devuelve 2000;
   -- Aldea: 3; Devuelve 8000;
   -- Aldea: 10; Devuelve 162000
   function Calcular_Cultura_Necesaria (
         Aldea : Positive;               
         V     : T_Version_Travian := V2 ) 
     return Natural is 
   begin
      if Aldea=1 then
         return 0;
      elsif V=V3
            then
         return Integer(1.6*Float(Aldea-1)**2.3)*1000;
      else
         return 2000* ((Aldea-1)**2);
      end if;
   end Calcular_Cultura_Necesaria;



   -- Calcula el consumo de cereal del ejército
   function Consumo_Cereal (
         Pueblo : T_Pueblos; 
         Tropas : Ejercito   ) 
     return Natural is 
      Consumo : Natural := 0;  
   begin
      case Pueblo is
         when Romanos =>
            for I in 1..10 loop
               Consumo:=Consumo+(Tropas.Tropas(I).Cantidad*Tablas_Romanos(I,10));
            end loop;
         when Galos =>
            for I in 1..10 loop
               Consumo:=Consumo+(Tropas.Tropas(I).Cantidad*Tablas_Galos(I,10));
            end loop;
         when Germanos=>
            for I in 1..10 loop
               Consumo:=Consumo+(Tropas.Tropas(I).Cantidad*Tablas_Germanos(I,10));

            end loop;
      end case;
      return Consumo;
   end Consumo_Cereal;


end Operaciones;