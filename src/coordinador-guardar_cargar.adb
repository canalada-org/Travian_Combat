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


separate(Coordinador)

procedure Guardar_Cargar (
      Guardar : Boolean; 
      Ruta    : String   ) is 

   type Vector_10 is array (1 .. 10) of Boolean; 


   type Cadena_Texto 
         (L : Natural) is 
      record 
         Texto    : String (1 .. L) := (others => ' ');  
         Longitud : Natural         := 1;  
      end record; 


   type Datos_Atacante is 
      record 
         Check_Romano        : Boolean           := True;  
         Check_Galo          : Boolean           := False;  
         Check_Germano       : Boolean           := False;  
         Tropas              : Vector_10         := (others => False);  
         Coordenadas_X       : Integer           := 0;  
         Coordenadas_Y       : Integer           := 0;  
         Nombre              : Cadena_Texto (25);  
         Nivel_Pt            : Integer           := 0;  
         Artefacto_Velocidad : Boolean           := False;  

         Hora,  
         Minutos,  
         Segundos,  
         Dia,  
         Mes,  
         Año      : Integer := 0;  
      end record; 

   type Vector_Datos is array (1 .. Numero_Atacantes) of Datos_Atacante; 

   type T_Save is 
      record 
         Version_Tc      : Cadena_Texto (10);  
         Version_Travian : T_Version_Travian := V2;  

         Atacante : Vector_Datos;  

         Coordenadas_Defensor_X : Integer := 0;  
         Coordenadas_Defensor_Y : Integer := 0;  
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

      Save.Version_Travian:=Version_Travian;

      Save.Coordenadas_Defensor_X:=Valor(To_Unbounded_String(Get_Text(
               Objetivo_X)));
      Save.Coordenadas_Defensor_Y:=Valor(To_Unbounded_String(Get_Text(
               Objetivo_Y)));


      for I in 1..Numero_Atacantes loop
         Save.Atacante(I).Hora:=Valor(To_Unbounded_String(Get_Text(
                  Llegada_Atacante(I,1))));
         Save.Atacante(I).Minutos:=Valor(To_Unbounded_String(Get_Text(
                  Llegada_Atacante(I,2))));
         Save.Atacante(I).Segundos:=Valor(To_Unbounded_String(Get_Text(
                  Llegada_Atacante(I,3))));
         Save.Atacante(I).Dia:=Valor(To_Unbounded_String(Get_Text(
                  Llegada_Atacante(I,4))));
         Save.Atacante(I).Mes:=Valor(To_Unbounded_String(Get_Text(
                  Llegada_Atacante(I,5))));
         Save.Atacante(I).Año:=Valor(To_Unbounded_String(Get_Text(
                  Llegada_Atacante(I,6))));

         Save.Atacante(I).Coordenadas_X:=Valor(To_Unbounded_String(Get_Text(
                  Informacion_Atacante(I,1))));
         Save.Atacante(I).Coordenadas_Y:=Valor(To_Unbounded_String(Get_Text(
                  Informacion_Atacante(I,2))));
         Save.Atacante(I).Artefacto_Velocidad:=Get_State(Artefacto_Atacante(I));
         Save.Atacante(I).Nivel_Pt:=Valor(To_Unbounded_String(Get_Text(
                  Informacion_Atacante(I,4))));

         Save.Atacante(I).Check_Romano:=Get_State( Bando_Atacante(I,1));
         Save.Atacante(I).Check_Germano:=Get_State( Bando_Atacante(I,2));
         Save.Atacante(I).Check_Galo:=Get_State( Bando_Atacante(I,3));
         for J in 1..10 loop
            Save.Atacante(I).Tropas(J):=Get_State(Checkboxs_Tropas(I,J));
         end loop;

         if Length(To_Unbounded_String(Get_Text(Informacion_Atacante(I,3))))>25 then
            Save.Atacante(I).Nombre.Texto(1..25):=Get_Text(Informacion_Atacante(I,3))(1..25);
            Save.Atacante(I).Nombre.Longitud:=25;
         else
            Save.Atacante(I).Nombre.Texto(1..Length(To_Unbounded_String(Get_Text(Informacion_Atacante(I,3))))):=Get_Text(Informacion_Atacante(I,3));
            Save.Atacante(I).Nombre.Longitud:= Length(To_Unbounded_String(Get_Text(Informacion_Atacante(I,3))));
         end if;
      end loop;


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


      Version_Travian:=Save.Version_Travian;
      case Version_Travian is
         when V2 =>
            Set_Text(L_Version_Travian, Travian_V2);
         when V3 =>
            Set_Text(L_Version_Travian, Travian_V3);
      end case;


      Set_Text(Objetivo_X,  Quita_Espacios(Integer'Image( Save.Coordenadas_Defensor_X)));
      Set_Text(Objetivo_Y,  Quita_Espacios(Integer'Image( Save.Coordenadas_Defensor_Y)));





      for I in 1..Numero_Atacantes loop
         Set_Text( Llegada_Atacante(I,1), Quita_Espacios(Dos_Digitos(Save.Atacante(I).Hora)));
         Set_Text( Llegada_Atacante(I,2), Quita_Espacios(Dos_Digitos(Save.Atacante(I).Minutos)));
         Set_Text( Llegada_Atacante(I,3), Quita_Espacios(Dos_Digitos(Save.Atacante(I).Segundos)));
         Set_Text( Llegada_Atacante(I,4), Quita_Espacios(Dos_Digitos(Save.Atacante(I).Dia)));
         Set_Text( Llegada_Atacante(I,5), Quita_Espacios(Dos_Digitos(Save.Atacante(I).Mes)));
         Set_Text( Llegada_Atacante(I,6), Imprimir (Save.Atacante(I).Año));

         Set_Text( Informacion_Atacante(I,1), Imprimir(Save.Atacante(I).Coordenadas_X));
         Set_Text( Informacion_Atacante(I,2),  Imprimir(Save.Atacante(I).Coordenadas_Y));

         Set_Text( Informacion_Atacante(I,4), Imprimir (Save.Atacante(I).Nivel_Pt));

         Set_State( Artefacto_Atacante(I), Save.Atacante(I).Artefacto_Velocidad);
         Set_State( Bando_Atacante(I,1), Save.Atacante(I).Check_Romano);
         Set_State( Bando_Atacante(I,2), Save.Atacante(I).Check_Germano);
         Set_State( Bando_Atacante(I,3), Save.Atacante(I).Check_Galo);

         if Length(To_Unbounded_String(Get_Text(Informacion_Atacante(I,3))))>25 then
            Set_Text(Informacion_Atacante(I,3), Save.Atacante(I).Nombre.Texto(1..25));
         else
            Set_Text(Informacion_Atacante(I,3), Save.Atacante(I).Nombre.Texto(1..Save.Atacante(I).Nombre.Longitud));
         end if;

         for J in 1..10 loop
            Set_State( Checkboxs_Tropas(I,J), Save.Atacante(I).Tropas(J));
         end loop;
      end loop;



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
