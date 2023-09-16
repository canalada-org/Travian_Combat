----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' and its subprograms, as this coordinator,
--   is distributed  in the  hope  that  it will be useful, but WITHOUT ANY  WARRANTY; 
--   without even the implied warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------
with Jewl.Simple_Windows,Interfaces.C,ada.strings.Unbounded;
use Jewl.Simple_Windows,ada.Strings.Unbounded;


with Traduccion;
use Traduccion;
with Traduccion_Gui;
use Traduccion_Gui;
with Traduccion_Coordinador ;
use Traduccion_Coordinador ;
with Adaintl;
use Adaintl;

with tablas; use tablas;

procedure Coordinador is
   
   TraduccionGui_Intl: Internationalization_Type:= Initialize_Adaintl (
         Language                => En,             
         Default_Domain          => "Coordinator_Translation", 
         Debug_Mode              => No_Debug,   
         Directory               => "locale/",         
         Load_Configuration_File => "config/Language.dat"          ); 

   -- Con estos pragmas evitamos que aparezca la consola de fondo :P
   pragma Linker_Options ("-mwindows");
   pragma Linker_Options ("-luser32");
   pragma Linker_Options ("-lgdi32");

   -- Añadimos el icono
   pragma Linker_Options("germano.o");

   Ven_Coordinador : Frame_Type := Frame (800, 600, Nombre_Coordinador, 'Z');  

   Numero_atacantes: constant positive:=4;

   -- Tipos
   type Vector_Paneles is array (Positive range <>) of Panel_Type; 
   type Vector_Image is array (Positive range <>) of Image_Type;
   type Vector_canvas is array (Positive range <>,positive range <>) of Canvas_Type; 
   type Vector_checkbox is array (Positive range <>,positive range <>) of Checkbox_Type; 
   type Vector_checkbox_1dimension is array (Positive range <>) of Checkbox_Type; 
   type Vector_Radiobutton is array (Positive range <>,positive range <>) of Radiobutton_Type;       
   type Vector_Editbox is array (Positive range <>,Positive range <>) of Editbox_Type;
   type Vector_Label is array (Positive range <>, Positive range <>) of Label_Type;
   

   -- Menu
   Menu_Archivo     : Menu_Type       := Menu (Ven_Coordinador, Texto_Menuarchivo); 
   Menu_Herramientas: Menu_Type       := Menu (Ven_Coordinador, Texto_MenuHerramientas);    
   Menu_Ayuda       : Menu_Type       := Menu (Ven_Coordinador, Texto_Menuayuda);
   
   Menu_Plantilla  : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Plantilla, 't');    
   Separator4      : Menuitem_Type    := Separator(Menu_Archivo);     
   Menu_Guardar    : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Guardar, 'g');  
   Menu_Cargar     : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Cargar, 'c');
   Separator3      : Menuitem_Type    := Separator(Menu_Archivo);       
   Salir           : Menuitem_Type    := Menuitem (Menu_Archivo, Texto_Salir, 'S'); 
    
   Minformecompleto: Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe_Completo & " " & Texto_Plano, '1'); 
   Minformeañadir  : Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe_Añadir & " " & Texto_Plano, '6');
   Separator1      : Menuitem_Type    := Separator(Menu_Herramientas);
   
   Minformecompleto2: Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe_Completo & " " & Texto_BBcode, '2'); 
   Minformeañadir2  : Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe_Añadir & " " & Texto_Bbcode, '7');
   Separator2      : Menuitem_Type    := Separator(Menu_Herramientas);
      
   Minformecompleto3: Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe_Completo & " " & Texto_HTML, '3'); 
   Minformeañadir3  : Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe_Añadir & " " & Texto_Html, '8');
      
   Acercade         : Menuitem_Type    := Menuitem (Menu_ayuda, Texto_acercade, 'A');  


-- Información
   Panel_Informativo: Panel_Type:=Panel(Ven_Coordinador, (15,15),758,52);
   Panel_Informativo_Tropas: Panel_Type:=Panel(Panel_Informativo, (0,0),225,102);   
   Panel_Informativo_Aldea: Panel_Type:=Panel(Panel_Informativo, (223,0),179,102); 
   Panel_Informativo_Llegada: Panel_Type:=Panel(Panel_Informativo, (578,0),180,102);
   Panel_Informativo_Envio : Panel_Type:=Panel(Panel_Informativo, (400,0),180,102);
         
   LTropas: Label_type:= Label(Panel_Informativo_Tropas,(20,12),140,80,Informacion_Tropas);   
   LAldea : Label_Type:= Label(Panel_Informativo_Aldea ,(7,4),140,80,Informacion_Aldea); 
   LLlegada : Label_Type:= Label(Panel_Informativo_Llegada,(7,4),160,80,Informacion_Llegada);   
   LEnvio : Label_Type:= Label(Panel_Informativo_Envio,(7,4),160,80,Informacion_Envio);
   
-- Panel principal de atacantes
   Paneles_atacantes: Vector_paneles:=(
      Panel (Ven_Coordinador, (15, 65), 758, 102,""),
      Panel (Ven_Coordinador, (15, 165), 758, 102,""), 
      Panel (Ven_Coordinador, (15, 265), 758, 102,""),
      Panel (Ven_Coordinador, (15, 365), 758, 102,"")      );  

-- Panel de tropas de cada atacante
   Paneles_tropas: Vector_paneles:=(
      Panel (Paneles_Atacantes(1), (0, 0), 225, 102,""),
      Panel (Paneles_Atacantes(2), (0, 0), 225, 102,""), 
      Panel (Paneles_Atacantes(3), (0, 0), 225, 102,""),  
      Panel (Paneles_Atacantes(4), (0, 0), 225, 102,""));
-- Panel de información de aldea de cada atacante
   Paneles_Aldeas: Vector_paneles:=(
      Panel (Paneles_Atacantes(1), (223, 0), 179, 102,""),
      Panel (Paneles_Atacantes(2), (223, 0), 179, 102,""), 
      Panel (Paneles_Atacantes(3), (223, 0), 179, 102,""),  
      Panel (Paneles_Atacantes(4), (223, 0), 179, 102,"")  );
-- Panel de llegada
   Paneles_Llegada: Vector_paneles:=(
      Panel (Paneles_Atacantes(1), (578, 0), 180, 102,""),
      Panel (Paneles_Atacantes(2), (578, 0), 180, 102,""), 
      Panel (Paneles_Atacantes(3), (578, 0), 180, 102,""),  
      Panel (Paneles_Atacantes(4), (578, 0), 180, 102,"")  );      
-- Panel de envio
   Paneles_Envio: Vector_paneles:=(
      Panel (Paneles_Atacantes(1), (400, 0), 180, 102,""),
      Panel (Paneles_Atacantes(2), (400, 0), 180, 102,""), 
      Panel (Paneles_Atacantes(3), (400, 0), 180, 102,""),  
      Panel (Paneles_Atacantes(4), (400, 0), 180, 102,"")  ); 



   
-- Imagenes
   type vector_positive is array (positive range <>) of positive;
   Coordenadas_canvas:vector_positive:=(40,57,74,91,108,125,142,159,176,193);
   Altura_Canvas:Positive:=15;
   
   Imagenes_Tropas: Vector_Canvas:=(
      -- Tropas del primer atacante
      (Canvas(Paneles_tropas(1), (coordenadas_canvas(1), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(2), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(3), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(4), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(5), Altura_Canvas), 18, 18), 
      Canvas(Paneles_tropas(1), (coordenadas_canvas(6), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(7), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(8), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(9), Altura_Canvas), 18, 18),
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(10), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(1), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(2), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(3), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(4), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(5), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_tropas(1), (coordenadas_canvas(6), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(7), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(8), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(9), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(10), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(1), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(2), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(3), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(4), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(5), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_tropas(1), (coordenadas_canvas(6), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(7), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(1), (coordenadas_canvas(8), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(9), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_Tropas(1), (coordenadas_canvas(10), Altura_Canvas+34), 18, 18)        
      ), 
      -- Tropas del segundo atacante
     (Canvas(Paneles_tropas(2), (coordenadas_canvas(1), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(2), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(3), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(4), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(5), Altura_Canvas), 18, 18), 
      Canvas(Paneles_tropas(2), (coordenadas_canvas(6), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(7), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(8), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(9), Altura_Canvas), 18, 18),
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(10), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(1), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(2), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(3), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(4), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(5), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_tropas(2), (coordenadas_canvas(6), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(7), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(8), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(9), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(10), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(1), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(2), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(3), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(4), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(5), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_tropas(2), (coordenadas_canvas(6), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(7), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(2), (coordenadas_canvas(8), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(9), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_Tropas(2), (coordenadas_canvas(10), Altura_Canvas+34), 18, 18)                 
         ),
      (Canvas(Paneles_tropas(3), (coordenadas_canvas(1), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(2), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(3), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(4), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(5), Altura_Canvas), 18, 18), 
      Canvas(Paneles_tropas(3), (coordenadas_canvas(6), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(7), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(8), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(9), Altura_Canvas), 18, 18),
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(10), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(1), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(2), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(3), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(4), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(5), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_tropas(3), (coordenadas_canvas(6), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(7), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(8), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(9), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(10), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(1), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(2), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(3), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(4), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(5), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_tropas(3), (coordenadas_canvas(6), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(7), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(3), (coordenadas_canvas(8), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(9), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_Tropas(3), (coordenadas_canvas(10), Altura_Canvas+34), 18, 18)        
         ),  
      (Canvas(Paneles_tropas(4), (coordenadas_canvas(1), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(2), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(3), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(4), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(5), Altura_Canvas), 18, 18), 
      Canvas(Paneles_tropas(4), (coordenadas_canvas(6), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(7), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(8), Altura_Canvas), 18, 18), 
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(9), Altura_Canvas), 18, 18),
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(10), Altura_Canvas), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(1), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(2), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(3), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(4), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(5), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_tropas(4), (coordenadas_canvas(6), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(7), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(8), Altura_Canvas+17), 18, 18), 
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(9), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(10), Altura_Canvas+17), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(1), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(2), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(3), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(4), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(5), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_tropas(4), (coordenadas_canvas(6), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(7), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_tropas(4), (coordenadas_canvas(8), Altura_Canvas+34), 18, 18), 
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(9), Altura_Canvas+34), 18, 18),
      Canvas(Paneles_Tropas(4), (coordenadas_canvas(10), Altura_Canvas+34), 18, 18)        
      )                
    ); 

-- Checkboxs (tropas)
   Checkboxs_Tropas: Vector_Checkbox:= (
      (Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(1)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(1),(Coordenadas_Canvas(2)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(3)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(4)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(5)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(1),(Coordenadas_Canvas(6)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(7)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(8)+2,Altura_Canvas+60),18,18,""),           
       Checkbox(Paneles_Tropas(1),(Coordenadas_Canvas(9)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(1),(Coordenadas_Canvas(10)+2,Altura_Canvas+60),18,18,"")            
            ),
            
      (Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(1)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(2),(Coordenadas_Canvas(2)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(3)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(4)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(5)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(2),(Coordenadas_Canvas(6)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(7)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(8)+2,Altura_Canvas+60),18,18,""),           
       Checkbox(Paneles_Tropas(2),(Coordenadas_Canvas(9)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(2),(Coordenadas_Canvas(10)+2,Altura_Canvas+60),18,18,"")
         ),
       (Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(1)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(3),(Coordenadas_Canvas(2)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(3)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(4)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(5)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(3),(Coordenadas_Canvas(6)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(7)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(8)+2,Altura_Canvas+60),18,18,""),           
       Checkbox(Paneles_Tropas(3),(Coordenadas_Canvas(9)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(3),(Coordenadas_Canvas(10)+2,Altura_Canvas+60),18,18,"")            
      ),
       (Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(1)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(4),(Coordenadas_Canvas(2)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(3)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(4)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(5)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(4),(Coordenadas_Canvas(6)+2,Altura_Canvas+60),18,18,""),         
       Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(7)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(8)+2,Altura_Canvas+60),18,18,""),           
       Checkbox(Paneles_Tropas(4),(Coordenadas_Canvas(9)+2,Altura_Canvas+60),18,18,""),
       Checkbox(Paneles_tropas(4),(Coordenadas_Canvas(10)+2,Altura_Canvas+60),18,18,"")            
            ));

-- Radiobuttons (elegir pueblo atacante)
   Bando_Atacante: Vector_Radiobutton:=
      (
      (Radiobutton(Paneles_Tropas(1),(Coordenadas_Canvas(1)-25,Altura_Canvas),18,18,"",True),
       Radiobutton(Paneles_Tropas(1),(Coordenadas_Canvas(1)-25,Altura_Canvas+17),18,18,""),
       Radiobutton(Paneles_Tropas(1),(Coordenadas_Canvas(1)-25,Altura_Canvas+34),18,18,"")
            ),
      (Radiobutton(Paneles_Tropas(2),(Coordenadas_Canvas(1)-25,Altura_Canvas),18,18,"",true),
       Radiobutton(Paneles_Tropas(2),(Coordenadas_Canvas(1)-25,Altura_Canvas+17),18,18,""),
       Radiobutton(Paneles_Tropas(2),(Coordenadas_Canvas(1)-25,Altura_Canvas+34),18,18,"")
            ),
      (Radiobutton(Paneles_Tropas(3),(Coordenadas_Canvas(1)-25,Altura_Canvas),18,18,"",True),
       Radiobutton(Paneles_Tropas(3),(Coordenadas_Canvas(1)-25,Altura_Canvas+17),18,18,""),
       Radiobutton(Paneles_Tropas(3),(Coordenadas_Canvas(1)-25,Altura_Canvas+34),18,18,"")
            ),
      (Radiobutton(Paneles_Tropas(4),(Coordenadas_Canvas(1)-25,Altura_Canvas),18,18,"",true),
       Radiobutton(Paneles_Tropas(4),(Coordenadas_Canvas(1)-25,Altura_Canvas+17),18,18,""),
       Radiobutton(Paneles_Tropas(4),(Coordenadas_Canvas(1)-25,Altura_Canvas+34),18,18,"")
      )            
            
      );


   -- Coordenadas de aldeas y nombre
   
   Labels_Atacante: Vector_Label:=
            (
      (Label(Paneles_aldeas(1),(25,18),10,20,Nom_Aldea_X),
       Label(Paneles_Aldeas(1),(105,18),10,20,Nom_Aldea_Y),
       Label(Paneles_Aldeas(1),(25,45),60,20,Nom_Pt_Abreviado),
       Label(Paneles_aldeas(1),(100,45),60,20,Nom_Artefacto_Abreviado),
       Label(Paneles_aldeas(1),(10,73),60,20,Nom_Nombre)
            ),
      (Label(Paneles_aldeas(2),(25,18),10,20,Nom_Aldea_X),
       Label(Paneles_Aldeas(2),(105,18),10,20,Nom_Aldea_Y),
       Label(Paneles_Aldeas(2),(25,45),60,20,Nom_Pt_Abreviado),
       Label(Paneles_aldeas(2),(100,45),60,20,Nom_Artefacto_Abreviado),
       Label(Paneles_aldeas(2),(10,73),60,20,Nom_Nombre)
      ),
     (Label(Paneles_aldeas(3),(25,18),10,20,Nom_Aldea_X),
       Label(Paneles_Aldeas(3),(105,18),10,20,Nom_Aldea_Y),
       Label(Paneles_Aldeas(3),(25,45),60,20,Nom_Pt_Abreviado),
       Label(Paneles_aldeas(3),(100,45),60,20,Nom_Artefacto_Abreviado),
       Label(Paneles_aldeas(3),(10,73),60,20,Nom_Nombre)
            ),
      (Label(Paneles_aldeas(4),(25,18),10,20,Nom_Aldea_X),
       Label(Paneles_Aldeas(4),(105,18),10,20,Nom_Aldea_Y),
       Label(Paneles_Aldeas(4),(25,45),60,20,Nom_Pt_Abreviado),
       Label(Paneles_aldeas(4),(100,45),60,20,Nom_Artefacto_Abreviado),
       Label(Paneles_aldeas(4),(10,73),60,20,Nom_Nombre)
      )     );
      

   Informacion_Atacante: Vector_Editbox:=
            (
      (Editbox(Paneles_aldeas(1),(40,15),40,20,""),
       Editbox(Paneles_aldeas(1),(120,15),40,20,""),
       Editbox(Paneles_Aldeas(1),(60,70),100,20,Nom_Agresor & "  1"),
       Editbox(Paneles_aldeas(1),(55,42),25,20,"")           
            ),
      (Editbox(Paneles_aldeas(2),(40,15),40,20,""),
       Editbox(Paneles_aldeas(2),(120,15),40,20,""),
       Editbox(Paneles_Aldeas(2),(60,70),100,20,Nom_Agresor & "  2"),
       Editbox(Paneles_aldeas(2),(55,42),25,20,"")
      ),
      (Editbox(Paneles_aldeas(3),(40,15),40,20,""),
       Editbox(Paneles_aldeas(3),(120,15),40,20,""),
       Editbox(Paneles_Aldeas(3),(60,70),100,20,Nom_Agresor & "  3"),
       Editbox(Paneles_aldeas(3),(55,42),25,20,"")
            ),
      (Editbox(Paneles_aldeas(4),(40,15),40,20,""),
       Editbox(Paneles_aldeas(4),(120,15),40,20,""),
       Editbox(Paneles_Aldeas(4),(60,70),100,20,Nom_Agresor & "  4"),
       Editbox(Paneles_aldeas(4),(55,42),25,20,"")
      )      );



   Artefacto_Atacante: Vector_Checkbox_1dimension:=
      ( 
      Checkbox(Paneles_Aldeas(1),(130,45),18,18,""),
      Checkbox(Paneles_aldeas(2),(130,45),18,18,""),         
      Checkbox(Paneles_Aldeas(3),(130,45),18,18,""),
      Checkbox(Paneles_Aldeas(4),(130,45),18,18,"")
         
                  );

   -- Hora de llegada
   
   Labels_Horario_llegada: Vector_Label:=
            (
      (Label(Paneles_llegada(1),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_llegada(1),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_llegada(1),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_llegada(1),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_llegada(1),(83,63),10,20,(Guion)),
       Label(Paneles_llegada(1),(118,63),10,20,(Guion))            
            ),
      (Label(Paneles_llegada(2),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_llegada(2),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_llegada(2),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_llegada(2),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_llegada(2),(83,63),10,20,(Guion)),
       Label(Paneles_llegada(2),(118,63),10,20,(Guion)) 
      ),
      (Label(Paneles_llegada(3),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_llegada(3),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_llegada(3),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_llegada(3),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_llegada(3),(83,63),10,20,(Guion)),
       Label(Paneles_llegada(3),(118,63),10,20,(Guion)) 
            ),
      (Label(Paneles_llegada(4),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_llegada(4),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_llegada(4),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_llegada(4),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_llegada(4),(83,63),10,20,(Guion)),
       Label(Paneles_llegada(4),(118,63),10,20,(Guion)) 
      )      );
      

   Llegada_Atacante: Vector_Editbox:=
            (
      (Editbox(Paneles_llegada(1),(65,20),25,20,""),
       Editbox(Paneles_llegada(1),(100,20),25,20,""),
       Editbox(Paneles_llegada(1),(135,20),25,20,""),
       Editbox(Paneles_llegada(1),(55,60),25,20,""),
       Editbox(Paneles_llegada(1),(90,60),25,20,""),
       Editbox(Paneles_llegada(1),(125,60),40,20,"")            
            ),
      (Editbox(Paneles_llegada(2),(65,20),25,20,""),
       Editbox(Paneles_llegada(2),(100,20),25,20,""),
       Editbox(Paneles_llegada(2),(135,20),25,20,""),
       Editbox(Paneles_llegada(2),(55,60),25,20,""),
       Editbox(Paneles_llegada(2),(90,60),25,20,""),
       Editbox(Paneles_llegada(2),(125,60),40,20,"")  
      ),
     (Editbox(Paneles_llegada(3),(65,20),25,20,""),
       Editbox(Paneles_llegada(3),(100,20),25,20,""),
       Editbox(Paneles_llegada(3),(135,20),25,20,""),
       Editbox(Paneles_llegada(3),(55,60),25,20,""),
       Editbox(Paneles_llegada(3),(90,60),25,20,""),
       Editbox(Paneles_llegada(3),(125,60),40,20,"")            
            ),
      (Editbox(Paneles_llegada(4),(65,20),25,20,""),
       Editbox(Paneles_llegada(4),(100,20),25,20,""),
       Editbox(Paneles_llegada(4),(135,20),25,20,""),
       Editbox(Paneles_llegada(4),(55,60),25,20,""),
       Editbox(Paneles_llegada(4),(90,60),25,20,""),
       Editbox(Paneles_llegada(4),(125,60),40,20,"")  
      ));


  -- Hora de envio
   
   Labels_Horario_envio: Vector_Label:=
            (
      (Label(Paneles_envio(1),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_Envio(1),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_Envio(1),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_envio(1),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_Envio(1),(83,63),10,20,(Guion)),
       Label(Paneles_Envio(1),(118,63),10,20,(Guion))
                 ),
      (Label(Paneles_envio(2),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_Envio(2),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_Envio(2),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_envio(2),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_Envio(2),(83,63),10,20,(Guion)),
       Label(Paneles_Envio(2),(118,63),10,20,(Guion))
         ),
      (Label(Paneles_envio(3),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_Envio(3),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_Envio(3),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_envio(3),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_Envio(3),(83,63),10,20,(Guion)),
       Label(Paneles_Envio(3),(118,63),10,20,(Guion))
            ),
      (Label(Paneles_envio(4),(14,23),150,20,(Nom_Hora)),
       Label(Paneles_Envio(4),(14,63),160,20,(Nom_Fecha)),
       Label(Paneles_Envio(4),(93,23),10,20,(Dos_Puntos)),
       Label(Paneles_envio(4),(128,23),10,20,(Dos_Puntos)),         
       Label(Paneles_Envio(4),(83,63),10,20,(Guion)),
       Label(Paneles_Envio(4),(118,63),10,20,(Guion)) 
      )            
      );
      

   Envio_Atacante: Vector_Editbox:=
            (
      (Editbox(Paneles_envio(1),(63,20),27,20,""),
       Editbox(Paneles_envio(1),(98,20),27,20,""),
       Editbox(Paneles_envio(1),(133,20),27,20,""),
       Editbox(Paneles_envio(1),(54,60),26,20,""),
       Editbox(Paneles_envio(1),(89,60),26,20,""),
       Editbox(Paneles_envio(1),(125,60),40,20,"")            
            ),
      (Editbox(Paneles_envio(2),(63,20),27,20,""),
       Editbox(Paneles_envio(2),(98,20),27,20,""),
       Editbox(Paneles_envio(2),(133,20),27,20,""),
       Editbox(Paneles_envio(2),(54,60),26,20,""),
       Editbox(Paneles_envio(2),(89,60),26,20,""),
       Editbox(Paneles_envio(2),(125,60),40,20,"")  
      ),
      (Editbox(Paneles_envio(3),(63,20),27,20,""),
       Editbox(Paneles_envio(3),(98,20),27,20,""),
       Editbox(Paneles_envio(3),(133,20),27,20,""),
       Editbox(Paneles_envio(3),(54,60),26,20,""),
       Editbox(Paneles_envio(3),(89,60),26,20,""),
       Editbox(Paneles_envio(3),(125,60),40,20,"")            
            ),
      (Editbox(Paneles_envio(4),(63,20),27,20,""),
       Editbox(Paneles_envio(4),(98,20),27,20,""),
       Editbox(Paneles_envio(4),(133,20),27,20,""),
       Editbox(Paneles_envio(4),(54,60),26,20,""),
       Editbox(Paneles_envio(4),(89,60),26,20,""),
       Editbox(Paneles_envio(4),(125,60),40,20,"")  
      )      );


   Panel_Aldea_Objetivo: Panel_type:= Panel(Ven_coordinador,(593,475),180,50,Nom_aldea_objetivo);
   Label_X_Objetivo: Label_type:=Label(Panel_Aldea_Objetivo,(25,22),10,20,Nom_Aldea_X);
   Label_Y_Objetivo: Label_Type:=Label(Panel_Aldea_Objetivo,(95,22),10,20,Nom_Aldea_Y);
   Objetivo_X: Editbox_type:=Editbox(Panel_Aldea_Objetivo,(40,20),40,20,"0");
   Objetivo_Y: Editbox_Type:=Editbox(Panel_Aldea_Objetivo,(110,20),40,20,"0");

   -- Botones de control
   Boton_Ahora : Button_Type := Button (Ven_Coordinador,(15,475),125,25,Botones_Hoy,'H');  
   Boton_Mañana: Button_Type := Button (Ven_Coordinador,(15,505),125,25,Botones_Mañananoche,'M');  
   Boton_Copiar: Button_Type := Button (Ven_Coordinador,(160,475),125,25,Botones_Copiar_Llegada,'C');  
   Boton_Ccorde: Button_Type := Button (Ven_Coordinador,(160,505),125,25,Botones_Copiar_Coordenadas,'O');
   
   --Boton_LAldea: Button_Type   := Button (Ven_Coordinador,(305,475),125,25,Botones_Limpiar_Aldeas,'Y');  
   Boton_LLlegada: Button_Type := Button (Ven_Coordinador,(305,505),125,25,Botones_Limpiar_Llegada,'G');
   Boton_LTropas: Button_Type  := Button (Ven_Coordinador,(450,475),125,25,Botones_Limpiar_Tropas,'T');   
   --Boton_Limpiar: Button_Type  := Button (Ven_Coordinador,(450,505),125,25,Botones_Limpiar_todo,'L'); 
   Boton_Limpiar: Button_Type  := Button (Ven_Coordinador,(305,475),125,25,Botones_Limpiar_todo,'L'); 


   L_Version_Travian   : Label_Type   := Label (Ven_Coordinador, (450, 510), 65, 20, Travian_V2); 
   B_Cambiar_Version   : Button_Type  := Button(Ven_Coordinador,(515,505),60,25, Vx, 'V');
   
   Version_Travian: T_Version_Travian:=V2;

   -- Informe de combate
   -- 0 No se hace informe
   -- 1 Informe en texto plano
   -- 2 BBCode
   -- 3 HTML
   Hacer_informe: Natural:=0;


   procedure Cargar_Imagenes_Y_Bloquear_Campos is separate;
   procedure Realizar_Calculos is separate;
   procedure Acerca_de is separate;   
   procedure Realizar_Informe (Añadir: boolean) is separate; 
   procedure Botones(X: Positive) is separate;

   
   procedure Guardar_Cargar(Guardar: Boolean;
                            Ruta   : String) is
      separate;
      
   procedure Plantilla (Guardar: Boolean) is
      separate;




begin

   Show(Ven_Coordinador);

   -- Cargamos las imagenes y bloqueamos los campos que no se pueden modificar
   Cargar_imagenes_Y_bloquear_campos;

   -- Inicializamos
   Botones(2);
   Botones(5);
   
   Plantilla (false);  -- Cargamos la plantilla si existe


   loop
      Realizar_Calculos;
      if Command_Ready then
         case Next_Command is
            when 'Z'=>
               exit;
            when 'A'=>
               Acerca_de;
            when 'S'=>
               exit;
            when '1'=>
               Hacer_Informe:=1;
               Realizar_Informe(False);             
            when '2'=>
               Hacer_Informe:=2;
               Realizar_Informe(False);     
            when '3'=>
               Hacer_Informe:=3;
               Realizar_Informe(False);                  
            when '6'=>
               Hacer_Informe:=1;
               Realizar_Informe(True);  
            when '7'=>
               Hacer_Informe:=2;
               Realizar_Informe(True);
            when '8'=>
               Hacer_Informe:=3;
               Realizar_Informe(True);               
            when 'H'=>
               Botones(1);       
            when 'M'=>
               Botones(2);
            when 'C'=>
               Botones(5); 
            when 'O'=>
               Botones(6);                             
            when 'L'=>
               Botones(13);  
            when 'Y'=>
               Botones(10);               
            when 'G'=>
               Botones(11);    
            when 'T'=>
               Botones(12);
            when 'V' =>
             case Version_Travian is
             when V2 =>
              Version_Travian:=V3;  
              Set_Text(L_Version_Travian, Travian_V3);    
             when V3 =>
              Version_Travian:=V2;
              Set_Text(L_Version_Travian, Travian_V2);
               end case;   
            when 'c' =>
              Guardar_Cargar(False, ("GUI_Translation"-"config/Quicksave") & ("GUI_Translation"-".cdf")); -- CARGAR
            when 'g' =>
              Guardar_Cargar(True, ("GUI_Translation"-"config/Quicksave") & ("GUI_Translation"-".cdf")); -- GUARDAR   
            when 't' =>
              Plantilla (true); -- PLANTILLA         
            when others=>
               null;
         end case;
      end if;
      delay(0.1);
   end loop;

   Hide(Ven_Coordinador);
   Clean_Adaintl;


exception
   when Interfaces.C.Terminator_Error=>
      null;


end Coordinador;
