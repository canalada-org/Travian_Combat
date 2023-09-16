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



with Formulas,Operaciones, Ada.Strings.Unbounded;
use Formulas,Operaciones, Ada.Strings.Unbounded;






separate(Simulador)

procedure Realizar_Calculos is 

   Maximo_Tropas : constant Natural := 999999;  

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

   Nivel_Pt : Integer := 0;  
   Atraco   : Boolean := False;  

   Consumo : Natural := 0; -- Consumo de cereal         

   procedure Informe is 
   separate;

   -- Coordenadas máximas:
   Max_X,  
   Max_Y : Integer;  



begin


   -- Coger datos atacante
   for I in 1..10 loop
      Vs_Atacante(I,1):=To_Unbounded_String(Get_Text(
            Casillas_Tropas_Agresor(I).Tropas));
      Vs_Atacante(I,2):=To_Unbounded_String(Get_Text(
            Casillas_Tropas_Agresor(I).Nivel));
   end loop;

   Atraco:=Get_State(Radio_Atraco);

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
   Nivel_Pt:=Valor(To_Unbounded_String(Get_Text(
            Edit_Pt)));

   ----------------------
   -- Corregimos datos

   if Nivel_Pt>20 then
      Nivel_Pt:=20;
      Set_Text(Edit_Pt,"20");
   elsif Nivel_Pt<0 then
      Nivel_Pt:=0;
      Set_Text(Edit_Pt,"0");
   end if;

   case Version_Travian is
      when V2=>
         Max_X:=Distancia_X_V2;
         Max_Y:=Distancia_Y_V2;
      when V3=>
         Max_X:=Distancia_X_V3;
         Max_Y:=Distancia_Y_V3;
   end case;
   if Coordenadas.Agresor_X>Max_X  then
      Coordenadas.Agresor_X:=Max_X;
      Set_Text(Edit_Aldea_Agresorax,Quita_Espacios(Integer'Image(Max_X)));
   end if;
   if Coordenadas.Agresor_X<-Max_X  then
      Coordenadas.Agresor_X:=-Max_X;
      Set_Text(Edit_Aldea_Agresorax,"-" & Quita_Espacios(Integer'Image(
               Max_X)));
   end if;

   if Coordenadas.Agresor_Y>Max_Y  then
      Coordenadas.Agresor_Y:=Max_Y;
      Set_Text(Edit_Aldea_Agresoray,Quita_Espacios(Integer'Image(Max_Y)));
   end if;
   if Coordenadas.Agresor_Y<-Max_Y  then
      Coordenadas.Agresor_Y:=-Max_Y;
      Set_Text(Edit_Aldea_Agresoray,"-" & Quita_Espacios(Integer'Image(
               Max_Y)));
   end if;


   if Coordenadas.Defensor_X>Max_X  then
      Coordenadas.Defensor_X:=Max_X;
      Set_Text(Edit_Aldea_Defensorax,Quita_Espacios(Integer'Image(Max_X)));
   end if;
   if Coordenadas.Defensor_X<-Max_X  then
      Coordenadas.Defensor_X:=-Max_X;
      Set_Text(Edit_Aldea_Defensorax,"-" & Quita_Espacios(Integer'Image(
               Max_X)));
   end if;

   if Coordenadas.Defensor_Y>Max_Y then
      Coordenadas.Defensor_Y:=Max_Y;
      Set_Text(Edit_Aldea_Defensoray,Quita_Espacios(Integer'Image(Max_Y)));
   end if;
   if Coordenadas.Defensor_Y<-Max_Y then
      Coordenadas.Defensor_Y:=-Max_Y;
      Set_Text(Edit_Aldea_Defensoray,"-" & Quita_Espacios(Integer'Image(
               Max_Y)));
   end if;


   if Nivel_Palacio>99 then
      Nivel_Palacio:=99;
      Set_Text(Edit_Palacio_Defensor,"99");
   elsif Nivel_Palacio<0 then
      Nivel_Palacio:=0;
      Set_Text(Edit_Palacio_Defensor,"0");
   end if;

   if Defensor_Romano.Muralla>20 then
      Defensor_Romano.Muralla:=20;
      Set_Text(Edit_Muralla_Defensor,"20");
   elsif Defensor_Romano.Muralla<0 then
      Defensor_Romano.Muralla:=0;
      Set_Text(Edit_Muralla_Defensor,"0");

   end if;

   if Defensor_Galo.Muralla>20 then
      Defensor_Galo.Muralla:=20;
      Set_Text(Edit_Empalizada_Defensor,"20");
   elsif Defensor_Galo.Muralla<0 then
      Defensor_Galo.Muralla:=0;
      Set_Text(Edit_Empalizada_Defensor,"0");
   end if;

   if Defensor_Germano.Muralla>20 then
      Defensor_Germano.Muralla:=20;
      Set_Text(Edit_Terraplen_Defensor,"20");
   elsif Defensor_Germano.Muralla<0 then
      Defensor_Germano.Muralla:=0;
      Set_Text(Edit_Terraplen_Defensor,"0");
   end if;


   -- Pasamos los datos a enteros
   for I in 1..10 loop
      Atacante.Tropas(I).Cantidad:=Valor(Vs_Atacante(I,1));
      if Atacante.Tropas(I).Cantidad > Maximo_Tropas then
         Atacante.Tropas(I).Cantidad := Maximo_Tropas;
      end if;
      Cantidad_Tropas.Atacante:=Cantidad_Tropas.Atacante+
         Atacante.Tropas(I).Cantidad;
      Atacante.Tropas(I).Nivel:=Valor(Vs_Atacante(I,2));
      if  Atacante.Tropas(I).Nivel>20 then
         Atacante.Tropas(I).Nivel:=20;
         Set_Text( Casillas_Tropas_Agresor(I).Nivel,"20");
      elsif  Atacante.Tropas(I).Nivel<0 then
         Atacante.Tropas(I).Nivel:=0;
         Set_Text( Casillas_Tropas_Agresor(I).Nivel,"0");
      end if;
   end loop;

   for I in 1..10 loop
      Defensor_Romano.Tropas(I).Cantidad:=Valor(Vs_Defensor_Romano(I,1));
      if Defensor_Romano.Tropas(I).Cantidad > Maximo_Tropas then
         Defensor_Romano.Tropas(I).Cantidad := Maximo_Tropas;
      end if;
      Cantidad_Tropas.Defensor_Romano:=Cantidad_Tropas.Defensor_Romano+
         Defensor_Romano.Tropas(I).Cantidad;
      Defensor_Romano.Tropas(I).Nivel:=Valor(Vs_Defensor_Romano(I,2));
      if  Defensor_Romano.Tropas(I).Nivel>20 then
         Defensor_Romano.Tropas(I).Nivel:=20;
         Set_Text( Casillas_Tropas_Defensor_Romano(I).Nivel,"20");
      elsif  Defensor_Romano.Tropas(I).Nivel<0 then
         Defensor_Romano.Tropas(I).Nivel:=0;
         Set_Text( Casillas_Tropas_Defensor_Romano(I).Nivel,"0");

      end if;
   end loop;

   for I in 1..10 loop
      Defensor_Galo.Tropas(I).Cantidad:=Valor(Vs_Defensor_Galo(I,1));
      if Defensor_Galo.Tropas(I).Cantidad > Maximo_Tropas then
         Defensor_Galo.Tropas(I).Cantidad := Maximo_Tropas;
      end if;
      Cantidad_Tropas.Defensor_Galo:=Cantidad_Tropas.Defensor_Galo+
         Defensor_Galo.Tropas(I).Cantidad;
      Defensor_Galo.Tropas(I).Nivel:=Valor(Vs_Defensor_Galo(I,2));
      if  Defensor_Galo.Tropas(I).Nivel>20 then
         Defensor_Galo.Tropas(I).Nivel:=20;
         Set_Text( Casillas_Tropas_Defensor_Galo(I).Nivel,"20");
      elsif  Defensor_Galo.Tropas(I).Nivel<0 then
         Defensor_Galo.Tropas(I).Nivel:=0;
         Set_Text( Casillas_Tropas_Defensor_Galo(I).Nivel,"0");
      end if;
   end loop;

   for I in 1..10 loop
      Defensor_Germano.Tropas(I).Cantidad:=Valor(Vs_Defensor_Germano(I,
            1));
      if Defensor_Germano.Tropas(I).Cantidad > Maximo_Tropas then
         Defensor_Germano.Tropas(I).Cantidad := Maximo_Tropas;
      end if;
      Cantidad_Tropas.Defensor_Germano:=
         Cantidad_Tropas.Defensor_Germano+Defensor_Germano.Tropas(I).
         Cantidad;
      Defensor_Germano.Tropas(I).Nivel:=Valor(Vs_Defensor_Germano(I,2));
      if  Defensor_Germano.Tropas(I).Nivel>20 then
         Defensor_Germano.Tropas(I).Nivel:=20;
         Set_Text( Casillas_Tropas_Defensor_Germano(I).Nivel,"20");
      elsif  Defensor_Germano.Tropas(I).Nivel<0 then
         Defensor_Germano.Tropas(I).Nivel:=0;
         Set_Text( Casillas_Tropas_Defensor_Germano(I).Nivel,"0");
      end if;
   end loop;


   -- Distancia (aplicamos raiz cuadrada de la suma de los catetos)
   Distancia:=Calcular_Distancia(Coordenadas.Agresor_X,
      Coordenadas.Agresor_Y,
      Coordenadas.Defensor_X,Coordenadas.Defensor_Y,Nivel_Pt,
      Version_Travian);


   if Velocidad_Ejercito(Pueblo,Atacante,Get_State(Check_Artefacto))/=0 then
      Tiempo:=Distancia/Float(Velocidad_Ejercito(Pueblo,Atacante,
            Get_State(Check_Artefacto)));

      Horas:=Entero(Tiempo);
      Tiempo:=Fraccion(Tiempo)*60.0;
      Minutos:=Entero(Tiempo);
      if Minutos>=60 then-- Corregimos error por redondeo
         Horas:=Horas+1;
         Minutos:=Minutos-60;
      end if;
      Tiempo:=Fraccion(Tiempo)*60.0;
      Segundos:=Natural(Tiempo);
      if Segundos>=60 then -- Corregimos error por redondeo
         Minutos:=Minutos+1;
         Segundos:=Segundos-60;
         if Minutos>=60 then
            Horas:=Horas+1;
            Minutos:=Minutos-60;
         end if;
      end if;

      Set_Text( Edit_Tiempo_Llegada,Quita_Espacios(Natural'Image(Horas)) &
         " : " &
         Quita_Espacios(Dos_Digitos(Minutos)) & " : " &
         Quita_Espacios( Dos_Digitos(Segundos)));
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
      Res_Defensor_Germano,
      Atraco, Naturaleza, Version_Travian );

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


   if not Naturaleza then
      Calcular_Perdidas (Romanos,Res_Defensor_Romano,Madera,Barro,Hierro,
         Cereal);
   end if;
   Set_Text(Recursos_Perdidos(2).Madera,Integer'Image(Madera));
   Set_Text(Recursos_Perdidos(2).Barro,Integer'Image(Barro));
   Set_Text(Recursos_Perdidos(2).Hierro,Integer'Image(Hierro));
   Set_Text(Recursos_Perdidos(2).Cereal,Integer'Image(Cereal));
   Madera:=0;
   Barro:=0;
   Hierro:=0;
   Cereal:=0;

   if not Naturaleza then
      Calcular_Perdidas (Germanos,Res_Defensor_Germano,Madera,Barro,
         Hierro,Cereal);
   end if;
   Set_Text(Recursos_Perdidos(3).Madera,Integer'Image(Madera));
   Set_Text(Recursos_Perdidos(3).Barro,Integer'Image(Barro));
   Set_Text(Recursos_Perdidos(3).Hierro,Integer'Image(Hierro));
   Set_Text(Recursos_Perdidos(3).Cereal,Integer'Image(Cereal));
   Madera:=0;
   Barro:=0;
   Hierro:=0;
   Cereal:=0;

   if not Naturaleza then
      Calcular_Perdidas (Galos,Res_Defensor_Galo,Madera,Barro,Hierro,
         Cereal);
   end if;
   Set_Text(Recursos_Perdidos(4).Madera,Integer'Image(Madera));
   Set_Text(Recursos_Perdidos(4).Barro,Integer'Image(Barro));
   Set_Text(Recursos_Perdidos(4).Hierro,Integer'Image(Hierro));
   Set_Text(Recursos_Perdidos(4).Cereal,Integer'Image(Cereal));
   Madera:=0;
   Barro:=0;
   Hierro:=0;
   Cereal:=0;




   -- Consumo atacante
   Consumo:= Consumo_Cereal (Pueblo, Atacante );
   Set_Text(Consumo_Atacante,Integer'Image(Consumo));

   if not Naturaleza then
      Consumo:= Consumo_Cereal (Galos, Defensor_Galo);
      Consumo:= Consumo+Consumo_Cereal (Germanos, Defensor_Germano);
      Consumo:= Consumo+Consumo_Cereal (Romanos, Defensor_Romano);
      Set_Text(Consumo_Defensor,Integer'Image(Consumo));
   else
      Set_Text(Consumo_Defensor,Integer'Image(0));
   end if;

   -- Realizamos un informe y lo guardamos en la ruta por defecto
   if Hacer_Informe/=0 then
      Informe;
   end if;

   delay(0.1);

end Realizar_Calculos;