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


separate(Calculadora)

procedure Guardar_Cargar (
      Guardar : Boolean; 
      Ruta    : String   ) is 

   type Vector_20 is array (1 .. 20) of Integer; 


   type Cadena_Texto 
         (L : Natural) is 
      record 
         Texto    : String (1 .. L) := (others => ' ');  
         Longitud : Natural         := 1;  
      end record; 

   type T_Save is 
      record 
         Version_Tc : Cadena_Texto (10);  

         Version_Travian : T_Version_Travian := V2;  
         Madera_Ac,  
         Barro_Ac,  
         Hierro_Ac,  
         Cereal_Ac       : Integer           := 0;  

         Madera_Nec,  
         Barro_Nec,  
         Hierro_Nec,  
         Cereal_Nec : Integer := 0;  

         Madera_Prod,  
         Barro_Prod,  
         Hierro_Prod,  
         Cereal_Prod : Integer := 0;  

         Numero_Aldeas             : Natural   := 0;  
         Cultura_Acumulada         : Natural   := 0;  
         Produccion_Cultura_Diaria : Natural   := 0;  
         Niveles_Ayuntamiento      : Vector_20 := (others => 0);  
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

      -- Recursos
      Save.Madera_Ac:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(1).Madera)));
      Save.Barro_Ac:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(1).Barro)));
      Save.Hierro_Ac:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(1).Hierro)));
      Save.Cereal_Ac:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(1).Cereal)));

      Save.Madera_Nec:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(2).Madera)));
      Save.Barro_Nec:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(2).Barro)));
      Save.Hierro_Nec:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(2).Hierro)));
      Save.Cereal_Nec:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(2).Cereal)));

      Save.Madera_Prod:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(3).Madera)));
      Save.Barro_Prod:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(3).Barro)));
      Save.Hierro_Prod:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(3).Hierro)));
      Save.Cereal_Prod:=Valor(To_Unbounded_String(Get_Text(Boxes_Recursos(3).Cereal)));


      -- Cultura
      Save.Numero_Aldeas  := Valor(To_Unbounded_String(Get_Text(
               Numero_Aldeas)));
      Save.Cultura_Acumulada:= Valor(To_Unbounded_String(Get_Text(
               Cultura_Actual)));
      Save.Produccion_Cultura_Diaria:= Valor(To_Unbounded_String(Get_Text(
               Produccion_Cultura)));
      for I in 1..Max_Niveles_Ayuntamiento loop
         Save.Niveles_Ayuntamiento(I):= Valor(To_Unbounded_String(Get_Text(
                  Datos_Ayuntamiento(I))));
      end loop;


      Write (F,Save);

   end Guardar_Datos;


   ------------------------


   procedure Cargar_Datos is 
      Version_Incorrecta : exception;  
   begin
      begin
         Read(F, Save);

         Version_Travian:=Save.Version_Travian;
         case Version_Travian is
            when V2 =>
               Set_Text(L_Version_Travian, Travian_V2);
            when V3 =>
               Set_Text(L_Version_Travian, Travian_V3);
         end case;



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



      -- Recursos

      Set_Text(Boxes_Recursos(1).Madera, Imprimir (Save.Madera_Ac));
      Set_Text(Boxes_Recursos(1).Hierro, Imprimir (Save.Hierro_Ac));
      Set_Text(Boxes_Recursos(1).Barro, Imprimir (Save.Barro_Ac));
      Set_Text(Boxes_Recursos(1).Cereal, Imprimir (Save.Cereal_Ac));

      Set_Text(Boxes_Recursos(2).Madera, Imprimir (Save.Madera_Nec));
      Set_Text(Boxes_Recursos(2).Hierro, Imprimir (Save.Hierro_Nec));
      Set_Text(Boxes_Recursos(2).Barro, Imprimir (Save.Barro_Nec));
      Set_Text(Boxes_Recursos(2).Cereal, Imprimir (Save.Cereal_Nec));

      Set_Text(Boxes_Recursos(3).Madera, Imprimir (Save.Madera_Prod));
      Set_Text(Boxes_Recursos(3).Hierro, Imprimir (Save.Hierro_Prod));
      Set_Text(Boxes_Recursos(3).Barro, Imprimir (Save.Barro_Prod));
      Set_Text(Boxes_Recursos(3).Cereal, Imprimir (Save.Cereal_Prod));




      -- Cultura

      Set_Text(Numero_Aldeas, Imprimir (Save.Numero_Aldeas));
      Set_Text(Cultura_Actual, Imprimir (Save.Cultura_Acumulada));
      Set_Text(Produccion_Cultura, Imprimir ( Save.Produccion_Cultura_Diaria));
      for I in 1..Max_Niveles_Ayuntamiento loop
         Set_Text(Datos_Ayuntamiento(I), Imprimir (Save.Niveles_Ayuntamiento(I)));
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
