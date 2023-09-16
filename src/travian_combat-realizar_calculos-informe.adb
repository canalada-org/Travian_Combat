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


with Ada.Characters.Handling,Ada.Strings.Unbounded;
use Ada.Characters.Handling,Ada.Strings.Unbounded;


separate(Travian_Combat.Realizar_Calculos)

procedure Informe is 



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

   F                        : File_Type;  
   Muertos_Agresor,  
   Muertos_Defensor_Romano,  
   Muertos_Defensor_Galo,  
   Muertos_Defensor_Germano,  
   Muertos_Totales          : Natural   := 0;  
begin
   Hacer_Informe:=False;
   Create(F,Out_File,Ruta_Informe);
   Put(F,"Simulación de batalla creada con " & Nombre_Programa);
   New_Line(F,3);
   Put(F,"Agresor: " & Formato(T_Pueblos'Image(Pueblo)));
   New_Line(F);
   Put_Line(F,"Coordenadas - X:" & Integer'Image(
         Coordenadas.Agresor_X)
      & " Y:" & Integer'Image(Coordenadas.Agresor_X));
   Put_Line(F,"Habitantes: " & Integer'Image(Habitantes_Agresor));

   if Get_Text(Edit_Tiempo_Llegada)="" then
      Put(F,"Tiempo de llegada: -");
   else
      Put(F,"Tiempo de llegada a objetivo: " & Get_Text(
            Edit_Tiempo_Llegada));
   end if;
   New_Line(F,2);

   if Cantidad_Tropas.Atacante=0 then
      Put(F,"Sin unidades militares" );
      New_Line(F);
   else
      for I in 1..10 loop
         if Atacante.Tropas(I).Cantidad>0 then
            case Pueblo is
               when Romanos=>
                  Put(F,To_String(Ejercito_Romano(I)));
               when Galos=>
                  Put(F,To_String(Ejercito_Galo(I)));
               when Germanos=>
                  Put(F,To_String(Ejercito_Germano(I)));
            end case;
            Put(F, ": " & Integer'Image(Atacante.Tropas(I).
                  Cantidad)
               & "  Nivel: " & Integer'Image(Atacante.Tropas(I).
                  Nivel)
               & " Pérdidas: " & Integer'Image(
                  Res_Atacante.Tropas(I).Cantidad));
            Muertos_Agresor:=Muertos_Agresor+Res_Atacante.Tropas(
               I).Cantidad;
            New_Line(F);
         end if;
      end loop;
      New_Line(F);
      Put(F,"Soldados agresores muertos: " & Natural'Image(
            Muertos_Agresor));
      New_Line(F);
      Put_Line(F,
         "Total materias primas perdidas por el agresor: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Cereal)))
            ));
      Put_Line(F,"Madera: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Madera)))
            ));
      Put_Line(F,"Barro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Barro)))
            ));
      Put_Line(F,"Hierro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Hierro)))
            ));
      Put_Line(F,"Cereal: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        1).Cereal)))
            ));
      New_Line(F);
   end if;



   -- Defensor
   New_Line(F,3);
   Put(F,"Defensor");
   New_Line(F);
   Put_Line(F,"Coordenadas - X:" & Integer'Image(
         Coordenadas.Defensor_X)
      & " Y:" & Integer'Image(Coordenadas.Defensor_X));
   Put_Line(F,"Habitantes: " & Integer'Image(Habitantes_Agredido));
   Put_Line(F,"Palacio: " & Integer'Image(Nivel_Palacio));
   if   Defensor_Romano.Muralla>0 then
      Put_Line(F,"Muralla: " & Integer'Image(Defensor_Romano.Muralla));
   elsif  Defensor_Galo.Muralla>0 then
      Put_Line(F,"Muralla: " & Integer'Image(Defensor_Galo.Muralla));
   else
      Put_Line(F,"Muralla: " & Integer'Image(Defensor_Germano.Muralla));
   end if;


   -- Romanos
   New_Line(F);
   Put(F,"Apoyo Romano");
   New_Line(F);
   if Cantidad_Tropas.Defensor_Romano=0 then
      Put(F,"Sin unidades militares" );
      New_Line(F);
   else
      for I in 1..10 loop
         if Defensor_Romano.Tropas(I).Cantidad>0 then
            Put(F,To_String(Ejercito_Romano(I)));
            Put(F, ": " & Integer'Image(Defensor_Romano.Tropas(I).
                  Cantidad)
               & "  Nivel: " & Integer'Image(
                  Defensor_Romano.Tropas(I).Nivel)
               & " Pérdidas: " & Integer'Image(
                  Res_Defensor_Romano.Tropas(I).Cantidad));
            Muertos_Defensor_Romano:=Muertos_Defensor_Romano+
               Res_Defensor_Romano.Tropas(I).Cantidad;
            New_Line(F);
         end if;
      end loop;
      New_Line(F);
      Put(F,"Soldados defensores romanos muertos: " & Natural'
         Image(Muertos_Defensor_Romano));
      New_Line(F);
      Put_Line(F,
         "Total materias primas perdidas por el defensor romano: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Cereal)))
            ));
      Put_Line(F,"Madera: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Madera)))
            ));
      Put_Line(F,"Barro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Barro)))
            ));
      Put_Line(F,"Hierro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Hierro)))
            ));
      Put_Line(F,"Cereal: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        2).Cereal)))
            ));
   end if;

   -- Galos
   New_Line(F,2);
   Put(F,"Apoyo Galo");
   New_Line(F);
   if Cantidad_Tropas.Defensor_Galo=0 then
      Put(F,"Sin unidades militares" );
      New_Line(F);
   else
      for I in 1..10 loop
         if Defensor_Galo.Tropas(I).Cantidad>0 then
            Put(F,To_String(Ejercito_Galo(I)));
            Put(F, ": " & Integer'Image(Defensor_Galo.Tropas(I).
                  Cantidad)
               & "  Nivel: " & Integer'Image(
                  Defensor_Galo.Tropas(I).Nivel)
               & " Pérdidas: " & Integer'Image(
                  Res_Defensor_Galo.Tropas(I).Cantidad));
            Muertos_Defensor_Galo:=Muertos_Defensor_Galo+
               Res_Defensor_Galo.Tropas(I).Cantidad;
            New_Line(F);
         end if;
      end loop;
      New_Line(F);
      Put(F,"Soldados defensores galos muertos: " & Natural'
         Image(Muertos_Defensor_Galo));
      New_Line(F);
      Put_Line(F,
         "Total materias primas perdidas por el defensor galo: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Cereal)))
            ));
      Put_Line(F,"Madera: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Madera)))
            ));
      Put_Line(F,"Barro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Barro)))
            ));
      Put_Line(F,"Hierro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Hierro)))
            ));
      Put_Line(F,"Cereal: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        4).Cereal)))
            ));
   end if;

   -- Galos
   New_Line(F,2);
   Put(F,"Apoyo Germano");
   New_Line(F);
   if Cantidad_Tropas.Defensor_Germano=0 then
      Put(F,"Sin unidades militares" );
      New_Line(F);
   else
      for I in 1..10 loop
         if Defensor_Germano.Tropas(I).Cantidad>0 then
            Put(F,To_String(Ejercito_Galo(I)));
            Put(F, ": " & Integer'Image(Defensor_Germano.Tropas(
                     I).Cantidad)
               & "  Nivel: " & Integer'Image(
                  Defensor_Germano.Tropas(I).Nivel)
               & " Pérdidas: " & Integer'Image(
                  Res_Defensor_Germano.Tropas(I).Cantidad));
            Muertos_Defensor_Germano:=Muertos_Defensor_Germano+
               Res_Defensor_Germano.Tropas(I).Cantidad;
            New_Line(F);
         end if;
      end loop;
      New_Line(F);
      Put(F,"Soldados defensores germanos muertos: " & Natural'
         Image(Muertos_Defensor_Germano));
      New_Line(F);
      Put_Line(F,
         "Total materias primas perdidas por el defensor germano: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Madera)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Barro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Hierro)))+
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Cereal)))
            ));
      Put_Line(F,"Madera: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Madera)))
            ));
      Put_Line(F,"Barro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Barro)))
            ));
      Put_Line(F,"Hierro: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Hierro)))
            ));
      Put_Line(F,"Cereal: " &
         Natural'Image(
            Valor(To_Unbounded_String(Get_Text( Recursos_Perdidos(
                        3).Cereal)))
            ));
   end if;
   New_Line(F);
   Put_Line(F,"Total defensores muertos: " & Natural'Image(
         Muertos_Defensor_Germano+Muertos_Defensor_Galo+
         Muertos_Defensor_Romano));

   Put_Line(F,
      "Total materias primas perdidas por los defensores: " &
      Natural'Image(
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
   New_Line(F);

   Muertos_Totales:=Muertos_Defensor_Germano+
      Muertos_Defensor_Galo+Muertos_Defensor_Romano+
      Muertos_Agresor;
   Put(F,"Total soldados muertos en ambos bandos en ");

   if Muertos_Totales <10 then
      Put(F,"esta cutrez de batalla");
   elsif Muertos_Totales <30 then
      Put(F,"esta batalla de risa");
   elsif Muertos_Totales <75 then
      Put(F,"esta batallita");
   elsif Muertos_Totales <100 then
      Put(F,"esta pedazo de batalla");
   elsif Muertos_Totales <250 then
      Put(F,"esta batalla sangrienta ");
   elsif Muertos_Totales <500 then
      Put(F,"esta batalla sanguinaria, vil y cruel");
   elsif Muertos_Totales <750 then
      Put(F,
         "esta batalla motivada por motivos egoistas y megalómanos");
   elsif Muertos_Totales <900 then
      Put(F,
         "esta batalla sin sentido, donde la sangre fluye sin cesar");
   elsif Muertos_Totales <1100 then
      Put(F,
         "esta batalla que ha dejado miles de familias destrozadas");
   elsif Muertos_Totales <1500 then
      Put(F,
         "este vergonzoso dia para la humanidad, donde miles de hombres se han matado mutuamente por "
         & "los deseos de un par de locos gobernantes");
   else
            Put(F,
         "la mayor batalla que los viejos aldeanos de Travian recuerdan");
   end if;

   Put_Line(F,": " &
      Natural'Image(Muertos_Totales));

   Put_Line(F,
      "Total materias primas perdidas por ambos bandos en esta batalla: " &
      Natural'Image(
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


   Close(F);
   Show_Message("Informe creado correctamente en: " &
      Ruta_Informe,"Confirmación");
exception
   when others=>
      Show_Error("Error creando informe","Error");


end Informe;