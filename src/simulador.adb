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
--
--   Created by Andres Soliño, 26/12/05 
--   You can contact with the creator of this program by email
--   andres.age AT gmail.com         
----------------------------------------------------------------------------
-- Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo 
-- los términos de la Licencia Pública General de GNU según es publicada por 
-- la Free Software Foundation, bien de la versión 2 de dicha Licencia o bien
-- (según su elección) de cualquier versión posterior.
--
-- "Travian Combat" se distribuye con la esperanza de que sea útil, 
-- pero SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita 
-- o sin garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR. 
-- Véase la Licencia Pública General de GNU para más detalles.
-- 
-- Debería haber recibido una copia de la Licencia Pública General junto con este programa. 
-- Si no ha sido así, escriba a la Free Software Foundation, Inc., 
-- en 675 Mass Ave, Cambridge, MA 02139, EEUU.
--
--   http://www.gnu.org/copyleft/gpl.html  
--
-- Traducción de la GPL al castellano
-- http://gugs.sindominio.net/licencias/gples.html
--
-- Creado por Andres Soliño el 26/12/05
-- E-mail de contacto: andres.age ARROBA gmail.com
------------------------------------
--  Changelog
-- 
-- v0.90b - 13-9-06
--      - Arreglado pequeño fallo en el simulador
--         (mostraba perdidas si no habia atacante)
--
-- v0.90a - 10-9-06
--      - Arreglada calculadora de cultura
--        Ahora muestra la cultura necesaria para 
--        fundar aldeas aunque los datos introducidos
--        no sean correctos (más comodidad)
--      - Arreglados detalles en la ayuda
--
-- v0.90 - 7-9-06
--      - Añadida carga y guardado rapido
--      - Añadido opción para poner como plantilla
--      - Añadida calculadora de cultura
--      - Añadido consumo de cereal en el simulador
--      - Ayuda en HTML
--      - Añadido idioma alemán
--
-- v0.89 - 16-8-06
--      - Corregido un bug al calcular distancias entre aldeas
--      - Adaptado a Travian v3
--      - Añadidos animales en el simulador
--      - Informes de coordinador y simulador en 
--         BBCode y HTML (además de texto plano)
--      - Cambiadas las columnas de envio y llegada de tropas en el
--         coordinador para evitar confusiones
--      - Añadido instalador
-- 
-- v0.8 - 6-8-06
--      - Corregido bug en el simulador - ya no pone
--        perdidas en las defensas cuando no hay atacante 
--      - Mejorado bonus de armamentería y armería en el combate 
--      - Perfeccionado combate entre batidores
--      - Añadido soporte para internacionalización
--
-- v0.7a - 22-4-06
--	  - Corregido bug en el simulador - ya no se cuelga 
--        al poner la población del atacante en primer lugar
--      - Añadido "Añadir a informe" en el coordinador de ataques
--
-- v0.7 - 5-4-06
--	  - Mejorado el cálculo de moral
--      - TC se ha dividido en 3 aplicaciones distintas:
--         * Simulador de combate
--         * Calculadora de recursos
--         * Coordinador de ataques (¡Nuevo!)
--      - Cambiados los iconos
--
-- v0.6 - 18-2-06
--	  - Añadido "Artefacto de doble velocidad"
--	  - Añadida Plaza de Torneos
--	  - Corregido otro fallo en el cálculo de combate entre 
--         batidores. 
--
-- v0.5a - 1-2-06
--	  - Corregido un fallo con el cálculo de combate entre 
--         batidores. 
--      - Modificada la estructura del programa debido
--         a algunos problemas que experimentaban ciertos
--         usuarios: ya no usa dos procesos paralelos, solo uno
--      - Añadidos botones en la calculadora de recursos
--
-- v0.5 - 22-1-06
--	  - Añadido "Atraco"
--	  - Ampliadas las casillas para admitir números de 5 cifras
--      - Añadido Un Icono Al Ejecutable
--      
--v0.4 - 3-1-06
--	- Arreglado un bug que colgaba el programa cuando se introducían
--	  más de 10 millones de soldados (¿cuanto costará mantener eso?)
--	- Añadido una calculadora básica de recursos
--
--v0.3 - 31-12-05
--	- Arreglado el botón "Limpiar" (antes no limpiaba todos los campos)
--	- Mejorado el cálculo de moral y de palacio
--	   
--v0.2 - 28-12-05
--	- Corregido un bug por el cual algunas batallas
--	   se calculaban como acechos
--	- Mejorada la velocidad de respuesta
--	- Incorporado un creador de informes
--	- Incorporado un sistema de cálculo de llegadas
--	   y distancias
--	- Cambiado el orden de tropas perdidas y nivel 
--	   de tropas para prevenir confusiones

--v0.1 - 26-12-05
--	- ¡Primera versión!


with Adaintl; use Adaintl;

with Interfaces.C;

with Jewl.Simple_Windows;
use Jewl.Simple_Windows;

with Tablas, traduccion,traduccion_GUI;
use Tablas,Traduccion,Traduccion_Gui;

-- with ada.Text_IO; use ada.Text_IO; -- Esto es para testear (como a veces soy demasiado vago para usar un debugger... xD)

procedure Simulador is 


   TC_Intl: Internationalization_Type:= Initialize_Adaintl (
         Language                => En,             
         Default_Domain          => "Simulator_Translation", 
         Debug_Mode              => No_Debug,   
         Directory               => "locale/",         
         Load_Configuration_File => "config/Language.dat"          ); 

   -- Con estos pragmas evitamos que aparezca la consola de fondo :P
   pragma Linker_Options ("-mwindows");
   pragma Linker_Options ("-luser32");
   pragma Linker_Options ("-lgdi32"); 

   -- Añadimos el icono
   pragma Linker_Options("romano.o");
   
   type T_Recursos is 
      record 
         Madera   : Editbox_Type;  
         Barro    : Editbox_Type;  
         Hierro   : Editbox_Type; 
         Cereal   : Editbox_Type;  
      end record; 

   type Casillas_Recursos is array (positive range <>) of T_Recursos; 

   type T_Grupo is 
      record 
         Tropas   : Editbox_Type;  
         Perdidas : Editbox_Type;
         Nivel    : Editbox_Type;   
      end record; 

   type Casillas_Ejercito is array (positive range <>) of T_Grupo; 
   type Casillas_Dibujo is array (positive range <>) of Canvas_Type; 

   -- Ventana principal
   Principal : Frame_Type := Frame (920, 600, Nombre_Simulador, 'X');  

   -- Menu
   Menu_Archivo     : Menu_Type       := Menu (Principal, Texto_Menuarchivo);
   Menu_Opciones    : Menu_Type       := Menu (Principal, Texto_Opciones);   
   Menu_Herramientas: Menu_Type       := Menu (Principal, Texto_MenuHerramientas);    
   Menu_Ayuda       : Menu_Type       := Menu (Principal, Texto_Menuayuda);
   
   Animales_Tropas : Menuitem_Type    := Menuitem (Menu_Opciones, Texto_Animales_Tropas, '.');
   Menu_Plantilla  : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Plantilla, 't');    
   Separator4      : Menuitem_Type    := Separator(Menu_Archivo);     
   Menu_Guardar    : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Guardar, 'g');  
   Menu_Cargar     : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Cargar, 'c');
   Separator3      : Menuitem_Type    := Separator(Menu_Archivo);  
   Salir           : Menuitem_Type    := Menuitem (Menu_archivo, Texto_salir, 'S');  
   Minforme_Plano  : Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe & " " & Texto_Plano, '1'); 
   Minforme_Bbcode : Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe & " " & Texto_Bbcode, '2');
   MInforme_Html: Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Informe & " " & Texto_Html, '3');         
   --MCalculadora     : Menuitem_Type    := Menuitem (Menu_Herramientas, Texto_Calc, 'C');  
   Acercade        : Menuitem_Type    := Menuitem (Menu_ayuda, Texto_acercade, 'A');  

   -- Menu Agresor
   Pueblo : T_Pueblos := Romanos; 
   
   -- Indica si luchamos contra la naturaleza
   Naturaleza: Boolean:=False;

   Panel_Agresor : Panel_Type  := Panel (Principal, (15, 10), 710, 140, Nom_Agresor);  
   B_Romanos     : Button_Type := Button (Panel_Agresor, (600, 20), 100, 25, Nom_Romanos , 'R');  
   B_Galos       : Button_Type := Button (Panel_Agresor, (600, 50), 100, 25, Nom_Galos , 'G');  
   B_Germanos    : Button_Type := Button (Panel_Agresor, (600, 80), 100, 25, Nom_Germanos , 'M');  

   Dibujo_Agresor:Casillas_Dibujo:=(
      Canvas (Panel_Agresor, (105, 20), 18, 18),
      Canvas (Panel_Agresor, (155, 20), 18, 18),
      Canvas (Panel_Agresor, (205, 20), 18, 18),
      Canvas (Panel_Agresor, (255, 20), 18, 18),
      Canvas (Panel_Agresor, (305, 20), 18, 18),
      Canvas (Panel_Agresor, (355, 20), 18, 18),      
      Canvas (Panel_Agresor, (405, 20), 18, 18),
      Canvas (Panel_Agresor, (455, 20), 18, 18),
      Canvas (Panel_Agresor, (505, 20), 18, 18),
      Canvas (Panel_Agresor, (555, 20), 18, 18)
                );

   Radio_Normal: Radiobutton_type:= Radiobutton(Panel_Agresor, (430, 110), 99, 25, Nom_normal , True); 
   Radio_Atraco: Radiobutton_type:= Radiobutton(Panel_Agresor, (530, 110), 100, 25, Nom_atraco, False); 

   Casillas_Tropas_Agresor : Casillas_Ejercito := (
      (Editbox (Panel_Agresor, (90, 45), 51, 20, ""), Editbox (Panel_Agresor, (90, 64), 51, 20, ""), Editbox (Panel_Agresor, (90, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (140, 45), 51, 20, ""), Editbox (Panel_Agresor, (140, 64), 51, 20, ""), Editbox (Panel_Agresor, (140, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (190, 45), 51, 20, ""), Editbox (Panel_Agresor, (190, 64), 51, 20, ""), Editbox (Panel_Agresor, (190, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (240, 45), 51, 20, ""), Editbox (Panel_Agresor, (240, 64), 51, 20, ""), Editbox (Panel_Agresor, (240, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (290, 45), 51, 20, ""), Editbox (Panel_Agresor, (290, 64), 51, 20, ""), Editbox (Panel_Agresor, (290, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (340, 45), 51, 20, ""), Editbox (Panel_Agresor, (340, 64), 51, 20, ""), Editbox (Panel_Agresor, (340, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (390, 45), 51, 20, ""), Editbox (Panel_Agresor, (390, 64), 51, 20, ""), Editbox (Panel_Agresor, (390, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (440, 45), 51, 20, ""), Editbox (Panel_Agresor, (440, 64), 51, 20, ""), Editbox (Panel_Agresor, (440, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (490, 45), 51, 20, ""), Editbox (Panel_Agresor, (490, 64), 51, 20, ""), Editbox (Panel_Agresor, (490, 83), 51, 20, "")),
      (Editbox (Panel_Agresor, (540, 45), 51, 20, ""), Editbox (Panel_Agresor, (540, 64), 51, 20, ""), Editbox (Panel_Agresor, (540, 83), 51, 20, "")));  


   L_Tropas : Label_Type := Label (Panel_Agresor, (20, 47), 60, 20, Nom_tropas);  

   L_Perdidas: Label_Type := Label (Panel_Agresor, (20, 66), 60, 20, Nom_perdidas);  

   L_Nivel: Label_Type := Label (Panel_Agresor, (20, 85), 60, 20, nom_nivel);  

   L_Habitantes_Agresor : Label_Type   := Label (Panel_Agresor, (20, 113), 80, 20, nom_habitantes);  
   Edit_Hab_Agresor     : Editbox_Type := Editbox (Panel_Agresor, (90, 110), 51, 20, ""); 
   
   Check_Artefacto: Checkbox_type:= Checkbox(Panel_Agresor, (330, 110), 70, 25, Nom_artefacto); 
   L_PlazaTorneos : Label_Type   := Label (Panel_Agresor, (155, 113), 100, 20, nom_PT);  
   Edit_PT        : Editbox_Type := Editbox (Panel_Agresor, (240, 110), 51, 20, ""); 

   -- Menu Defensor
   Panel_Defensor : Panel_Type := Panel (Principal, (15, 160), 710, 310, Nom_Defensores);  


   -- Defensores romanos
   
   Dibujo_Defensor_Romano :Casillas_Dibujo:=(
      Canvas (Panel_Defensor, (105, 30), 18, 18),
      Canvas (Panel_Defensor, (155, 30), 18, 18),
      Canvas (Panel_Defensor, (205, 30), 18, 18),
      Canvas (Panel_Defensor, (255, 30), 18, 18),
      Canvas (Panel_Defensor, (305, 30), 18, 18),
      Canvas (Panel_Defensor, (355, 30), 18, 18),      
      Canvas (Panel_Defensor, (405, 30), 18, 18),
      Canvas (Panel_Defensor, (455, 30), 18, 18),
      Canvas (Panel_Defensor, (505, 30), 18, 18),
      Canvas (Panel_Defensor, (555, 30), 18, 18)
                );

   Casillas_Tropas_Defensor_Romano: Casillas_Ejercito := (
      (Editbox (Panel_Defensor, (90, 55), 51, 20, ""),Editbox (Panel_Defensor, (90, 74), 51, 20, ""),Editbox (Panel_Defensor, (90, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (140, 55), 51, 20, ""),Editbox (Panel_Defensor, (140, 74), 51, 20, ""),Editbox (Panel_Defensor, (140, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (190, 55), 51, 20, ""),Editbox (Panel_Defensor, (190, 74), 51, 20, ""),Editbox (Panel_Defensor, (190, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (240, 55), 51, 20, ""),Editbox (Panel_Defensor, (240, 74), 51, 20, ""),Editbox (Panel_Defensor, (240, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (290, 55), 51, 20, ""),Editbox (Panel_Defensor, (290, 74), 51, 20, ""),Editbox (Panel_Defensor, (290, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (340, 55), 51, 20, ""),Editbox (Panel_Defensor, (340, 74), 51, 20, ""),Editbox (Panel_Defensor, (340, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (390, 55), 51, 20, ""),Editbox (Panel_Defensor, (390, 74), 51, 20, ""),Editbox (Panel_Defensor, (390, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (440, 55), 51, 20, ""),Editbox (Panel_Defensor, (440, 74), 51, 20, ""),Editbox (Panel_Defensor, (440, 93), 51, 20, "")),
      (Editbox (Panel_Defensor, (490, 55), 51, 20, ""),Editbox (Panel_Defensor, (490, 74), 51, 20, ""),Editbox (Panel_Defensor, (490, 93), 51, 20, "")),         
      (Editbox (Panel_Defensor, (540, 55), 51, 20, ""),Editbox (Panel_Defensor, (540, 74), 51, 20, ""),Editbox (Panel_Defensor, (540, 93), 51, 20, ""))
   );  



   L_Defensa_Romana : Label_Type   := Label (Panel_Defensor, (20, 35), 60, 20, Nom_romanos);  
   L_Dtropas        : Label_Type   := Label (Panel_Defensor, (20, 60), 60, 20, Nom_tropas); 
   L_Perdidas1: Label_Type   := Label (Panel_Defensor, (20, 79), 60, 20, Nom_Perdidas);  
   L_Nivel1: Label_Type   := Label (Panel_Defensor, (20, 98), 60, 20, Nom_Nivel);  


   -- Defensores Germanos
   
   Dibujo_Defensor_Germano:Casillas_Dibujo:=(
      Canvas (Panel_Defensor, (105, 120), 18, 18),
      Canvas (Panel_Defensor, (155, 120), 18, 18),
      Canvas (Panel_Defensor, (205, 120), 18, 18),
      Canvas (Panel_Defensor, (255, 120), 18, 18),
      Canvas (Panel_Defensor, (305, 120), 18, 18),
      Canvas (Panel_Defensor, (355, 120), 18, 18),      
      Canvas (Panel_Defensor, (405, 120), 18, 18),
      Canvas (Panel_Defensor, (455, 120), 18, 18),
      Canvas (Panel_Defensor, (505, 120), 18, 18),
      Canvas (Panel_Defensor, (555, 120), 18, 18)
                );



   Casillas_Tropas_Defensor_Germano: Casillas_Ejercito := (
      (Editbox (Panel_Defensor, (90, 145), 51, 20, ""),Editbox (Panel_Defensor, (90, 164), 51, 20, ""),Editbox (Panel_Defensor, (90, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (140, 145), 51, 20, ""),Editbox (Panel_Defensor, (140, 164), 51, 20, ""),Editbox (Panel_Defensor, (140, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (190, 145), 51, 20, ""),Editbox (Panel_Defensor, (190, 164), 51, 20, ""),Editbox (Panel_Defensor, (190, 183), 51, 20, "")), 
      (Editbox (Panel_Defensor, (240, 145), 51, 20, ""),Editbox (Panel_Defensor, (240, 164), 51, 20, ""),Editbox (Panel_Defensor, (240, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (290, 145), 51, 20, ""),Editbox (Panel_Defensor, (290, 164), 51, 20, ""),Editbox (Panel_Defensor, (290, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (340, 145), 51, 20, ""),Editbox (Panel_Defensor, (340, 164), 51, 20, ""),Editbox (Panel_Defensor, (340, 183), 51, 20, "")), 
      (Editbox (Panel_Defensor, (390, 145), 51, 20, ""),Editbox (Panel_Defensor, (390, 164), 51, 20, ""),Editbox (Panel_Defensor, (390, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (440, 145), 51, 20, ""),Editbox (Panel_Defensor, (440, 164), 51, 20, ""),Editbox (Panel_Defensor, (440, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (490, 145), 51, 20, ""),Editbox (Panel_Defensor, (490, 164), 51, 20, ""),Editbox (Panel_Defensor, (490, 183), 51, 20, "")),
      (Editbox (Panel_Defensor, (540, 145), 51, 20, ""),Editbox (Panel_Defensor, (540, 164), 51, 20, ""),Editbox (Panel_Defensor, (540, 183), 51, 20, ""))         
         
   );  
   L_Defensa_Germana : Label_Type   := Label (Panel_Defensor, (20, 125), 60, 20, Nom_germanos);  
   L_Dtropas2        : Label_Type   := Label (Panel_Defensor, (20, 150), 60, 20, Nom_tropas);  
   L_Perdidas2: Label_Type   := Label (Panel_Defensor, (20, 169), 60, 20, Nom_Perdidas);  
   L_Nivel2: Label_Type   := Label (Panel_Defensor, (20, 188), 60, 20, Nom_Nivel);  

   -- Defensores Galos
   
   Dibujo_Defensor_Galo:Casillas_Dibujo:=(
      Canvas (Panel_Defensor, (105, 210), 18, 18),
      Canvas (Panel_Defensor, (155, 210), 18, 18),
      Canvas (Panel_Defensor, (205, 210), 18, 18),
      Canvas (Panel_Defensor, (255, 210), 18, 18),
      Canvas (Panel_Defensor, (305, 210), 18, 18),
      Canvas (Panel_Defensor, (355, 210), 18, 18),   
      Canvas (Panel_Defensor, (405, 210), 18, 18),
      Canvas (Panel_Defensor, (455, 210), 18, 18),   
      Canvas (Panel_Defensor, (505, 210), 18, 18),
      Canvas (Panel_Defensor, (555, 210), 18, 18)
                            );
  
   Casillas_Tropas_Defensor_Galo: Casillas_Ejercito := (
      (Editbox (Panel_Defensor, (90, 235), 51, 20, ""),Editbox (Panel_Defensor, (90, 254), 51, 20, ""),Editbox (Panel_Defensor, (90, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (140, 235), 51, 20, ""),Editbox (Panel_Defensor, (140, 254), 51, 20, ""),Editbox (Panel_Defensor, (140, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (190, 235), 51, 20, ""),Editbox (Panel_Defensor, (190, 254), 51, 20, ""),Editbox (Panel_Defensor, (190, 273), 51, 20, "")),   
      (Editbox (Panel_Defensor, (240, 235), 51, 20, ""),Editbox (Panel_Defensor, (240, 254), 51, 20, ""),Editbox (Panel_Defensor, (240, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (290, 235), 51, 20, ""),Editbox (Panel_Defensor, (290, 254), 51, 20, ""),Editbox (Panel_Defensor, (290, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (340, 235), 51, 20, ""),Editbox (Panel_Defensor, (340, 254), 51, 20, ""),Editbox (Panel_Defensor, (340, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (390, 235), 51, 20, ""),Editbox (Panel_Defensor, (390, 254), 51, 20, ""),Editbox (Panel_Defensor, (390, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (440, 235), 51, 20, ""),Editbox (Panel_Defensor, (440, 254), 51, 20, ""),Editbox (Panel_Defensor, (440, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (490, 235), 51, 20, ""),Editbox (Panel_Defensor, (490, 254), 51, 20, ""),Editbox (Panel_Defensor, (490, 273), 51, 20, "")),
      (Editbox (Panel_Defensor, (540, 235), 51, 20, ""),Editbox (Panel_Defensor, (540, 254), 51, 20, ""),Editbox (Panel_Defensor, (540, 273), 51, 20, ""))       
   ); 
   L_Defensa_Gala : Label_Type   := Label (Panel_Defensor, (20, 215), 60, 20, Nom_galos);  
   L_Dtropas3     : Label_Type   := Label (Panel_Defensor, (20, 240), 60, 20, Nom_tropas);  
   L_Perdidas3: Label_Type   := Label (Panel_Defensor, (20, 259), 60, 20,Nom_Perdidas);  
   L_Nivel3: Label_Type   := Label (Panel_Defensor, (20, 278), 60, 20, Nom_Nivel);  


   L_Habitantes_Defensor : Label_Type   := Label (Panel_Defensor, (615, 37), 80, 20, Nom_habitantes);  
   Edit_Hab_Defensor     : Editbox_Type := Editbox (Panel_Defensor, (623, 55), 40, 20, "");  
   L_Palacio_Defensor    : Label_Type   := Label (Panel_Defensor, (605, 90), 80, 20, Nom_Palacio);  
   Edit_Palacio_Defensor : Editbox_Type := Editbox (Panel_Defensor, (623, 108), 40, 20, "");  

   L_Muralla_Defensor    : Label_Type   := Label (Panel_Defensor, (605, 143), 90, 20, Nom_Muralla);  
   Edit_Muralla_Defensor : Editbox_Type := Editbox (Panel_Defensor, (623, 161), 40, 20, "");  

   L_Terraplen_Defensor    : Label_Type   := Label (Panel_Defensor, (605, 196), 90, 20, Nom_Terraplen);  
   Edit_Terraplen_Defensor : Editbox_Type := Editbox (Panel_Defensor, (623, 214), 40, 20, "");  

   L_Empalizada_Defensor    : Label_Type   := Label (Panel_Defensor, (600, 249), 100, 20, Nom_empalizada);  
   Edit_Empalizada_Defensor : Editbox_Type := Editbox (Panel_Defensor, (623, 267), 40, 20, "");  



   -- Perdidas
   Panel_Perdidas : Panel_Type := Panel (Principal, (740, 10), 155, 460, Nom_Perd_Materiales);  

   Dibujo_Perdidas :Casillas_Dibujo:=(
      Canvas (Panel_Perdidas, (20, 25), 18, 18),
      Canvas (Panel_Perdidas, (20, 45), 18, 18),
      Canvas (Panel_Perdidas, (20, 65), 18, 18),
      Canvas (Panel_Perdidas, (20, 85), 18, 18),
         
      Canvas (Panel_Perdidas, (20, 189), 18, 18),
      Canvas (Panel_Perdidas, (20, 209), 18, 18),
      Canvas (Panel_Perdidas, (20, 229), 18, 18),
      Canvas (Panel_Perdidas, (20, 249), 18, 18),
         
      Canvas (Panel_Perdidas, (20, 279), 18, 18),
      Canvas (Panel_Perdidas, (20, 299), 18, 18),
      Canvas (Panel_Perdidas, (20, 319), 18, 18),
      Canvas (Panel_Perdidas, (20, 339), 18, 18),
         
      Canvas (Panel_Perdidas, (20, 369), 18, 18),
      Canvas (Panel_Perdidas, (20, 389), 18, 18),
      Canvas (Panel_Perdidas, (20, 409), 18, 18),
      Canvas (Panel_Perdidas, (20, 429), 18, 18),
         
      Canvas (Panel_Perdidas, (20, 113), 18, 18), 
      Canvas (Panel_Perdidas, (20, 160), 18, 18) 
                );

   Recursos_Perdidos: Casillas_Recursos:= (
      (Editbox (Panel_Perdidas, (55, 24), 80, 21, ""),Editbox (Panel_Perdidas, (55, 44), 80, 21, ""),Editbox (Panel_Perdidas, (55, 64), 80,21, ""),Editbox (Panel_Perdidas, (55, 84), 80, 21, "")),
      (Editbox (Panel_Perdidas, (55, 188), 80, 21, ""),Editbox (Panel_Perdidas, (55, 208), 80, 21, ""),Editbox (Panel_Perdidas, (55, 228), 80, 21, ""),Editbox (Panel_Perdidas, (55, 248), 80, 21, "")),
      (Editbox (Panel_Perdidas, (55, 278), 80, 21, ""),Editbox (Panel_Perdidas, (55, 298), 80, 21, ""),Editbox (Panel_Perdidas, (55, 318), 80,21, ""),Editbox (Panel_Perdidas, (55, 338), 80, 21, "")),
      (Editbox (Panel_Perdidas, (55, 368), 80, 21, ""),Editbox (Panel_Perdidas, (55, 388), 80, 21, ""),Editbox (Panel_Perdidas, (55, 408), 80, 21, ""),Editbox (Panel_Perdidas, (55, 428), 80, 21, ""))
   );  

   Consumo_Atacante: Editbox_Type:=Editbox (Panel_Perdidas, (55, 112), 80, 21, "");
   Consumo_Defensor: Editbox_Type:=Editbox (Panel_Perdidas, (55, 159), 80, 21, "");

   -- Menu Otros
   Panel_Otros: Panel_Type := Panel (Principal, (15, 485), 710, 50, ""); 
   
   L_Aldea_Agresora     : Label_Type   := Label (Panel_Otros, (15, 17), 100, 20, Nom_Aldea_Agresora); 
   L_Aldea_X            : Label_Type   := Label (Panel_Otros, (110, 17), 30, 20, Nom_Aldea_X);  
   Edit_Aldea_AgresoraX : Editbox_Type := Editbox (Panel_Otros, (130, 15), 40, 20, "");
   L_Aldea_Y            : Label_Type   := Label (Panel_Otros, (180, 17), 30, 20, Nom_Aldea_Y);  
   Edit_Aldea_AgresoraY : Editbox_Type := Editbox (Panel_Otros, (200, 15), 40, 20, "");
   
   L_Aldea_Defensora    : Label_Type   := Label (Panel_Otros, (275, 17), 100, 20, Nom_Aldea_Defensora); 
   L_Aldea_DX           : Label_Type   := Label (Panel_Otros, (370, 17), 30, 20, Nom_Aldea_X);  
   Edit_Aldea_DefensoraX: Editbox_Type := Editbox (Panel_Otros, (390, 15), 40, 20, "");
   L_Aldea_DY           : Label_Type   := Label (Panel_Otros, (440, 17), 30, 20, Nom_Aldea_Y);  
   Edit_Aldea_DefensoraY: Editbox_Type := Editbox (Panel_Otros, (460, 15), 40, 20, "");
   
   L_Tiempo_llegada     : Label_Type   := Label (Panel_Otros, (550, 17), 70, 20, Nom_Tiempo);  
   Edit_Tiempo_Llegada  : Editbox_Type := Editbox (Panel_Otros, (605, 15), 83, 20, "");
   
   B_Borrar : Button_Type := Button (Principal, (740, 485), 155, 23, Nom_Borrar, 'W'); 
   L_Version_Travian   : Label_Type   := Label (Principal, (755, 515), 70, 20, Travian_V2); 
   B_Cambiar_Version   : Button_Type  := Button (Principal, (835, 510), 60, 23, Vx, 'V');
   
   Version_Travian: T_Version_Travian:=V2;

   -- Informe de combate
   -- 0 No se hace informe
   -- 1 Informe en texto plano
   -- 2 BBCode
   -- 3 HTML
   Hacer_informe: Natural:=0;

   procedure Limpiar is
   begin
      for I in 1..10 loop
         Set_text(Casillas_Tropas_Agresor(I).Tropas,"");         
         Set_Text(Casillas_Tropas_Defensor_Galo(I).Tropas,"");
         Set_Text(Casillas_Tropas_Defensor_Romano(I).Tropas,"");  
         Set_Text(Casillas_Tropas_Defensor_Germano(I).Tropas,"");  
         Set_text(Casillas_Tropas_Agresor(I).Nivel,"");         
         Set_Text(Casillas_Tropas_Defensor_Galo(I).Nivel,"");
         Set_Text(Casillas_Tropas_Defensor_Romano(I).Nivel,"");  
         Set_text(Casillas_Tropas_Defensor_Germano(I).Nivel,""); 
      end loop;
      Set_Text(Edit_Aldea_DefensoraX,"");
      Set_Text(Edit_Aldea_DefensoraY,"");  
      Set_Text(Edit_Aldea_AgresoraY,"");
      Set_Text(Edit_Aldea_Agresorax,"");
      Set_Text(Edit_Empalizada_Defensor,"");
      Set_Text(Edit_Terraplen_Defensor,"");     
      Set_Text(Edit_Muralla_Defensor,"");  
      Set_Text(Edit_Hab_Defensor,"");
      Set_Text(Edit_Hab_Agresor,"");      
      Set_Text(Edit_Palacio_Defensor,"");     
      Set_Text(Edit_Pt,"");       
      Set_state(Check_artefacto,False);  
   end Limpiar;



   procedure Acerca_de is
      separate;

   procedure Cargar_Imagenes is 
      separate;
      
   procedure Realizar_Calculos is 
      separate;
      
   procedure Cambiar_Naturaleza is
      separate;

   procedure Guardar_Cargar(Guardar: Boolean;
                            Ruta   : String) is
      separate;
      
   procedure Plantilla (Guardar: Boolean) is
      separate;


begin

   -- Inicializar
   Set_Origin(Principal,(50,50));
   Show (Principal);
   Disable(Edit_Tiempo_Llegada);
   Disable(Animales_Tropas);
   for I in 1..10 loop
      Disable(Casillas_Tropas_Defensor_Romano(I).Perdidas);
      Disable(Casillas_Tropas_Defensor_Germano(I).Perdidas);
      Disable(Casillas_Tropas_Defensor_Galo(I).Perdidas);      
      Disable(Casillas_Tropas_Agresor(I).Perdidas);      
   end loop;        
   for I in 1..4 loop
      Disable(Recursos_Perdidos(I).Madera);
      Disable(Recursos_Perdidos(I).Barro);  
      Disable(Recursos_Perdidos(I).Hierro);
      Disable(Recursos_Perdidos(I).Cereal);                     
   end loop;  
  Disable(Consumo_Defensor);      
  Disable(Consumo_Atacante);    
   
  Cargar_Imagenes;

  Plantilla (false);  -- Cargamos la plantilla si existe

   ---------------
   
   loop
    Realizar_Calculos;   
      if Command_Ready then

       case Next_Command is
         when 'X' =>
            exit;
         when 'S' =>
            exit;
         when 'R' =>
            Pueblo:=Romanos;
            Cargar_Imagenes;
         when 'G' =>
            Pueblo:=Galos;
            Cargar_Imagenes;
         when 'M' =>
            Pueblo:=Germanos;
            Cargar_Imagenes;
         when 'W' =>
            Limpiar;        
         when 'A' =>
            Acerca_De;
         when '1' =>
            Hacer_Informe:=1;
         when '2' =>
            Hacer_Informe:=2;
         when '3' =>
            Hacer_Informe:=3;
         when '.' =>
            Cambiar_Naturaleza;
         when 'V' =>
             case Version_Travian is
             when V2 =>
              Enable(Animales_Tropas); 
              Version_Travian:=V3;  
              Set_Text(L_Version_Travian, Travian_V3);    
             when V3 =>
              Disable(Animales_Tropas);
              Version_Travian:=V2;
              Set_Text(L_Version_Travian, Travian_V2);
              if Naturaleza then
                  Cambiar_Naturaleza;
              end if;
             end case;   
         when 'c' =>
            Guardar_Cargar(False, ("GUI_Translation"-"config/Quicksave") & ("GUI_Translation"-".sdf")); -- CARGAR
         when 'g' =>
            Guardar_Cargar(True, ("GUI_Translation"-"config/Quicksave") & ("GUI_Translation"-".sdf")); -- GUARDAR   
         when 't' =>
            Plantilla (true); -- PLANTILLA  
         when others=>
            null;
         end case;
         
    end if;   

   end loop;

   Hide (Principal);
   Clean_Adaintl;

exception
   when Interfaces.C.Terminator_Error=>
      null;

end simulador;