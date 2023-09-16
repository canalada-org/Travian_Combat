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
with Formulas,Ada.Strings.Unbounded,Ada.Calendar;
use Formulas,Ada.Strings.Unbounded,Ada.Calendar;



separate(Calculadora)

procedure Recursos is 

   type V_Enteros is array (Positive range <>) of Integer; 

   Recursos   : V_Enteros (1 .. 12);  
   Tiempos    : V_Enteros (1 .. 4);       -- Tiempo en segundos                            
   Tiempo_Max : Integer;  
   Horas,  
   Minutos,  
   Segundos   : Natural             := 0;  

   Imposible : Boolean := False;  

   Hora_Construccion : Time;  
   -- Devuelve el maximo
   function Max (
         V : V_Enteros ) 
     return Integer is 
      M : Integer := Integer'First;  
   begin
      for I in V'range loop
         if V(I)>M then
            M:=V(I);
         end if;
      end loop;
      return M;
   end Max;


begin



      -- Coger datos 
      for I in 1..3 loop
         Recursos(((I-1)*4)+1):=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(I).Madera)));
         Recursos(((I-1)*4)+2):=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(I).Barro)));
         Recursos(((I-1)*4)+3):=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(I).Hierro)));
         Recursos(((I-1)*4)+4):=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(I).Cereal)));
      end loop;

      Imposible:=False;

      -- Calculamos el tiempo que tardaremos en llegar
      for I in 1..4 loop
         if Recursos(8+I)>0 then
            begin
               Tiempos(I):=Integer(Float(Recursos(4+I)-Recursos(I))*3600.0/Float(Recursos(8+I)));
            exception
               when others=>
                  Tiempos(I):=Integer'Last;
            end;
            if Tiempos(I)<0 then
               Tiempos(I):=0;
            end if;
         elsif Recursos(4+I)<=Recursos(I) then
            Tiempos(I):=0;
         else
            Imposible:=True;
         end if;
      end loop;

      Tiempo_Max:=Max(Tiempos);

      -- Ponemos el tiempo restante
      if Tiempo_Max>0 and not Imposible and Tiempo_Max/=Integer'Last then
         Horas:=Tiempo_Max/3600;
         Minutos:=(Tiempo_Max-(3600*Horas))/60;
         Segundos:=Tiempo_Max-(3600*Horas)-(60*Minutos);
         Set_Text(Etiqueta_Fin,Texto_Construccion_Posible & Quita_Espacios(Natural'Image(Horas)) & " : " &
            Quita_Espacios(Dos_Digitos(Minutos)) & " : " & Quita_Espacios(Dos_Digitos(Segundos)));

      elsif not Imposible and Tiempo_Max/=Integer'Last then
         Set_Text(Etiqueta_Fin,Texto_Construccion_Posible & "0:00:00");
      else
         Set_Text(Etiqueta_Fin,Texto_Construccion_Imposible);
      end if;



      -- Ponemos el dia cuando podremos empezar a construir
      Hora_Construccion:=Clock+Duration(Tiempo_Max);
      if Tiempo_Max>0 and not Imposible and Tiempo_Max/=Integer'Last then

         Horas:=Integer(Seconds(Hora_Construccion))/3600;
         Minutos:=(Integer(Seconds(Hora_Construccion))-(3600*Horas))/60;
         Segundos:=Integer(Seconds(Hora_Construccion))-(3600*Horas)-(60*Minutos);

         -- Hoy
         if Day (Hora_Construccion)=Day(Clock) and Month(Hora_Construccion)=Month(Clock) and Year(Hora_Construccion)=Year(Clock) then
            Set_Text(Etiqueta_Fin_Exacto,
               Texto_Construccion_Hoy
               & "  "
               & Quita_Espacios(Natural'Image(Horas))
               & " : "
               & Quita_Espacios(Dos_Digitos(Minutos))
               & " : "
               & Quita_Espacios(Dos_Digitos(Segundos)))
               ;
         else
            -- Otro dia
            Set_Text(Etiqueta_Fin_Exacto,
               Integer'Image(Day (Hora_Construccion))
               & " / "
               & To_String(Calendario(Month(Hora_Construccion)))
               & " / "
               & Quita_Espacios(Integer'Image(Year(Hora_Construccion)))
               & "  "
               & Quita_Espacios(Natural'Image(Horas))
               & " : "
               & Quita_Espacios(Dos_Digitos(Minutos))
               & " : "
               & Quita_Espacios(Dos_Digitos(Segundos)))
               ;
         end if;
      elsif not Imposible and Tiempo_Max/=Integer'Last then
         Set_Text(Etiqueta_Fin_Exacto,Texto_Construccion_Ahora);
      else
         Set_Text(Etiqueta_Fin_Exacto,"");
      end if;


      -- Ponemos los recursos sobrantes
      for I in 1..4 loop
         if I=1 then
            Set_Text(Boxes_Recursos(4).Madera,Integer'Image(Integer((Float(Tiempo_Max)/3600.0)*float(Recursos(8+I)))-(Recursos(4+I)-Recursos(I))));
         elsif I=2 then
            Set_Text(Boxes_Recursos(4).Barro,Integer'Image(Integer((Float(Tiempo_Max)/3600.0)*float(Recursos(8+I)))-(Recursos(4+I)-Recursos(I))));
         elsif I=3 then
            Set_Text(Boxes_Recursos(4).Hierro,Integer'Image(Integer((Float(Tiempo_Max)/3600.0)*float(Recursos(8+I)))-(Recursos(4+I)-Recursos(I))));
         else
            Set_Text(Boxes_Recursos(4).Cereal,Integer'Image(Integer((Float(Tiempo_Max)/3600.0)*float(Recursos(8+I)))-(Recursos(4+I)-Recursos(I))));
         end if;

      end loop;

      delay(0.1);


end Recursos ;