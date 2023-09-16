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
with Formulas,Operaciones,Tablas;
use Formulas,Operaciones,Tablas;

with Ada.Calendar;
use Ada.Calendar;

with Ada.Text_Io;
use Ada.Text_Io;

separate(Coordinador)

procedure Realizar_Calculos is 

   -- Coordenadas de la aldea a atacar
   X_Objetivo,  
   Y_Objetivo : Integer := 0;  
   -- Coordenadas de la aldea atacante
   X_Atacante,  
   Y_Atacante : Integer := 0;  

   Nombre_Atacante : Unbounded_String;  

   -- Variables que usamos como buffer intermedio
   Horas,  
   Minutos,  
   Segundos,  
   Dia,  
   Mes,  
   Año             : Integer;  
   Tiempo          : Time;  
   Año_Invalido    : exception;  
   Tiempo_Invalido : exception;  

   Nivel_Pt        : Integer   := 0;  
   Artefacto       : Boolean   := False;  
   Pueblo_Atacante : T_Pueblos;  
   Ej              : Ejercito;  
   Velocidad       : Integer   := 0;  

   Distancia        : Float    := 0.0;  
   Tiempo_Recorrido : Duration := 0.0;  

   Max_X,  
   Max_Y : Integer := 0;  

   procedure Poner_Datos_Nulos (
         I : Positive ) is 
   begin
      for J in 1..6 loop
         Set_Text(Envio_Atacante(I,J),"-");
      end loop;
   end Poner_Datos_Nulos;

begin

   case Version_Travian is
      when V2=>
         Max_X:=Distancia_X_V2;
         Max_Y:=Distancia_Y_V2;
      when V3=>
         Max_X:=Distancia_X_V3;
         Max_Y:=Distancia_Y_V3;
   end case;



   X_Objetivo:=Valor(To_Unbounded_String(Get_Text(Objetivo_X)));
   if X_Objetivo<-Max_X then
      X_Objetivo:=-Max_X;
      Set_Text(Objetivo_X,"-" & Quita_Espacios(Integer'Image(Max_X)));
   elsif X_Objetivo>Max_X then
      X_Objetivo:=Max_X;
      Set_Text(Objetivo_X,Quita_Espacios(Integer'Image(Max_X)));
   end if;


   Y_Objetivo:=Valor(To_Unbounded_String(Get_Text(Objetivo_Y)));
   if Y_Objetivo<-Max_Y then
      Y_Objetivo:=-Max_Y;
      Set_Text(Objetivo_Y,"-" & Quita_Espacios(Integer'Image(Max_Y)));
   elsif Y_Objetivo>Max_Y then
      Y_Objetivo:=Max_Y;
      Set_Text(Objetivo_Y,Quita_Espacios(Integer'Image(Max_Y)));
   end if;



   -- Cogemos los datos de la aldea a atacar
   for I in 1..Numero_Atacantes loop
      begin



         -- Obtenemos las coordenadas de la aldea
         X_Atacante:=Valor(To_Unbounded_String(Get_Text(
                  Informacion_Atacante(I,1))));
         if X_Atacante<-Max_X then
            X_Atacante:=-Max_X;
            Set_Text(Informacion_Atacante(I,1),"-" & Quita_Espacios(Integer'Image(Max_X)));
         elsif X_Atacante>Max_X then
            X_Atacante:=Max_X;
            Set_Text(Informacion_Atacante(I,1),Quita_Espacios(Integer'Image(Max_X)));
         end if;

         Y_Atacante:=Valor(To_Unbounded_String(Get_Text(
                  Informacion_Atacante(I,2))));
         if Y_Atacante<-Max_Y then
            Y_Atacante:=-Max_Y;
            Set_Text(Informacion_Atacante(I,2),"-" & Quita_Espacios(Integer'Image(Max_X)));
         elsif Y_Atacante>Max_Y then
            Y_Atacante:=Max_Y;
            Set_Text(Informacion_Atacante(I,2),Quita_Espacios(Integer'Image(Max_X)));
         end if;

         -- Nombre agresor
         Nombre_Atacante:=To_Unbounded_String(Get_Text(
               Informacion_Atacante(I,3)));

         -- Artefacto de velocidad y nivel de la plaza de torneos
         Artefacto:=Get_State(Artefacto_Atacante(I));
         Nivel_Pt:=Valor(To_Unbounded_String(Get_Text(
                  Informacion_Atacante(I,4))));
         if Nivel_Pt<0 then
            Nivel_Pt:=0;
            Set_Text(Informacion_Atacante(I,4),"0");
         elsif Nivel_Pt>20 then
            Nivel_Pt:=20;
            Set_Text(Informacion_Atacante(I,4),"20");
         end if;

         -- Cogemos el ejército del atacante
         if Get_State(Bando_Atacante(I,1)) then
            Pueblo_Atacante:=Romanos;
         elsif Get_State(Bando_Atacante(I,2)) then
            Pueblo_Atacante:=Germanos;
         elsif Get_State(Bando_Atacante(I,3)) then
            Pueblo_Atacante:=Galos;
         end if;

         for J in 1..10 loop
            if Get_State(Checkboxs_Tropas(I,J)) then
               Ej.Tropas(J).Cantidad:=1;
            else
               Ej.Tropas(J).Cantidad:=0;
            end if;
         end loop;
         Velocidad:=Velocidad_Ejercito(Pueblo_Atacante,Ej,Artefacto);

         Distancia:=Calcular_Distancia(X_Atacante,Y_Atacante,
            X_Objetivo,Y_Objetivo,Nivel_Pt, Version_Travian);

         if Velocidad/=0 then
            Tiempo_Recorrido:=3600*Duration(Distancia/Float(Velocidad));
         else
            Tiempo_Recorrido:=0.0;
         end if;

         -- Obtenemos la hora de llegada deseada

         Horas:=Valor(To_Unbounded_String(Get_Text(Llegada_Atacante(I,1))));
         if Horas<0 then
            Set_Text(Llegada_Atacante(I,1),"0");
            Horas:=0;
         elsif Horas>23 then
            Set_Text(Llegada_Atacante(I,1),"23");
            Horas:=23;
         end if;

         Minutos:=Valor(To_Unbounded_String(Get_Text(Llegada_Atacante(I,2))));
         if Minutos<0 then
            Set_Text(Llegada_Atacante(I,2),"0");
            Minutos:=0;
         elsif Minutos>59 then
            Set_Text(Llegada_Atacante(I,2),"59");
            Minutos:=59;
         end if;

         Segundos:=Valor(To_Unbounded_String(Get_Text(Llegada_Atacante(I,
                     3))));
         if Segundos<0 then
            Set_Text(Llegada_Atacante(I,3),"0");
            Segundos:=0;
         elsif Segundos>59 then
            Set_Text(Llegada_Atacante(I,3),"59");
            Segundos:=59;
         end if;

         Dia:=Valor(To_Unbounded_String(Get_Text(Llegada_Atacante(I,4))));
         if Dia<1 then
            Set_Text(Llegada_Atacante(I,4),"1");
            Dia:=1;
         elsif Dia>31 then
            Set_Text(Llegada_Atacante(I,4),"31");
            Dia:=31;
         end if;

         Mes:=Valor(To_Unbounded_String(Get_Text(Llegada_Atacante(I,5))));
         if Mes<1 then
            Set_Text(Llegada_Atacante(I,5),"1");
            Mes:=1;
         elsif Mes>12 then
            Set_Text(Llegada_Atacante(I,5),"12");
            Mes:=12;
         end if;
         Año:=Valor(To_Unbounded_String(Get_Text(Llegada_Atacante(I,6))));

         if Año<2006 then
            raise Año_Invalido;
         end if;
         if Año>2050 then
            Set_Text(Llegada_Atacante(I,6),"2050");
            Año:=2050;
         end if;


         Tiempo:=Time_Of(Year_Number(Año),
            Month_Number(Mes),
            Day_Number(Dia),
            Duration((Horas*60*60) + (Minutos*60) + Segundos));

         if Tiempo_Recorrido=0.0 then
            raise Tiempo_Invalido;
         end if;

         -- Obtenemos la hora de envio
         Tiempo:=Tiempo-Tiempo_Recorrido;
         Split(Tiempo,Año,Mes,Dia,Duration(Segundos));


         Horas:=Integer(Seconds(Tiempo))/3600;
         Minutos:=(Integer(Seconds(Tiempo))-(3600*Horas))/60;
         Segundos:=Integer(Seconds(Tiempo))-(3600*Horas)-(60*Minutos);


         -- Mostramos resultados
         Set_Text(Envio_Atacante(I,1),Quita_Espacios(Dos_Digitos(Horas)));
         Set_Text(Envio_Atacante(I,2),Quita_Espacios(Dos_Digitos(Minutos)));
         Set_Text(Envio_Atacante(I,3),Quita_Espacios(Dos_Digitos(Segundos)));

         Set_Text(Envio_Atacante(I,4),Quita_Espacios(Dos_Digitos(Dia)));
         Set_Text(Envio_Atacante(I,5),Quita_Espacios(Dos_Digitos(Mes)));
         Set_Text(Envio_Atacante(I,6),Quita_Espacios(Integer'Image(Año)));





      exception
         when Año_Invalido=>
            Poner_Datos_Nulos(I);
         when Tiempo_Invalido=>
            Poner_Datos_Nulos(I);
         when Ada.Calendar.Time_Error=>
            Poner_Datos_Nulos(I);
      end;
   end loop;

end Realizar_Calculos;