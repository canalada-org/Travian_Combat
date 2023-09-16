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
with Ada.Text_Io;
use Ada.Text_Io;


with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Bbcode_Html;
use Bbcode_Html;

with Formulas;

separate(Simulador.Realizar_Calculos)

procedure Informe is 

   F                        : File_Type;  
   Muertos_Agresor,  
   Muertos_Defensor_Romano,  
   Muertos_Defensor_Galo,  
   Muertos_Defensor_Germano,  
   Muertos_Totales          : Natural   := 0;  

begin

   Tipo_De_Informe (Hacer_Informe );

   if Hacer_Informe=2 then
      Create(F,Out_File,Ruta_Informe_Bbcode);
   elsif Hacer_Informe=3 then
      Create(F,Out_File,Ruta_Informe_Html);
   else
      Create(F,Out_File,Ruta_Informe);
   end if;

   Negrita(F);
   Put(F,-"Battle simulation created with ");
   Link(F, "Link_Tc");
   Color(F, Bbcode_Html.Red);
   Put(F, Nombre_Simulador);
   Fin_Color(F);
   Fin_Link(F);
   Fin_Negrita(F);

   Salto_Linea(F);
   Salto_Linea(F);
   Salto_Linea(F);
   Negrita(F);
   Put(F,-"Agressor: ");
   Fin_Negrita(F);
   Cursiva(F);
   case Pueblo is
      when Romanos =>
         Put(F,Nom_Romanos);
      when Galos=>
         Put(F,Nom_Galos);
      when Germanos=>
         Put(F,Nom_Germanos);
   end case;
   Fin_Cursiva(F);
   Salto_Linea(F);
   Put(F,-"Coordinates - X:");
   Cursiva(F);
   Color(F,Bbcode_Html.Blue);
   Put(F, Integer'Image(
         Coordenadas.Agresor_X));
   Fin_Color(F);
   Fin_Cursiva(F);
   Put(F, " Y:");
   Cursiva(F);
   Color(F,Bbcode_Html.Blue);
   Put(F, Integer'Image(Coordenadas.Agresor_Y));
   Fin_Color(F);
   Fin_Cursiva(F);
   Salto_Linea(F);
   if not Naturaleza then
      Put(F,-"Population: ");
      Cursiva(F);
      Put(F,Integer'Image(Habitantes_Agresor));
      Fin_Cursiva(F);
      Salto_Linea(F);
   end if;

   Put(F, Nom_Pt & ": ");
   Cursiva(F);
   Put(F,Integer'Image(Valor(To_Unbounded_String(Get_Text(Edit_Pt)))));
   Fin_Cursiva(F);
   Salto_Linea(F);
   if Get_Text(Edit_Tiempo_Llegada)="" then
      Put(F,-"Arrival time: -");
      Salto_Linea(F);
   else
      Put(F,-"Arrival time: ");
      Cursiva(F);
      Put(F, Get_Text(
            Edit_Tiempo_Llegada));
      Fin_Cursiva(F);
      Salto_Linea(F);
   end if;

   Put(F, -"Type of attack: ");
   Cursiva(F);
   if Atraco then
      Put(F, Nom_Atraco);
      Salto_Linea(F);
   else
      Put(F, Nom_Normal);
      Salto_Linea(F);
   end if;
   Fin_Cursiva(F);
   Salto_Linea(F);

   if Cantidad_Tropas.Atacante=0 then
      Put(F,-"No troops" );
      Salto_Linea(F);
   else
      for I in 1..10 loop
         if Atacante.Tropas(I).Cantidad>0 then
            case Pueblo is
               when Romanos=>
                  Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I)));
                  Put(F, " ");
                  Put(F,To_String(Ejercito_Romano(I)));
               when Galos=>
                  Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I+20)));
                  Put(F, " ");
                  Put(F,To_String(Ejercito_Galo(I)));
               when Germanos=>
                  Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I+10)));
                  Put(F, " ");
                  Put(F,To_String(Ejercito_Germano(I)));
            end case;
            Put(F, -": ");
            Negrita(F);
            Color(F,Bbcode_Html.Green);
            Put(F, Integer'Image(Atacante.Tropas(I).
                  Cantidad));
            Fin_Color(F);
            Fin_Negrita(F);
            Put(F, (-"  Level: "));
            Put(F,Integer'Image(Atacante.Tropas(I).
                  Nivel)
               & (-" Losses: "));
            Negrita(F);
            Color(F,Bbcode_Html.Red);
            Put(F,Integer'Image(
                  Res_Atacante.Tropas(I).Cantidad));
            Fin_Color(F);
            Fin_Negrita(F);
            Muertos_Agresor:=Muertos_Agresor+Res_Atacante.Tropas(
               I).Cantidad;
            Salto_Linea(F);
         end if;
      end loop;
   end if;
   Salto_Linea(F);
   Imagen(F,"Consumo_Cereal_Atacante");
   Put(F, " ");
   Put(F, -"Attacker crop consumption");
   Put(F, -": ");
   Negrita(F);
   Put(F,Natural'Image(Valor(To_Unbounded_String(Get_Text( Consumo_Atacante)))));
   Fin_Negrita(F);
   Salto_Linea(F);
   Salto_Linea(F);

   -- Defensor
   Salto_Linea(F);
   Salto_Linea(F);
   Negrita(F);
   Put(F,-"Defender");
   Fin_Negrita(F);
   Salto_Linea(F);

   Put(F,-"Coordinates - X:");
   Cursiva(F);
   Color(F,Bbcode_Html.Blue);
   Put(F, Integer'Image(
         Coordenadas.Defensor_X));
   Fin_Color(F);
   Fin_Cursiva(F);
   Put(F, " Y:");
   Cursiva(F);
   Color(F,Bbcode_Html.Blue);
   Put(F, Integer'Image(Coordenadas.Defensor_Y));
   Fin_Color(F);
   Fin_Cursiva(F);
   Salto_Linea(F);


   if not Naturaleza then
      Put(F,-"Population: ");
      Cursiva(F);
      Put(F,Integer'Image(Habitantes_Agredido));
      Fin_Cursiva(F);
      Salto_Linea(F);
      Put(F,-"Palace: ");
      Cursiva(F);
      Negrita(F);
      Put(F,Integer'Image(Nivel_Palacio));
      Fin_Negrita(F);
      Fin_Cursiva(F);
      Salto_Linea(F);
      if   Defensor_Romano.Muralla>0 then
         Put(F,-"Wall: ");
         Cursiva(F);
         Negrita(F);
         Put(F,Integer'Image(Defensor_Romano.Muralla));
      elsif  Defensor_Galo.Muralla>0 then
         Put(F,-"Wall: ");
         Cursiva(F);
         Negrita(F);
         Put(F,Integer'Image(Defensor_Galo.Muralla));
      else
         Put(F,-"Wall: ");
         Cursiva(F);
         Negrita(F);
         Put(F,Integer'Image(Defensor_Germano.Muralla));
      end if;
      Fin_Negrita(F);
      Fin_Cursiva(F);
      Salto_Linea(F);
   end if;


   -- Romanos
   if not Naturaleza then
      Salto_Linea(F);
      Subrayado(F);
      Put(F,-"Roman reinforcement");
      Fin_Subrayado(F);
      Salto_Linea(F);
      if Cantidad_Tropas.Defensor_Romano=0 then
         Put(F,-"No troops" );
         Salto_Linea(F);
      else
         for I in 1..10 loop
            if Defensor_Romano.Tropas(I).Cantidad>0 then
               Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I)));
               Put(F, " ");
               Put(F,To_String(Ejercito_Romano(I)));
               Put(F, -": ");
               Negrita(F);
               Color(F,Bbcode_Html.Green);
               Put(F, Integer'Image(Defensor_Romano.Tropas(I).
                     Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);
               Put(F, (-"  Level: "));
               Put(F,Integer'Image(Defensor_Romano.Tropas(I).
                     Nivel)
                  & (-" Losses: "));
               Negrita(F);
               Color(F,Bbcode_Html.Red);
               Put(F,Integer'Image(
                     Res_Defensor_Romano.Tropas(I).Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);

               Muertos_Defensor_Romano:=Muertos_Defensor_Romano+
                  Res_Defensor_Romano.Tropas(I).Cantidad;
               Salto_Linea(F);
            end if;
         end loop;
      end if;


      -- Germanos
      Salto_Linea(F);
      Subrayado(F);
      Put(F,-"Teuton reinforcement");
      Fin_Subrayado(F);
      Salto_Linea(F);
      if Cantidad_Tropas.Defensor_Germano=0 then
         Put(F,-"No troops" );
         Salto_Linea(F);
      else
         for I in 1..10 loop
            if Defensor_Germano.Tropas(I).Cantidad>0 then
               Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I+10)));
               Put(F, " ");
               Put(F,To_String(Ejercito_Germano(I)));
               Put(F, -": ");
               Negrita(F);
               Color(F,Bbcode_Html.Green);
               Put(F, Integer'Image(Defensor_Germano.Tropas(I).
                     Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);
               Put(F, (-"  Level: "));
               Put(F,Integer'Image(Defensor_Germano.Tropas(I).
                     Nivel)
                  & (-" Losses: "));
               Negrita(F);
               Color(F,Bbcode_Html.Red);
               Put(F,Integer'Image(
                     Res_Defensor_Germano.Tropas(I).Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);
               Muertos_Defensor_Germano:=Muertos_Defensor_Germano+
                  Res_Defensor_Germano.Tropas(I).Cantidad;
               Salto_Linea(F);
            end if;
         end loop;
      end if;


      -- Galos
      Salto_Linea(F);
      Subrayado(F);
      Put(F,-"Galic reinforcement");
      Fin_Subrayado(F);
      Salto_Linea(F);
      if Cantidad_Tropas.Defensor_Galo=0 then
         Put(F,-"No troops" );
         Salto_Linea(F);
         Salto_Linea(F);         
      else
         for I in 1..10 loop
            if Defensor_Galo.Tropas(I).Cantidad>0 then
               Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I+20)));
               Put(F, " ");
               Put(F,To_String(Ejercito_Galo(I)));
               Put(F, -": ");
               Negrita(F);
               Color(F,Bbcode_Html.Green);
               Put(F, Integer'Image(Defensor_Galo.Tropas(I).
                     Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);
               Put(F, (-"  Level: "));
               Put(F,Integer'Image(Defensor_Galo.Tropas(I).
                     Nivel)
                  & (-" Losses: "));
               Negrita(F);
               Color(F,Bbcode_Html.Red);
               Put(F,Integer'Image(
                     Res_Defensor_Galo.Tropas(I).Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);

               Muertos_Defensor_Galo:=Muertos_Defensor_Galo+
                  Res_Defensor_Galo.Tropas(I).Cantidad;
               Salto_Linea(F);
            end if;
         end loop;
         Salto_Linea(F);
      end if;

      Imagen(F,"Consumo_Cereal_Defensor");
      Put(F, " ");
      Put(F, -"Defender crop consumption");
      Put(F, -": ");
      Negrita(F);
      Put(F,Natural'Image(Valor(To_Unbounded_String(Get_Text( Consumo_Defensor)))));
      Fin_Negrita(F);
      Salto_Linea(F);
      Salto_Linea(F);
   end if;




   -- Naturaleza
   if Naturaleza then
      Salto_Linea(F);
      Subrayado(F);
      Put(F,-"Wild animals guarding the oases");
      Fin_Subrayado(F);
      Salto_Linea(F);
      if Cantidad_Tropas.Defensor_Romano=0 then
         Put(F,-"No animals" );
         Salto_Linea(F);
      else
         for I in 1..10 loop
            if Defensor_Romano.Tropas(I).Cantidad>0 then
               Imagen(F,"Icono_" & Formulas.Quita_Espacios(Integer'Image(I+30)));
               Put(F, " ");
               Put(F,To_String(Animalicos(I)));
               Put(F, -": ");
               Negrita(F);
               Color(F,Bbcode_Html.Green);
               Put(F, Integer'Image(Defensor_Romano.Tropas(I).
                     Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);
               Put(F, (-" Losses: "));
               Negrita(F);
               Color(F,Bbcode_Html.Red);
               Put(F,Integer'Image(
                     Res_Defensor_Romano.Tropas(I).Cantidad));
               Fin_Color(F);
               Fin_Negrita(F);
               Muertos_Defensor_Romano:=Muertos_Defensor_Romano+
                  Res_Defensor_Romano.Tropas(I).Cantidad;
               Salto_Linea(F);
            end if;
         end loop;
         Salto_Linea(F);
      end if;

   end if;



   -- Resumen de pérdidas
   Salto_Linea(F);
   Put(F,-"Agressor troops dead: ");
   Cursiva(F);
   Put(F, Natural'Image(Muertos_Agresor));
   Fin_Cursiva(F);
   Salto_Linea(F);
   Put(F,-"Material lost by agressor: ");
   Cursiva(F);
   Put(F,Natural'Image(
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Madera)))+
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Barro)))+
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Hierro)))+
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Cereal)))
         ));
   Fin_Cursiva(F);
   Salto_Linea(F);

   if Hacer_Informe=1 then
      Put(F,-"Wood: ");
   else
      Imagen(F, "Icono_Madera");
      Put(F, " ");
   end if;
   Put(F,Natural'Image(
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Madera)))
         ));
   if Hacer_Informe=1 then
      Salto_Linea(F);
   else
      Put(F, " ");
   end if;

   if Hacer_Informe=1 then
      Put(F,-"Clay: ");
   else
      Imagen(F, "Icono_Barro");
      Put(F, " ");
   end if;
   Put(F,Natural'Image(
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Barro)))
         ));
   if Hacer_Informe=1 then
      Salto_Linea(F);
   else
      Put(F, " ");
   end if;

   if Hacer_Informe=1 then
      Put(F,-"Iron: ");
   else
      Imagen(F, "Icono_Hierro");
      Put(F, " ");
   end if;
   Put(F,Natural'Image(
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Hierro)))
         ));
   if Hacer_Informe=1 then
      Salto_Linea(F);
   else
      Put(F, " ");
   end if;

   if Hacer_Informe=1 then
      Put(F,-"Crop: ");
   else
      Imagen(F, "Icono_Grano");
      Put(F, " ");
   end if;
   Put(F,Natural'Image(
         Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                     1).Cereal)))
         ));
   if Hacer_Informe=1 then
      Salto_Linea(F);
   else
      Salto_Linea(F);
      Put(F, " ");
   end if;


   if not Naturaleza then
      Salto_Linea(F);
      Put(F,-"Roman defender troops dead: ");
      Cursiva(F);
      Put(F, Natural'Image(Muertos_Defensor_Romano));
      Fin_Cursiva(F);
      Salto_Linea(F);
      Put(F,-"Material lost by Roman reinforcement: ");
      Cursiva(F);

      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Cereal)))
            ));
      Fin_Cursiva(F);
      Salto_Linea(F);

      if Hacer_Informe=1 then
         Put(F,-"Wood: ");
      else
         Imagen(F, "Icono_Madera");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Madera)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Clay: ");
      else
         Imagen(F, "Icono_Barro");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Barro)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Iron: ");
      else
         Imagen(F, "Icono_Hierro");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Hierro)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Crop: ");
      else
         Imagen(F, "Icono_Grano");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Cereal)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Salto_Linea(F);
         Put(F, " ");
      end if;


      Salto_Linea(F);
      Put(F,-"Teuton defender troops dead: ");
      Cursiva(F);
      Put(F, Natural'Image(Muertos_Defensor_Germano));
      Fin_Cursiva(F);
      Salto_Linea(F);
      Put(F,-"Material lost by Teuton reinforcement: ");
      Cursiva(F);

      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Cereal)))
            ));
      Fin_Cursiva(F);
      Salto_Linea(F);

      if Hacer_Informe=1 then
         Put(F,-"Wood: ");
      else
         Imagen(F, "Icono_Madera");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Madera)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Clay: ");
      else
         Imagen(F, "Icono_Barro");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Barro)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Iron: ");
      else
         Imagen(F, "Icono_Hierro");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Hierro)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Crop: ");
      else
         Imagen(F, "Icono_Grano");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Cereal)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Salto_Linea(F);
         Put(F, " ");
      end if;




      Salto_Linea(F);
      Put(F,-"Galic defender troops dead: ");
      Cursiva(F);
      Put(F, Natural'Image(Muertos_Defensor_Galo));
      Fin_Cursiva(F);
      Salto_Linea(F);
      Put(F,-"Material lost by Galic reinforcement: ");
      Cursiva(F);

      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Cereal)))
            ));
      Fin_Cursiva(F);
      Salto_Linea(F);

      if Hacer_Informe=1 then
         Put(F,-"Wood: ");
      else
         Imagen(F, "Icono_Madera");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Madera)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Clay: ");
      else
         Imagen(F, "Icono_Barro");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Barro)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Iron: ");
      else
         Imagen(F, "Icono_Hierro");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Hierro)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Put(F, " ");
      end if;

      if Hacer_Informe=1 then
         Put(F,-"Crop: ");
      else
         Imagen(F, "Icono_Grano");
         Put(F, " ");
      end if;
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Cereal)))
            ));
      if Hacer_Informe=1 then
         Salto_Linea(F);
      else
         Salto_Linea(F);
         Put(F, " ");
      end if;


      Salto_Linea(F);
      Put(F,-"Defender troops dead: ");
      Cursiva(F);
      Put(F,Natural'Image(
            Muertos_Defensor_Germano+Muertos_Defensor_Galo+
            Muertos_Defensor_Romano));
      Fin_Cursiva(F);
      Salto_Linea(F);


      Put(F,-"Material lost by defenders: ");
      Cursiva(F);
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Cereal)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Cereal)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Cereal)))
            ));
      Fin_Cursiva(F);
      Salto_Linea(F);
      Salto_Linea(F);

   else
      Salto_Linea(F);
      Put(F,-"Poor baby animals cruelly killed: ");
      Cursiva(F);
      Put(F,Natural'
         Image(Muertos_Defensor_Romano));
      Fin_Cursiva(F);
      Salto_Linea(F);

   end if;



   Muertos_Totales:=Muertos_Defensor_Germano+
      Muertos_Defensor_Galo+Muertos_Defensor_Romano+
      Muertos_Agresor;

   if not Naturaleza then
      Put(F,-"Soldiers killed in  ");
   else
      Put(F,-"Soldiers and animals killed in ");
   end if;
   Negrita(F);
   if Muertos_Totales <25 then
      Put(F,-"this miserable battle");
   elsif Muertos_Totales <75 then
      Put(F,-"this joking battle");
   elsif Muertos_Totales <250 then
      Put(F,-"this little battle");
   elsif Muertos_Totales <750 then
      Put(F,-"this great battle");
   elsif Muertos_Totales <1250 then
      Put(F,-"this bloody battle ");
   elsif Muertos_Totales <2000 then
      Put(F,-"this bloody, vile and cruel battle");
   elsif Muertos_Totales <3000 then
      Put(F,
         -"this battle made by selfish and vain reasons");
   elsif Muertos_Totales <5000 then
      Put(F,
         -"this slaugther");
   elsif Muertos_Totales <7500 then
      Put(F,
         -"this battle that has left thousands of destroyed families");
   elsif Muertos_Totales <10000 then
      Put(F,
         -"this shameful day in the human history, where thousands of men killed each other for the selfish desires of a few mad governors");
   else
      Put(F,
         -"the greatest battle that Travian villagers remember");
   end if;
   Fin_Negrita(F);
   Put(F,": ");
   Cursiva(F);
   Put(F,Natural'Image(Muertos_Totales));
   Fin_Cursiva(F);
   Salto_Linea(F);

   if not Naturaleza then

      Put(F,
         -"Material lost by both agressor and defender: ");
      Cursiva(F);
      Put(F,Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(1).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(1).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(1).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(1).
                     Cereal)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(2).
                     Cereal)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(3).
                     Cereal)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(4).
                     Cereal)))
            ));
      Fin_Cursiva(F);
      Salto_Linea(F);
   else
      Salto_Linea(F);
      Tamaño(F,1);
      Negrita(F);
      Put(F,-"Note" );
      Fin_Negrita(F);
      Put(F,-": In the making of this report, no kitten was harmed.");
      Fin_Tamaño(F);
      Salto_Linea(F);
   end if;

   Close(F);

   if Hacer_Informe=2 then
      Show_Message(-"Report correctly created in " &
         Ruta_Informe_Bbcode,-"Confirmation");
   elsif Hacer_Informe=3 then
      Show_Message(-"Report correctly created in " &
         Ruta_Informe_Html,-"Confirmation");
   else
      Show_Message(-"Report correctly created in " &
         Ruta_Informe,-"Confirmation");
   end if;

   Hacer_Informe:=0;

exception
   when others=>
      Show_Error(-"Error creating report","Error");
      Hacer_Informe:=0;


end Informe;