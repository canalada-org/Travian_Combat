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



with Formulas, Ada.Strings.Unbounded, Ada.Sequential_Io;
use Formulas, Ada.Strings.Unbounded;


separate(Simulador)

procedure Guardar_Cargar (
      Guardar : Boolean; 
      Ruta    : String   ) is 

   type Vector_10 is array (1 .. 10) of Integer; 


   type Cadena_Texto 
         (L : Natural) is 
      record 
         Texto    : String (1 .. L) := (others => ' ');  
         Longitud : Natural         := 1;  
      end record; 

   type T_Save is 
      record 
         Version_Tc             : Cadena_Texto (10);  
         Version_Travian        : T_Version_Travian := V2;  
         Numero_Tropas_Atacante : Vector_10         := (others => 0);  
         Nivel_Tropas_Atacante  : Vector_10         := (others => 0);  
         Pop_Atacante           : Integer           := 0;  
         Pueblo                 : T_Pueblos         := Romanos;  
         Nivel_Pt               : Natural           := 0;  
         Artefacto              : Boolean           := False;  
         Atraco                 : Boolean           := False;  

         Numero_Tropas_Def_Romano  : Vector_10 := (others => 0);  
         Nivel_Tropas_Def_Romano   : Vector_10 := (others => 0);  
         Numero_Tropas_Def_Galo    : Vector_10 := (others => 0);  
         Nivel_Tropas_Def_Galo     : Vector_10 := (others => 0);  
         Numero_Tropas_Def_Germano : Vector_10 := (others => 0);  
         Nivel_Tropas_Def_Germano  : Vector_10 := (others => 0);  
         Pop_Defensor              : Integer   := 0;  
         Muralla                   : Natural   := 0;  
         Empalizada                : Natural   := 0;  
         Terraplen                 : Natural   := 0;  
         Palacio                   : Natural   := 0;  

         Coordenadas_Agresor_X  : Integer := 0;  
         Coordenadas_Defensor_X : Integer := 0;  
         Coordenadas_Agresor_Y  : Integer := 0;  
         Coordenadas_Defensor_Y : Integer := 0;  
         Naturaleza             : Boolean := False;  
      end record; 

   Save : T_Save;  

   package D_Save is new Ada.Sequential_Io(T_Save);
   use D_Save;

   F : D_Save.File_Type;  


   function Imprimir (
         X : Integer ) 
     return String is 
   begin
      if X=0 then
         return "";
      else
         return Quita_Espacios(Integer'Image(X));
      end if;
   end Imprimir;


   procedure Guardar_Datos is 
   begin

      if Length(To_Unbounded_String(Version))>10 then
         Save.Version_Tc.Texto (1..10):=Version(1..10);
         Save.Version_Tc.Longitud:=10;
      else
         Save.Version_Tc.Texto (1..Length(To_Unbounded_String(Version))):=Version;
         Save.Version_Tc.Longitud:=Length(To_Unbounded_String(Version));
      end if;

      -- Cogemos datos atacante
      Save.Naturaleza:=Naturaleza;
      Save.Version_Travian:=Version_Travian;
      Save.Pueblo:=Pueblo;
      Save.Pop_Atacante:=Valor(To_Unbounded_String(Get_Text(
               Edit_Hab_Agresor)));
      Save.Nivel_Pt:=Valor(To_Unbounded_String(Get_Text(
               Edit_Pt)));
      Save.Artefacto:=Get_State(Check_Artefacto);
      Save.Atraco:=Get_State(Radio_Atraco);
      for I in 1..10 loop
         Save.Numero_Tropas_Atacante(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Agresor(I).Tropas)));
         Save.Nivel_Tropas_Atacante(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Agresor(I).Nivel)));
      end loop;




      -- Cogemos datos defensor
      for I in 1..10 loop
         Save.Numero_Tropas_Def_Romano(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Defensor_Romano(I).Tropas)));
         Save.Nivel_Tropas_Def_Romano(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Defensor_Romano(I).Nivel)));

         Save.Numero_Tropas_Def_Galo(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Defensor_Galo(I).Tropas)));
         Save.Nivel_Tropas_Def_Galo(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Defensor_Galo(I).Nivel)));

         Save.Numero_Tropas_Def_Germano(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Defensor_Germano(I).Tropas)));
         Save.Nivel_Tropas_Def_Germano(I):=Valor(To_Unbounded_String(Get_Text(
                  Casillas_Tropas_Defensor_Germano(I).Nivel)));
      end loop;

      Save.Pop_Defensor:=Valor(To_Unbounded_String(Get_Text(
               Edit_Hab_Defensor)));

      Save.Muralla:=Valor(To_Unbounded_String(Get_Text(
               Edit_Muralla_Defensor)));
      Save.Empalizada:=Valor(To_Unbounded_String(Get_Text(
               Edit_Empalizada_Defensor)));
      Save.Terraplen:=Valor(To_Unbounded_String(Get_Text(
               Edit_Terraplen_Defensor)));

      Save.Palacio:=Valor(To_Unbounded_String(Get_Text(
               Edit_Palacio_Defensor)));

      Save.Coordenadas_Agresor_X:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Agresorax)));
      Save.Coordenadas_Agresor_Y:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Agresoray)));
      Save.Coordenadas_Defensor_X:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Defensorax)));
      Save.Coordenadas_Defensor_Y:=Valor(To_Unbounded_String(Get_Text(
               Edit_Aldea_Defensoray)));
      Write (F,Save);

   end Guardar_Datos;


   ------------------------


   procedure Cargar_Datos is 
      Version_Incorrecta : exception;  
   begin
      begin
         Read(F, Save);


         if Length(To_Unbounded_String(Version))>10 then
            if Save.Version_Tc.Texto (1..10)/=Version(1..10) then
               raise Version_Incorrecta;
            end if;

         else
            if Save.Version_Tc.Texto (1..Save.Version_Tc.Longitud)/=Version then
               raise Version_Incorrecta;
            end if;
         end if;


      exception
         when others =>
            Show_Error("GUI_Translation"-"Error: Saved file is corrupt or you are using another version of Travian Combat that is not compatible with the previous one. "
               & ("GUI_Translation"-"The version of Travian Combat you are using is ") & Version & ("GUI_Translation"-" and the saved file was created with ") & Save.Version_Tc.Texto (1..Save.Version_Tc.Longitud)
               ,"Error");
      end;


      -- Escribimos datos atacante
      if Naturaleza/=Save.Naturaleza then
         Cambiar_Naturaleza;
      end if;
      Version_Travian:=Save.Version_Travian;
      case Version_Travian is
         when V2 =>
            Disable(Animales_Tropas);
            Set_Text(L_Version_Travian, Travian_V2);
         when V3 =>
            Enable(Animales_Tropas);
            Set_Text(L_Version_Travian, Travian_V3);
      end case;
      Pueblo:=Save.Pueblo;
      Set_Text(Edit_Hab_Agresor, Imprimir (Save.Pop_Atacante));
      Set_Text(Edit_Pt, Imprimir (Save.Nivel_Pt));
      Set_State(Check_Artefacto, Save.Artefacto);
      if Save.Atraco then
         Set_State(Radio_Atraco, True);
         Set_State(Radio_Normal, False);
      else
         Set_State(Radio_Atraco, False);
         Set_State(Radio_Normal, True);
      end if;


      for I in 1..10 loop
         Set_Text(Casillas_Tropas_Agresor(I).Tropas, Imprimir ( Save.Numero_Tropas_Atacante(I)));
         Set_Text(Casillas_Tropas_Agresor(I).Nivel, Imprimir ( Save.Nivel_Tropas_Atacante(I)));
      end loop;


      -- Escribimos datos defensor
      for I in 1..10 loop

         Set_Text(Casillas_Tropas_Defensor_Romano(I).Tropas, Imprimir ( Save.Numero_Tropas_Def_Romano(I)));
         Set_Text(Casillas_Tropas_Defensor_Romano(I).Nivel, Imprimir ( Save.Nivel_Tropas_Def_Romano(I)));

         Set_Text(Casillas_Tropas_Defensor_Galo(I).Tropas, Imprimir ( Save.Numero_Tropas_Def_Galo(I)));
         Set_Text(Casillas_Tropas_Defensor_Galo(I).Nivel, Imprimir ( Save.Nivel_Tropas_Def_Galo(I)));

         Set_Text(Casillas_Tropas_Defensor_Germano(I).Tropas, Imprimir ( Save.Numero_Tropas_Def_Germano(I)));
         Set_Text(Casillas_Tropas_Defensor_Germano(I).Nivel, Imprimir ( Save.Nivel_Tropas_Def_Germano(I)));

      end loop;

      Set_Text(Edit_Hab_Defensor, Imprimir ( Save.Pop_Defensor));

      Set_Text(Edit_Terraplen_Defensor, Imprimir ( Save.Terraplen));
      Set_Text(Edit_Empalizada_Defensor, Imprimir ( Save.Empalizada));
      Set_Text(Edit_Muralla_Defensor, Imprimir ( Save.Muralla));
      Set_Text(Edit_Palacio_Defensor, Imprimir ( Save.Palacio));

      Set_Text(Edit_Aldea_Agresorax, Imprimir ( Save.Coordenadas_Agresor_X));
      Set_Text(Edit_Aldea_Agresoray, Imprimir ( Save.Coordenadas_Agresor_Y));

      Set_Text(Edit_Aldea_Defensorax, Imprimir ( Save.Coordenadas_Defensor_X));
      Set_Text(Edit_Aldea_Defensoray, Imprimir ( Save.Coordenadas_Defensor_Y));


      Cargar_Imagenes;

   end Cargar_Datos;

begin


   if Guardar then -- GUARDAR

      Create(F,Out_File ,Ruta);
      Guardar_Datos;
      Close(F);


   else -- CARGAR
      begin
         Open(F,In_File ,Ruta);
         Cargar_Datos;
         Close(F);
      exception
         when D_Save.Name_Error=>
            Show_Error("GUI_Translation"-"Error: Saved file not found. Make sure to save before loading!"
               ,"Error");
      end;

   end if;



end Guardar_Cargar;
