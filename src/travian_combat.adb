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


with Jewl.Simple_Windows;
use Jewl.Simple_Windows;

with Tablas, traduccion,traduccion_GUI;
use Tablas,traduccion,traduccion_GUI;

procedure Travian_Combat is 

   -- Con estos pragmas evitamos que aparezca la consola de fondo :P
   pragma Linker_Options ("-mwindows");
   pragma Linker_Options ("-luser32");
   pragma Linker_Options ("-lgdi32"); 

   type T_Recursos is 
      record 
         Madera   : Editbox_Type;  
         Barro    : Editbox_Type;  
         Hierro   : Editbox_Type; 
         Cereal   : Editbox_Type;  
      end record; 

   type Casillas_Recursos_Perdidos is array (positive range <>) of T_Recursos; 

   type T_Grupo is 
      record 
         Tropas   : Editbox_Type;  
         Perdidas : Editbox_Type;
         Nivel    : Editbox_Type;   
      end record; 

   type Casillas_Ejercito is array (positive range <>) of T_Grupo; 
   type Casillas_Dibujo is array (positive range <>) of Canvas_Type; 

   -- Ventana principal
   Principal : Frame_Type := Frame (920, 600, Nombre_Programa, 'X');  

   -- Menu
   Menu_archivo     : Menu_Type       := Menu (Principal, Texto_Menuarchivo);  
   Menu_Ayuda       : Menu_Type       := Menu (Principal, Texto_Menuayuda);  
   Informe         : Menuitem_Type    := Menuitem (Menu_archivo, Texto_Informe, 'I');   
   Salir           : Menuitem_Type    := Menuitem (Menu_archivo, Texto_salir, 'S');  
   Acercade        : Menuitem_Type    := Menuitem (Menu_ayuda, Texto_acercade, 'A');  

   -- Menu Agresor
   Pueblo : T_Pueblos := Romanos;  

   Panel_Agresor : Panel_Type  := Panel (Principal, (15, 10), 710, 140, Nom_Agresor);  
   B_Romanos     : Button_Type := Button (Panel_Agresor, (600, 20), 100, 25, Nom_Romanos , 'R');  
   B_Galos       : Button_Type := Button (Panel_Agresor, (600, 50), 100, 25, Nom_Galos , 'G');  
   B_Germanos    : Button_Type := Button (Panel_Agresor, (600, 80), 100, 25, Nom_Germanos , 'M');  

   Dibujo_Agresor:Casillas_Dibujo:=(
      Canvas (Panel_Agresor, (100, 20), 18, 18),
      Canvas (Panel_Agresor, (150, 20), 18, 18),
      Canvas (Panel_Agresor, (200, 20), 18, 18),
      Canvas (Panel_Agresor, (250, 20), 18, 18),
      Canvas (Panel_Agresor, (300, 20), 18, 18),
      Canvas (Panel_Agresor, (350, 20), 18, 18),      
      Canvas (Panel_Agresor, (400, 20), 18, 18),
      Canvas (Panel_Agresor, (450, 20), 18, 18),
      Canvas (Panel_Agresor, (500, 20), 18, 18),
      Canvas (Panel_Agresor, (550, 20), 18, 18)
                );



   Casillas_Tropas_Agresor : Casillas_Ejercito := (
      (Editbox (Panel_Agresor, (90, 45), 40, 20, ""), Editbox (Panel_Agresor, (90, 64), 40, 20, ""), Editbox (Panel_Agresor, (90, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (140, 45), 40, 20, ""), Editbox (Panel_Agresor, (140, 64), 40, 20, ""), Editbox (Panel_Agresor, (140, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (190, 45), 40, 20, ""), Editbox (Panel_Agresor, (190, 64), 40, 20, ""), Editbox (Panel_Agresor, (190, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (240, 45), 40, 20, ""), Editbox (Panel_Agresor, (240, 64), 40, 20, ""), Editbox (Panel_Agresor, (240, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (290, 45), 40, 20, ""), Editbox (Panel_Agresor, (290, 64), 40, 20, ""), Editbox (Panel_Agresor, (290, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (340, 45), 40, 20, ""), Editbox (Panel_Agresor, (340, 64), 40, 20, ""), Editbox (Panel_Agresor, (340, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (390, 45), 40, 20, ""), Editbox (Panel_Agresor, (390, 64), 40, 20, ""), Editbox (Panel_Agresor, (390, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (440, 45), 40, 20, ""), Editbox (Panel_Agresor, (440, 64), 40, 20, ""), Editbox (Panel_Agresor, (440, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (490, 45), 40, 20, ""), Editbox (Panel_Agresor, (490, 64), 40, 20, ""), Editbox (Panel_Agresor, (490, 83), 40, 20, "")),
      (Editbox (Panel_Agresor, (540, 45), 40, 20, ""), Editbox (Panel_Agresor, (540, 64), 40, 20, ""), Editbox (Panel_Agresor, (540, 83), 40, 20, "")));  

   L_Tropas : Label_Type := Label (Panel_Agresor, (25, 50), 60, 20, Nom_tropas);  

   L_Perdidas: Label_Type := Label (Panel_Agresor, (25, 66), 60, 20, Nom_perdidas);  

   L_Nivel: Label_Type := Label (Panel_Agresor, (25, 85), 60, 20, nom_nivel);  

   L_Habitantes_Agresor : Label_Type   := Label (Panel_Agresor, (25, 115), 80, 20, nom_habitantes);  
   Edit_Hab_Agresor     : Editbox_Type := Editbox (Panel_Agresor, (115, 110), 40, 20, "");  

   -- Menu Defensor
   Panel_Defensor : Panel_Type := Panel (Principal, (15, 160), 710, 310, Nom_Defensores);  


   -- Defensores romanos
   
   Dibujo_Defensor_Romano :Casillas_Dibujo:=(
      Canvas (Panel_Defensor, (100, 30), 18, 18),
      Canvas (Panel_Defensor, (150, 30), 18, 18),
      Canvas (Panel_Defensor, (200, 30), 18, 18),
      Canvas (Panel_Defensor, (250, 30), 18, 18),
      Canvas (Panel_Defensor, (300, 30), 18, 18),
      Canvas (Panel_Defensor, (350, 30), 18, 18),      
      Canvas (Panel_Defensor, (400, 30), 18, 18),
      Canvas (Panel_Defensor, (450, 30), 18, 18),
      Canvas (Panel_Defensor, (500, 30), 18, 18),
      Canvas (Panel_Defensor, (550, 30), 18, 18)
                );

   Casillas_Tropas_Defensor_Romano: Casillas_Ejercito := (
      (Editbox (Panel_Defensor, (90, 55), 40, 20, ""),Editbox (Panel_Defensor, (90, 74), 40, 20, ""),Editbox (Panel_Defensor, (90, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (140, 55), 40, 20, ""),Editbox (Panel_Defensor, (140, 74), 40, 20, ""),Editbox (Panel_Defensor, (140, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (190, 55), 40, 20, ""),Editbox (Panel_Defensor, (190, 74), 40, 20, ""),Editbox (Panel_Defensor, (190, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (240, 55), 40, 20, ""),Editbox (Panel_Defensor, (240, 74), 40, 20, ""),Editbox (Panel_Defensor, (240, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (290, 55), 40, 20, ""),Editbox (Panel_Defensor, (290, 74), 40, 20, ""),Editbox (Panel_Defensor, (290, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (340, 55), 40, 20, ""),Editbox (Panel_Defensor, (340, 74), 40, 20, ""),Editbox (Panel_Defensor, (340, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (390, 55), 40, 20, ""),Editbox (Panel_Defensor, (390, 74), 40, 20, ""),Editbox (Panel_Defensor, (390, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (440, 55), 40, 20, ""),Editbox (Panel_Defensor, (440, 74), 40, 20, ""),Editbox (Panel_Defensor, (440, 93), 40, 20, "")),
      (Editbox (Panel_Defensor, (490, 55), 40, 20, ""),Editbox (Panel_Defensor, (490, 74), 40, 20, ""),Editbox (Panel_Defensor, (490, 93), 40, 20, "")),         
      (Editbox (Panel_Defensor, (540, 55), 40, 20, ""),Editbox (Panel_Defensor, (540, 74), 40, 20, ""),Editbox (Panel_Defensor, (540, 93), 40, 20, ""))
   );  



   L_Defensa_Romana : Label_Type   := Label (Panel_Defensor, (25, 35), 60, 20, Nom_romanos);  
   L_Dtropas        : Label_Type   := Label (Panel_Defensor, (25, 60), 60, 20, Nom_tropas); 
   L_Perdidas1: Label_Type   := Label (Panel_Defensor, (25, 79), 60, 20, Nom_Perdidas);  
   L_Nivel1: Label_Type   := Label (Panel_Defensor, (25, 98), 60, 20, Nom_Nivel);  


   -- Defensores Germanos
   
   Dibujo_Defensor_Germano:Casillas_Dibujo:=(
      Canvas (Panel_Defensor, (100, 120), 18, 18),
      Canvas (Panel_Defensor, (150, 120), 18, 18),
      Canvas (Panel_Defensor, (200, 120), 18, 18),
      Canvas (Panel_Defensor, (250, 120), 18, 18),
      Canvas (Panel_Defensor, (300, 120), 18, 18),
      Canvas (Panel_Defensor, (350, 120), 18, 18),      
      Canvas (Panel_Defensor, (400, 120), 18, 18),
      Canvas (Panel_Defensor, (450, 120), 18, 18),
      Canvas (Panel_Defensor, (500, 120), 18, 18),
      Canvas (Panel_Defensor, (550, 120), 18, 18)
                );



   Casillas_Tropas_Defensor_Germano: Casillas_Ejercito := (
      (Editbox (Panel_Defensor, (90, 145), 40, 20, ""),Editbox (Panel_Defensor, (90, 164), 40, 20, ""),Editbox (Panel_Defensor, (90, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (140, 145), 40, 20, ""),Editbox (Panel_Defensor, (140, 164), 40, 20, ""),Editbox (Panel_Defensor, (140, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (190, 145), 40, 20, ""),Editbox (Panel_Defensor, (190, 164), 40, 20, ""),Editbox (Panel_Defensor, (190, 183), 40, 20, "")), 
      (Editbox (Panel_Defensor, (240, 145), 40, 20, ""),Editbox (Panel_Defensor, (240, 164), 40, 20, ""),Editbox (Panel_Defensor, (240, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (290, 145), 40, 20, ""),Editbox (Panel_Defensor, (290, 164), 40, 20, ""),Editbox (Panel_Defensor, (290, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (340, 145), 40, 20, ""),Editbox (Panel_Defensor, (340, 164), 40, 20, ""),Editbox (Panel_Defensor, (340, 183), 40, 20, "")), 
      (Editbox (Panel_Defensor, (390, 145), 40, 20, ""),Editbox (Panel_Defensor, (390, 164), 40, 20, ""),Editbox (Panel_Defensor, (390, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (440, 145), 40, 20, ""),Editbox (Panel_Defensor, (440, 164), 40, 20, ""),Editbox (Panel_Defensor, (440, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (490, 145), 40, 20, ""),Editbox (Panel_Defensor, (490, 164), 40, 20, ""),Editbox (Panel_Defensor, (490, 183), 40, 20, "")),
      (Editbox (Panel_Defensor, (540, 145), 40, 20, ""),Editbox (Panel_Defensor, (540, 164), 40, 20, ""),Editbox (Panel_Defensor, (540, 183), 40, 20, ""))         
         
   );  
   L_Defensa_Germana : Label_Type   := Label (Panel_Defensor, (25, 125), 60, 20, Nom_germanos);  
   L_Dtropas2        : Label_Type   := Label (Panel_Defensor, (25, 150), 60, 20, Nom_tropas);  
   L_Perdidas2: Label_Type   := Label (Panel_Defensor, (25, 169), 60, 20, Nom_Perdidas);  
   L_Nivel2: Label_Type   := Label (Panel_Defensor, (25, 188), 60, 20, Nom_Nivel);  

   -- Defensores Galos
   
   Dibujo_Defensor_Galo:Casillas_Dibujo:=(
      Canvas (Panel_Defensor, (100, 210), 18, 18),
      Canvas (Panel_Defensor, (150, 210), 18, 18),
      Canvas (Panel_Defensor, (200, 210), 18, 18),
      Canvas (Panel_Defensor, (250, 210), 18, 18),
      Canvas (Panel_Defensor, (300, 210), 18, 18),
      Canvas (Panel_Defensor, (350, 210), 18, 18),   
      Canvas (Panel_Defensor, (400, 210), 18, 18),
      Canvas (Panel_Defensor, (450, 210), 18, 18),   
      Canvas (Panel_Defensor, (500, 210), 18, 18),
      Canvas (Panel_Defensor, (550, 210), 18, 18)
                            );
  
   Casillas_Tropas_Defensor_Galo: Casillas_Ejercito := (
      (Editbox (Panel_Defensor, (90, 235), 40, 20, ""),Editbox (Panel_Defensor, (90, 254), 40, 20, ""),Editbox (Panel_Defensor, (90, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (140, 235), 40, 20, ""),Editbox (Panel_Defensor, (140, 254), 40, 20, ""),Editbox (Panel_Defensor, (140, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (190, 235), 40, 20, ""),Editbox (Panel_Defensor, (190, 254), 40, 20, ""),Editbox (Panel_Defensor, (190, 273), 40, 20, "")),   
      (Editbox (Panel_Defensor, (240, 235), 40, 20, ""),Editbox (Panel_Defensor, (240, 254), 40, 20, ""),Editbox (Panel_Defensor, (240, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (290, 235), 40, 20, ""),Editbox (Panel_Defensor, (290, 254), 40, 20, ""),Editbox (Panel_Defensor, (290, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (340, 235), 40, 20, ""),Editbox (Panel_Defensor, (340, 254), 40, 20, ""),Editbox (Panel_Defensor, (340, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (390, 235), 40, 20, ""),Editbox (Panel_Defensor, (390, 254), 40, 20, ""),Editbox (Panel_Defensor, (390, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (440, 235), 40, 20, ""),Editbox (Panel_Defensor, (440, 254), 40, 20, ""),Editbox (Panel_Defensor, (440, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (490, 235), 40, 20, ""),Editbox (Panel_Defensor, (490, 254), 40, 20, ""),Editbox (Panel_Defensor, (490, 273), 40, 20, "")),
      (Editbox (Panel_Defensor, (540, 235), 40, 20, ""),Editbox (Panel_Defensor, (540, 254), 40, 20, ""),Editbox (Panel_Defensor, (540, 273), 40, 20, ""))       
   ); 
   L_Defensa_Gala : Label_Type   := Label (Panel_Defensor, (25, 215), 60, 20, Nom_galos);  
   L_Dtropas3     : Label_Type   := Label (Panel_Defensor, (25, 240), 60, 20, Nom_tropas);  
   L_Perdidas3: Label_Type   := Label (Panel_Defensor, (25, 259), 60, 20,Nom_Perdidas);  
   L_Nivel3: Label_Type   := Label (Panel_Defensor, (25, 278), 60, 20, Nom_Nivel);  


   L_Habitantes_Defensor : Label_Type   := Label (Panel_Defensor, (615, 37), 80, 20, Nom_habitantes);  
   Edit_Hab_Defensor     : Editbox_Type := Editbox (Panel_Defensor, (623, 55), 40, 20, "");  
   L_Palacio_Defensor    : Label_Type   := Label (Panel_Defensor, (623, 90), 80, 20, Nom_Palacio);  
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
         
      Canvas (Panel_Perdidas, (20, 185), 18, 18),
      Canvas (Panel_Perdidas, (20, 205), 18, 18),
      Canvas (Panel_Perdidas, (20, 225), 18, 18),
      Canvas (Panel_Perdidas, (20, 245), 18, 18),
         
      Canvas (Panel_Perdidas, (20, 275), 18, 18),
      Canvas (Panel_Perdidas, (20, 295), 18, 18),
      Canvas (Panel_Perdidas, (20, 315), 18, 18),
      Canvas (Panel_Perdidas, (20, 335), 18, 18),
         
      Canvas (Panel_Perdidas, (20, 365), 18, 18),
      Canvas (Panel_Perdidas, (20, 385), 18, 18),
      Canvas (Panel_Perdidas, (20, 405), 18, 18),
      Canvas (Panel_Perdidas, (20, 425), 18, 18) 
                );

   Recursos_Perdidos: Casillas_Recursos_Perdidos := (
      (Editbox (Panel_Perdidas, (55, 24), 80, 21, ""),Editbox (Panel_Perdidas, (55, 44), 80, 21, ""),Editbox (Panel_Perdidas, (55, 64), 80,21, ""),Editbox (Panel_Perdidas, (55, 84), 80, 21, "")),
      (Editbox (Panel_Perdidas, (55, 184), 80, 21, ""),Editbox (Panel_Perdidas, (55, 204), 80, 21, ""),Editbox (Panel_Perdidas, (55, 224), 80, 21, ""),Editbox (Panel_Perdidas, (55, 244), 80, 21, "")),
      (Editbox (Panel_Perdidas, (55, 274), 80, 21, ""),Editbox (Panel_Perdidas, (55, 294), 80, 21, ""),Editbox (Panel_Perdidas, (55, 314), 80,21, ""),Editbox (Panel_Perdidas, (55, 334), 80, 21, "")),
      (Editbox (Panel_Perdidas, (55, 364), 80, 21, ""),Editbox (Panel_Perdidas, (55, 384), 80, 21, ""),Editbox (Panel_Perdidas, (55, 404), 80, 21, ""),Editbox (Panel_Perdidas, (55, 424), 80, 21, ""))

         
   );  

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
   
   B_Borrar : Button_Type := Button (Principal, (755, 497), 125, 25, Nom_Borrar, 'W');  

   -- Informe de combate
   Hacer_informe: Boolean:=False;

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
      Set_text(Edit_Aldea_AgresoraX,"");    
   end Limpiar;

   procedure Acerca_de is
      separate;

   procedure Cargar_Imagenes is 
      separate;
      
   procedure Realizar_Calculos is 
      separate;

   -- Concurrencia
   task C_Calcular_perdidas;
   task body C_Calcular_perdidas is
   begin 
       Realizar_Calculos; 
   end C_Calcular_perdidas;

begin

   -- Inicializar
   Set_Origin(Principal,(50,50));
   Show (Principal);
   Disable(Edit_Tiempo_llegada);
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

    Cargar_Imagenes;

   ---------------
   loop

      case Next_Command is
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
         when 'X' =>
            exit;
         when 'S' =>
            exit;
         when 'A' =>
            Acerca_De;
         when 'I' =>
            Hacer_informe:=True;
         when others=>
            null;

      end case;
   end loop;

   abort C_Calcular_perdidas;

end Travian_Combat;