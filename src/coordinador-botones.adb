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


separate(Coordinador)

procedure Botones (
      X : Positive ) is 

   Dia_Extra : constant Duration := 86400.0;  

   procedure Hoy_Ahora is 
      Horas,  
      Minutos,  
      Segundos : Integer;  
   begin
      Horas:=Integer(Seconds(Clock))/3600;
      Minutos:=(Integer(Seconds(Clock))-(3600*Horas))/60;
      Segundos:=Integer(Seconds(Clock))-(3600*Horas)-(60*Minutos);
      Set_Text(Llegada_Atacante(1,1),Quita_Espacios(Dos_Digitos(Horas)));
      Set_Text(Llegada_Atacante(1,2),Quita_Espacios(Dos_Digitos(Minutos)));
      Set_Text(Llegada_Atacante(1,3),Quita_Espacios(Dos_Digitos(Segundos)));

      Set_Text(Llegada_Atacante(1,4),Quita_Espacios(Dos_Digitos(Day(
                  Clock))));
      Set_Text(Llegada_Atacante(1,5),Quita_Espacios(Dos_Digitos(Month(
                  Clock))));
      Set_Text(Llegada_Atacante(1,6),Quita_Espacios(Dos_Digitos(Year(
                  Clock))));
   end Hoy_Ahora;



   procedure Mañana_4madrugada is 

   begin

      Set_Text(Llegada_Atacante(1,1),Quita_Espacios(Dos_Digitos(4)));
      Set_Text(Llegada_Atacante(1,2),Quita_Espacios(Dos_Digitos(0)));
      Set_Text(Llegada_Atacante(1,3),Quita_Espacios(Dos_Digitos(0)));

      Set_Text(Llegada_Atacante(1,4),Quita_Espacios(Dos_Digitos(Day(
                  Clock+Dia_Extra))));
      Set_Text(Llegada_Atacante(1,5),Quita_Espacios(Dos_Digitos(Month(
                  Clock+Dia_Extra))));
      Set_Text(Llegada_Atacante(1,6),Quita_Espacios(Integer'Image(Year(
                  Clock+Dia_Extra))));
   end Mañana_4madrugada;


   procedure Copiar_Horario_De_1 is 
   begin
      for I in 2..Numero_Atacantes loop
         for J in 1..6 loop
            Set_Text(Llegada_Atacante(I,J),Get_Text(Llegada_Atacante(1,J)));
         end loop;
      end loop;
   end  Copiar_Horario_De_1;

   procedure Copiar_Coordenadas is 
   begin
      for I in 2..Numero_Atacantes loop
         Set_State(Artefacto_Atacante(I),Get_State(Artefacto_Atacante(1)));
         for J in 1..4 loop
            if J/=3 then
               Set_Text(Informacion_Atacante(I,J),Get_Text(
                     Informacion_Atacante(1,J)));
            end if;
         end loop;
      end loop;
   end  Copiar_Coordenadas ;


   procedure Limpiar_Llegada is 

   begin
      Set_Text(Llegada_Atacante(1,1),Quita_Espacios(Dos_Digitos(0)));
      Set_Text(Llegada_Atacante(1,2),Quita_Espacios(Dos_Digitos(0)));
      Set_Text(Llegada_Atacante(1,3),Quita_Espacios(Dos_Digitos(0)));

      Set_Text(Llegada_Atacante(1,4),Quita_Espacios(Dos_Digitos(Day(Clock))));
      Set_Text(Llegada_Atacante(1,5),Quita_Espacios(Dos_Digitos(Month(
                  Clock))));
      Set_Text(Llegada_Atacante(1,6),Quita_Espacios(Integer'Image(Year(
                  Clock))));
      Copiar_Horario_De_1;
   end Limpiar_Llegada;


   procedure Limpiar_Aldeas is 
   begin
      for I in 1.. Numero_Atacantes loop
         Set_Text(Informacion_Atacante(I,1),"");
         Set_Text(Informacion_Atacante(I,2),"");
         Set_Text(Informacion_Atacante(I,3),Nom_Agresor & " " & Integer'
            Image(I));
         Set_Text(Informacion_Atacante(I,4),"");
         Set_State(Artefacto_Atacante(I),False);
      end loop;
   end Limpiar_Aldeas;

   procedure Limpiar_Tropas is 
   begin
      for I in 1.. Numero_Atacantes loop
         Set_State(Bando_Atacante(I,1),True);
         Set_State(Bando_Atacante(I,2),False);
         Set_State(Bando_Atacante(I,3),False);
         for J in 1..10 loop
            Set_State(Checkboxs_Tropas(I,J),False);
         end loop;
      end loop;
   end Limpiar_Tropas;

   procedure Limpiar_Objetivo is 
   begin

      Set_Text(Objetivo_X,"0");
      Set_Text(Objetivo_Y,"0");

   end Limpiar_Objetivo;

begin

   case X is
      when 1=>
         Hoy_Ahora;
      when 2=>
         Mañana_4madrugada;

      when 5=>
         Copiar_Horario_De_1;
      when 6=>
         Copiar_Coordenadas;

      when 10=>
         Limpiar_Aldeas;
      when 11=>
         Limpiar_Llegada;
      when 12=>
         Limpiar_Tropas;
      when 13=>
         Limpiar_Tropas;
         Limpiar_Llegada;
         Limpiar_Aldeas;
         Limpiar_Objetivo;

      when others=>
         null;
   end case;

end Botones;