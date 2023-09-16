----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------


with Operaciones, Ada.Strings.Unbounded;
use Operaciones, Ada.Strings.Unbounded;



with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;


separate(Travian_Combat)

procedure Realizar_Calculos is 

   type Vector_Strings_Ejercito is array (1 .. 10, 1 .. 2) of Unbounded_String; 

   type Coordenadas_Aldeas is 
      record 
         Agresor_X  : Integer;  
         Agresor_Y  : Integer;  
         Defensor_X : Integer;  
         Defensor_Y : Integer;  
      end record; 

   type T_Cantidad_Tropas is 
      record 
         Atacante         : Natural := 0;  
         Defensor_Romano  : Natural := 0;  
         Defensor_Galo    : Natural := 0;  
         Defensor_Germano : Natural := 0;  
      end record; 


   Cantidad_Tropas : T_Cantidad_Tropas;  

   Coordenadas : Coordenadas_Aldeas;  
   Distancia   : Float;  
   Tiempo      : Float;  
   Horas,  
   Minutos,  
   Segundos    : Natural            := 0;  

   Vs_Atacante,  
   Vs_Defensor_Romano,  
   Vs_Defensor_Galo,  
   Vs_Defensor_Germano : Vector_Strings_Ejercito;  

   Atacante,  
   Defensor_Romano,  
   Defensor_Galo,  
   Defensor_Germano     : Ejercito;  
   Habitantes_Agresor,  
   Habitantes_Agredido  : Integer;  
   Ratio_Habitantes     : Float    := 1.0;  
   Nivel_Palacio        : Integer  := 0;  
   Res_Atacante,  
   Res_Defensor_Romano,  
   Res_Defensor_Galo,  
   Res_Defensor_Germano : Ejercito;  

   Madera,  
   Barro,  
   Hierro,  
   Cereal : Integer := 0;  

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

   procedure Informe is 
   separate;
begin

   loop
      -- Coger datos atacante
      for I in 1..10 loop
         Vs_Atacante(I,1):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Agresor(I).Tropas));
         Vs_Atacante(I,2):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Agresor(I).Nivel));
      end loop;

      -- Coger datos defensor romano
      for I in 1..10 loop
         Vs_Defensor_Romano(I,1):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Defensor_Romano(I).Tropas));
         Vs_Defensor_Romano(I,2):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Defensor_Romano(I).Nivel));
      end loop;

      -- Coger datos defensor galo
      for I in 1..10 loop
         Vs_Defensor_Galo(I,1):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Defensor_Galo(I).Tropas));
         Vs_Defensor_Galo(I,2):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Defensor_Galo(I).Nivel));
      end loop;

      -- Coger datos defensor germano
      for I in 1..10 loop
         Vs_Defensor_Germano(I,1):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Defensor_Germano(I).Tropas));
         Vs_Defensor_Germano(I,2):=To_Unbounded_String(Get_Text(
               Casillas_Tropas_Defensor_Germano(I).Nivel));
      end loop;

      Habitantes_Agresor   :=Valor(To_Unbounded_String(Get_Text(
               Edit_Hab_Agresor)));
      Habitantes_Agredido  :=Valor(To_Unbounded_String(Get_Text(
               Edit_Hab_Defensor)));

      Nivel_Palacio:=Valor(To_Unbounded_String(Get_Text(
               Edit_Palacio_Defensor)));

      Defensor_Romano.Muralla:=Valor(To_Unbounded_String(Get_Text(
               Edit_Muralla_Defensor)));
      Defensor_Galo.Muralla:=Valor(To_Unbounded_String(Get_Text(
               Edit_Empalizada_Defensor)));
      Defensor_Germano.Muralla:=Valor(To_Unbounded_String(Get_Text(
               Edit_Terraplen_Defensor)));

      Coordenadas.Agresor_X:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Agresorax)));
      Coordenadas.Agresor_Y:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Agresoray)));
      Coordenadas.Defensor_X:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Defensorax)));
      Coordenadas.Defensor_Y:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Defensoray)));

      ----------------------


      if Nivel_Palacio>20 then
         Nivel_Palacio:=20;
      elsif Nivel_Palacio<0 then
         Nivel_Palacio:=0;
      end if;

      if Defensor_Romano.Muralla>20 then
         Defensor_Romano.Muralla:=20;
      elsif Defensor_Romano.Muralla<0 then
         Defensor_Romano.Muralla:=0;
      end if;

      if Defensor_Galo.Muralla>20 then
         Defensor_Galo.Muralla:=20;
      elsif Defensor_Galo.Muralla<0 then
         Defensor_Galo.Muralla:=0;
      end if;

      if Defensor_Germano.Muralla>20 then
         Defensor_Germano.Muralla:=20;
      elsif Defensor_Germano.Muralla<0 then
         Defensor_Germano.Muralla:=0;
      end if;


      -- Pasamos los datos a enteros
      for I in 1..10 loop
         Atacante.Tropas(I).Cantidad:=Valor(Vs_Atacante(I,1));
         Cantidad_Tropas.Atacante:=Cantidad_Tropas.Atacante+
            Atacante.Tropas(I).Cantidad;
         Atacante.Tropas(I).Nivel:=Valor(Vs_Atacante(I,2));
         if  Atacante.Tropas(I).Nivel>20 then
            Atacante.Tropas(I).Nivel:=20;
         elsif  Atacante.Tropas(I).Nivel<0 then
            Atacante.Tropas(I).Nivel:=0;
         end if;
      end loop;

      for I in 1..10 loop
         Defensor_Romano.Tropas(I).Cantidad:=Valor(Vs_Defensor_Romano(I,1));
         Cantidad_Tropas.Defensor_Romano:=Cantidad_Tropas.Defensor_Romano+
            Defensor_Romano.Tropas(I).Cantidad;
         Defensor_Romano.Tropas(I).Nivel:=Valor(Vs_Defensor_Romano(I,2));
         if  Defensor_Romano.Tropas(I).Nivel>20 then
            Defensor_Romano.Tropas(I).Nivel:=20;
         elsif  Defensor_Romano.Tropas(I).Nivel<0 then
            Defensor_Romano.Tropas(I).Nivel:=0;
         end if;
      end loop;

      for I in 1..10 loop
         Defensor_Galo.Tropas(I).Cantidad:=Valor(Vs_Defensor_Galo(I,1));
         Cantidad_Tropas.Defensor_Galo:=Cantidad_Tropas.Defensor_Galo+
            Defensor_Galo.Tropas(I).Cantidad;
         Defensor_Galo.Tropas(I).Nivel:=Valor(Vs_Defensor_Galo(I,2));
         if  Defensor_Galo.Tropas(I).Nivel>20 then
            Defensor_Galo.Tropas(I).Nivel:=20;
         elsif  Defensor_Galo.Tropas(I).Nivel<0 then
            Defensor_Galo.Tropas(I).Nivel:=0;
         end if;
      end loop;

      for I in 1..10 loop
         Defensor_Germano.Tropas(I).Cantidad:=Valor(Vs_Defensor_Germano(I,
               1));
         Cantidad_Tropas.Defensor_Germano:=
            Cantidad_Tropas.Defensor_Germano+Defensor_Germano.Tropas(I).
            Cantidad;
         Defensor_Germano.Tropas(I).Nivel:=Valor(Vs_Defensor_Germano(I,2));
         if  Defensor_Germano.Tropas(I).Nivel>20 then
            Defensor_Germano.Tropas(I).Nivel:=20;
         elsif  Defensor_Germano.Tropas(I).Nivel<0 then
            Defensor_Germano.Tropas(I).Nivel:=0;
         end if;
      end loop;

      -- Distancia (aplicamos raiz cuadrada de la suma de los catetos)
      Distancia:=Sqrt((Float(Coordenadas.Agresor_X-Coordenadas.Defensor_X)**
            2) + (Float(Coordenadas.Agresor_Y-Coordenadas.Defensor_Y)**2) );

      if Velocidad_Ejercito(Pueblo,Atacante)/=0 then
         Tiempo:=Distancia/Float(Velocidad_Ejercito(Pueblo,Atacante));

         Horas:=Entero(Tiempo);
         Tiempo:=Fraccion(Tiempo)*60.0;
         Minutos:=Entero(Tiempo);
         Tiempo:=Fraccion(Tiempo)*60.0;
         Segundos:=Natural(Tiempo);
         Set_Text( Edit_Tiempo_Llegada,Natural'Image(Horas) & " : " &
            Dos_Digitos(Minutos) & " : " & Dos_Digitos(Segundos));
      else
         Set_Text(Edit_Tiempo_Llegada,"");
      end if;

      -- Ratio habitantes
      if Habitantes_Agredido>0  then
         Ratio_Habitantes:=Float(Habitantes_Agresor)/Float(
            Habitantes_Agredido);
      else
         Ratio_Habitantes:=1.0;
      end if;

      Calcular_Resultado (
         Pueblo,
         Atacante,
         Defensor_Romano,
         Defensor_Galo,
         Defensor_Germano,
         Ratio_Habitantes,
         Nivel_Palacio,
         Res_Atacante,
         Res_Defensor_Romano,
         Res_Defensor_Galo,
         Res_Defensor_Germano );

      -- Imprimimos resultado
      for I in 1..10 loop
         Set_Text(Casillas_Tropas_Agresor(I).Perdidas,Integer'Image(
               Res_Atacante.Tropas(I).Cantidad));
         Set_Text(Casillas_Tropas_Defensor_Romano(I).Perdidas,Integer'
            Image(Res_Defensor_Romano.Tropas(I).Cantidad));
         Set_Text(Casillas_Tropas_Defensor_Galo(I).Perdidas,Integer'Image(
               Res_Defensor_Galo.Tropas(I).Cantidad));
         Set_Text(Casillas_Tropas_Defensor_Germano(I).Perdidas,Integer'
            Image(Res_Defensor_Germano.Tropas(I).Cantidad));
      end loop;

      -- Perdidas
      Calcular_Perdidas (Pueblo,Res_Atacante,Madera,Barro,Hierro,Cereal);
      Set_Text(Recursos_Perdidos(1).Madera,Integer'Image(Madera));
      Set_Text(Recursos_Perdidos(1).Barro,Integer'Image(Barro));
      Set_Text(Recursos_Perdidos(1).Hierro,Integer'Image(Hierro));
      Set_Text(Recursos_Perdidos(1).Cereal,Integer'Image(Cereal));
      Madera:=0;
      Barro:=0;
      Hierro:=0;
      Cereal:=0;


      Calcular_Perdidas (Romanos,Res_Defensor_Romano,Madera,Barro,Hierro,
         Cereal);
      Set_Text(Recursos_Perdidos(2).Madera,Integer'Image(Madera));
      Set_Text(Recursos_Perdidos(2).Barro,Integer'Image(Barro));
      Set_Text(Recursos_Perdidos(2).Hierro,Integer'Image(Hierro));
      Set_Text(Recursos_Perdidos(2).Cereal,Integer'Image(Cereal));
      Madera:=0;
      Barro:=0;
      Hierro:=0;
      Cereal:=0;

      Calcular_Perdidas (Germanos,Res_Defensor_Germano,Madera,Barro,
         Hierro,Cereal);
      Set_Text(Recursos_Perdidos(3).Madera,Integer'Image(Madera));
      Set_Text(Recursos_Perdidos(3).Barro,Integer'Image(Barro));
      Set_Text(Recursos_Perdidos(3).Hierro,Integer'Image(Hierro));
      Set_Text(Recursos_Perdidos(3).Cereal,Integer'Image(Cereal));
      Madera:=0;
      Barro:=0;
      Hierro:=0;
      Cereal:=0;

      Calcular_Perdidas (Galos,Res_Defensor_Galo,Madera,Barro,Hierro,
         Cereal);
      Set_Text(Recursos_Perdidos(4).Madera,Integer'Image(Madera));
      Set_Text(Recursos_Perdidos(4).Barro,Integer'Image(Barro));
      Set_Text(Recursos_Perdidos(4).Hierro,Integer'Image(Hierro));
      Set_Text(Recursos_Perdidos(4).Cereal,Integer'Image(Cereal));
      Madera:=0;
      Barro:=0;
      Hierro:=0;
      Cereal:=0;

      -- Realizamos un informe y lo guardamos en la ruta por defecto
      if Hacer_Informe then
         Informe;
      end if;

      delay(0.15);
   end loop;
end Realizar_Calculos;