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

with Traduccion, Traduccion_Coordinador;
use Traduccion, Traduccion_Coordinador;

with Ada.Text_Io;
use Ada.Text_Io;


with Formulas, Ada.Strings.Unbounded;
use Formulas, Ada.Strings.Unbounded;

with Bbcode_Html;
use Bbcode_Html;

separate(Coordinador)

procedure Realizar_Informe (
      Añadir : Boolean ) is 

   F : File_Type;  

   Bando            : Natural;  
   Numero_De_Tropas : Natural := 0;  

begin

   Tipo_De_Informe (Hacer_Informe );


   -- Abrir fichero
   if not Añadir then
      if Hacer_Informe=2 then
         Create(F,Out_File,Ruta_Informe_Bbcode_Coordinador);
      elsif Hacer_Informe=3 then
         Create(F,Out_File,Ruta_Informe_Html_Coordinador);
      else
         Create(F,Out_File,Ruta_Informe_Coordinador);
      end if;
      Negrita(F);
      Put(F,-"Coordination report created with");
      Link(F, "Link_Tc");
      Color(F, Bbcode_Html.Red);
      Put(F, Nombre_Coordinador);
      Fin_Color(F);
      Fin_Link(F);
      Fin_Negrita(F);

      Salto_Linea(F);

   else
      if Hacer_Informe=2 then
         Open(F,Append_File,Ruta_Informe_Bbcode_Coordinador);
      elsif Hacer_Informe=3 then
         Open(F,Append_File,Ruta_Informe_Html_Coordinador);
      else
         Open(F,Append_File,Ruta_Informe_Coordinador);
      end if;
   end if;




   for I in 1..Numero_Atacantes loop
      Salto_Linea(F);
      Salto_Linea(F);
      -- Nombre del atacante y coordenadas
      Negrita(F);
      Color(F,Bbcode_Html.Blue);
      Put(F, Get_Text(Informacion_Atacante(I,3)));
      Fin_Color(F);
      Fin_Negrita(F);
      Put(F," - (");
      Negrita(F);
      Color(F,Bbcode_Html.Green);
      Put(F, Quita_Espacios(Integer'Image(Valor(To_Unbounded_String(
                     Get_Text(Informacion_Atacante(I,1)))))));
      Fin_Color(F);
      Fin_Negrita(F);
      Put(F,",");
      Negrita(F);
      Color(F,Bbcode_Html.Green);
      Put(F, Integer'Image(Valor(To_Unbounded_String(Get_Text(
                     Informacion_Atacante(I,2))))));
      Fin_Color(F);
      Fin_Negrita(F);
      Put(F,")");
      Salto_Linea(F);


      -- Coordenadas del objetivo
      Put(F, -"Target: (");
      Negrita(F);
      Color(F,Bbcode_Html.Red);
      Put(F,
         Quita_Espacios(Integer'Image(Valor(To_Unbounded_String(Get_Text(
                        Objetivo_X))))));
      Fin_Color(F);
      Fin_Negrita(F);
      Put(F, ",");
      Negrita(F);
      Color(F,Bbcode_Html.Red);
      Put(F,Integer'Image(Valor(To_Unbounded_String(Get_Text(Objetivo_Y)))));
      Fin_Color(F);
      Fin_Negrita(F);
      Put(F, ")");
      Salto_Linea(F);

      -- Tropas
      if Get_State(Bando_Atacante(I,1)) then
         Bando:=1;
      elsif Get_State(Bando_Atacante(I,2)) then
         Bando:=2;
      else
         Bando:=3;
      end if;
      Put(F,-"Troops: ");
      Numero_De_Tropas:=0;
      for J in 1..10 loop
         if Get_State(Checkboxs_Tropas(I,J)) then
            Numero_De_Tropas:=Numero_De_Tropas+1;
            if Bando=1 then
               if Numero_De_Tropas/=1 and Hacer_Informe=1 then
                  Put(F, ", ");
               end if;
               if Hacer_Informe/=1 then
                  Salto_Linea(F);
                  Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(J)));
                  Put(F, " ");
               end if;
               Put(F,To_String(Ejercito_Romano(J)));
            elsif Bando=2 then
               if Numero_De_Tropas/=1 and Hacer_Informe=1 then
                  Put(F, ", ");
               end if;
               if Hacer_Informe/=1 then
                  Salto_Linea(F);
                  Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(J+10)));
                  Put(F, " ");
               end if;
               Put(F,To_String(Ejercito_Germano(J)));
            elsif Bando=3 then
               if Numero_De_Tropas/=1 and Hacer_Informe=1 then
                  Put(F, ", ");
               end if;
               if Hacer_Informe/=1 then
                  Salto_Linea(F);
                  Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(J+20)));
                  Put(F, " ");
               end if;
               Put(F,To_String(Ejercito_Galo(J)));
            end if;
         end if;
      end loop;
      Salto_Linea(F);

      -- Pz torneos y artefacto
      Put(F, -"Square Tournament at level ");
      Negrita(F);
      Put(F, Integer'Image(Valor(
               To_Unbounded_String(Get_Text(Informacion_Atacante(I,4))))));
      Fin_Negrita(F);

      if Get_State(Artefacto_Atacante(I)) then
         Negrita(F);
         Put(F,-"; Speed Artifact");
         Fin_Negrita(F);
      end if;
      Salto_Linea(F);

      -- Horario
      Put(F, -"Departure time:   ");
      Negrita(F);
      Color(F,Bbcode_Html.Blue);
      Put(F,Get_Text(Envio_Atacante(I,1)) & ":" & Get_Text(Envio_Atacante(
               I,2)) & ":" &Get_Text(Envio_Atacante(I,3))
         & "  " & Get_Text(Envio_Atacante(I,4)) & "/" & Get_Text(
            Envio_Atacante(I,5)) & "/" & Get_Text(Envio_Atacante(I,6))
         );
      Fin_Color(F);
      Fin_Negrita(F);
      Salto_Linea(F);

      Put(F, -"Arrival time:     ");
      Color(F,Bbcode_Html.Green);
      Put(F,Get_Text(Llegada_Atacante(I,1)) & ":" & Get_Text(
            Llegada_Atacante(I,2)) & ":" &Get_Text(Llegada_Atacante(I,3))
         & "  " & Get_Text(Llegada_Atacante(I,4)) & "/" & Get_Text(
            Llegada_Atacante(I,5)) & "/" & Get_Text(Llegada_Atacante(I,6))
         );
      Fin_Color(F);
      Salto_Linea(F);
   end loop;


   Close(F);
   if Añadir then

      if Hacer_Informe=2 then
         Show_Message(-"Report correctly added to: " &
            Ruta_Informe_Bbcode_Coordinador,-"Confirmation");
      elsif Hacer_Informe=3 then
         Show_Message(-"Report correctly added to: " &
            Ruta_Informe_Html_Coordinador,-"Confirmation");
      else
         Show_Message(-"Report correctly added to: " &
            Ruta_Informe_Coordinador,-"Confirmation");
      end if;

   else

      if Hacer_Informe=2 then
         Show_Message(-"Report correctly created in: " &
            Ruta_Informe_Bbcode_Coordinador,-"Confirmation");
      elsif Hacer_Informe=3 then
         Show_Message(-"Report correctly created in: " &
            Ruta_Informe_Html_Coordinador,-"Confirmation");
      else
         Show_Message(-"Report correctly created in: " &
            Ruta_Informe_Coordinador,-"Confirmation");
      end if;

   end if;
   Hacer_Informe:=0;

exception
   when others=>
      Show_Error(-"Error creating report",-"Error");


end Realizar_Informe;