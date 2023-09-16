with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;


package body Formulas is


   -- Dado el ratio habitantes del agresor / habitantes del defensor
   -- calcula la moral que ganará el defensor
   function Moral (
         Ratio : Float ) 
     return Float is 
   begin

      if Ratio <=1.0 then
         return 0.0;
      elsif Ratio <=3.75 then
         return (Ratio-1.0)*12.0;
      elsif Ratio <=7.5 then
         return 33.3;
      elsif Ratio >7.5 then
         return 50.0;
      end if;

      -- Caso imposible
      return 0.0;


   end Moral;


   -- Devuelve los puntos de defensa totales en función a la proporción de 
   -- infantería y caballería que ataca
   function Defensa_Total (
         Ataque_Infanteria,           
         Ataque_Caballeria,           
         Defensa_Infanteria,          
         Defensa_Caballeria : Integer ) 
     return Integer is 
      Proporcion_Inf : Float;  
      Ataque_Total   : Integer;  
   begin
      Ataque_Total:=Ataque_Caballeria+Ataque_Infanteria;
      if Ataque_Total=0 then
         return 0;
      end if;
      Proporcion_Inf:=Float(Ataque_Infanteria)/Float(Ataque_Total);
      return
         Integer(Proporcion_Inf*Float(Defensa_Infanteria))
         +
         Integer((1.0-Proporcion_Inf)*Float(Defensa_Caballeria));
   end Defensa_Total;




   -- Dados los puntos de ataque y defensa, dice quien gana
   function Gana_Atacante (
         Ataque_Total,           
         Defensa_Total : Integer ) 
     return Boolean is 
   begin
      return Ataque_Total>Defensa_Total;
   end Gana_Atacante;


   -- Calcula la defensa de la aldea en función del numero de tropas y del ataque 
   -- de cada una
   function Defensa_Basica (
         Ataque,            
         N_Tropas : Integer ) 
     return Integer is 

   begin
      if N_Tropas=1 and Ataque<85 then
         return 75;
      else
         return 15;
      end if;
   end Defensa_Basica;


   -- Devuelve el porcentaje de pérdidas del ganador
   function Proporcion_Perdidas (
         Ganador,           
         Perdedor : Integer ) 
     return Float is 

   begin
      if Ganador=0 then
         return 0.0;
      end if;
      return
         Sqrt(   (  Float(Perdedor ) / Float(Ganador) )**3 );

   end Proporcion_Perdidas;


end Formulas;
