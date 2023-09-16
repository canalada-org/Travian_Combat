with Ada.Characters.Handling,Ada.Numerics.Elementary_Functions;
use Ada.Characters.Handling,Ada.Numerics.Elementary_Functions;

with Tablas;
use Tablas;

-- with ada.Text_IO; use ada.Text_IO;

package body Formulas is


   -- Dado el ratio habitantes del agresor / habitantes del defensor
   -- calcula la moral que ganará el defensor
   function Moral (
         Ratio_Pob,        
         Ratio_Da  : Float ) 
     return Float is 
      R : Float;  
   begin
      if Ratio_Da<=1.0 then
         R:=1.0;
      else
         R:=Ratio_Da;
      end if;

      if Ratio_Pob**(1.0/R) <=1.0 then
         return 0.0;
      elsif Ratio_Pob**(1.0/R) <7.5 then
         return (Log (Ratio_Pob**(1.0/R),2.7181)/(4.85-((Ratio_Pob**(1.0/
                        R))/9.0)));
      elsif Ratio_Pob**(1.0/R) >=7.5 then
         return 0.5;
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
         return Defensa_Infanteria;
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
      --            if N_Tropas=1 and Ataque<85 then
      --               return 75;
      --            else
      --               return 15;
      --            end if;
      if N_Tropas=1 then
         return 53;
      else
         return 15;
      end if;


   end Defensa_Basica;



   function Calcular_Exponente (
         Numero_Tropas : Integer;                              
         V             : Tablas.T_Version_Travian := Tablas.V2 ) 
     return Float is 
      Temp_Exponente : Float;  
   begin

      -- Calculo del exponente:
      --      Curva del tipo f(x)=a+b*log10(x) donde:
      --         a = 1.5
      --         b = -0.08
      --
      --       Este resultado es totalmente EMPIRICO y se sacó con GNUplot, así que 
      --        muy posiblemente pete xDDDD
      --
      --       Las unidades hay que DIVIDIRLAS entre 1000!!

      if V=V2 then
         Temp_Exponente:=1.5;
      else
         -- V3
         Temp_Exponente:=1.5-0.08*Log ((Float(Numero_Tropas)/1000.0),10.0);
      end if;
      return Temp_Exponente;
   end Calcular_Exponente;



   -- Devuelve el porcentaje de pérdidas del ganador
   function Proporcion_Perdidas (
         Ganador,                 
         Perdedor      : Integer; 
         Atraco        : Boolean; 
         Numero_Tropas : Integer; 
         -- Numero de tropas agresor+defensores             
         V : Tablas.T_Version_Travian := Tablas.V2 ) 
     return Float is 
      Exponente,  
      Temp      : Float;  

   begin

      if Ganador=0 or (Ganador=15 and Perdedor=1) then
         return 0.0;
      end if;



      Exponente:=Calcular_Exponente(Numero_Tropas,V);


      Temp:= ( Float(Perdedor) / Float(Ganador) ) **Exponente;


      if not Atraco then
         return   Temp;
      else
         return Temp/ (1.0+Temp);
      end if;
   end Proporcion_Perdidas;





   -- Dada una cadena, devuelve su valor entero (una especie de atoi)
   function Valor (
         S : Unbounded_String ) 
     return Integer is 
      A : Integer;  
   begin
      A:= Integer'Value(To_String(S));
      return A;
   exception
      when others=>
         return 0;
   end Valor;

   -- Devuelve la parte entera de F
   function Entero (
         F : Float ) 
     return Integer is 
   begin
      if F-Float(Integer(F))>=0.0 then
         return Integer(F);
      else
         return (Integer(F)-1);
      end if;
   end Entero;

   -- Devuelve la parte fraccionaria de f
   function Fraccion (
         F : Float ) 
     return Float is 
   begin
      return F-Float(Entero(F));
   end Fraccion;

   -- Devuelve el string de un número con dos digitos (para las horas)
   function Dos_Digitos (
         N : Natural ) 
     return String is 
      Imagenes : String (1 .. 10) := "0123456789";  
   begin
      if N<10 then
         return "0"&Imagenes(N+1);
      else
         return Natural'Image(N);
      end if;
   end Dos_Digitos;

   -- Prec: S es un string de longitud 'l' >=0
   -- Post: Si 'l'>0 devuelve un string en minúsculas con el primer caracter
   --       en mayúsculas. Si 'l'=0 devuelve 'X'.
   function Formato (
         X : in     String ) 
     return String is 
      Y : Unbounded_String;  
   begin
      if Length(To_Unbounded_String(X))>0 then
         Y:=To_Unbounded_String(To_Lower(X));
         Replace_Element(Y,1,To_Upper(Element(Y,1)));
         return To_String(Y);
      else
         return X;
      end if;
   end Formato;

   -- Se encarga de quitar los espacios iniciales. 
   -- Usado para quitar los espacios después de convertir un número
   -- a string que ada estupidamente mete.
   function Quita_Espacios (
         S : in     String ) 
     return String is 
      I : Integer := S'First;  
   begin
      if S'Last>=I then
         while S(I)=' ' and I< S'Last loop
            I:=I+1;
         end loop;
      end if;
      return S(I..S'Last);
   end Quita_Espacios;

end Formulas;
