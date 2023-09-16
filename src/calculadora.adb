----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' and its subprograms, as this calculator,
--   is distributed  in the  hope  that  it will be useful, but WITHOUT ANY  WARRANTY; 
--   without even the implied warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------
with Jewl.Simple_Windows,Interfaces.C;
use Jewl.Simple_Windows;


with Traduccion;
use Traduccion;
with Traduccion_Gui;
use Traduccion_Gui;
with Tablas;
use Tablas;

with adaIntl; use adaintl;



procedure Calculadora is 



   TC_Calc: Internationalization_Type:= Initialize_Adaintl (
         Language                => En,             
         Default_Domain          => "GUI_Translation", 
         Debug_Mode              => No_Debug,   
         Directory               => "locale/",         
         Load_Configuration_File => "config/Language.dat"          ); 

   -- Con estos pragmas evitamos que aparezca la consola de fondo :P
   pragma Linker_Options ("-mwindows");
   pragma Linker_Options ("-luser32");
   pragma Linker_Options ("-lgdi32");

   -- Añadimos el icono
   pragma Linker_Options("galo.o");

   Ven_Calculadora : Frame_Type := Frame (800, 600, Encabezado_Calculadora, 'Z'); 
   
   Numero_Aldeas_futuras: constant natural:= 6;

   Menu_Archivo  : Menu_Type       := Menu (Ven_Calculadora, Texto_Menuarchivo);
   Menu_Ayuda       : Menu_Type       := Menu (Ven_Calculadora, Texto_Menuayuda);   

   Menu_Plantilla  : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Plantilla, 't');    
   Separator4      : Menuitem_Type    := Separator(Menu_Archivo);     
   Menu_Guardar    : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Guardar, 'g');  
   Menu_Cargar     : Menuitem_Type    := Menuitem (Menu_Archivo, Nom_Menu_Cargar, 'c');
   Separator1      : Menuitem_Type    := Separator(Menu_Archivo);      
   Salir           : Menuitem_Type    := Menuitem (Menu_archivo, Texto_salir, 'S');   
   Acercade        : Menuitem_Type    := Menuitem (Menu_ayuda, Texto_acercade, 'a');  


   Panel_Recursos : Panel_Type := Panel (Ven_Calculadora, (10, 10), 770, 250, Nom_Recursos);  
   Panel_Cultura  : Panel_Type := Panel (Ven_Calculadora, (10, 275), 770, 260, Nom_Cultura);  


   -- Recursos 
   type T_Recursos is 
      record 
         Madera : Editbox_Type;  
         Barro  : Editbox_Type;  
         Hierro : Editbox_Type;  
         Cereal : Editbox_Type;  
      end record; 
   type Vector_Imgs_Recursos is array (Positive range <>) of Image_Type; 
   type Vector_Canvas_Recursos is array (Positive range <>) of Canvas_Type; 
   type Casillas_Recursos is array (Positive range <>) of T_Recursos; 


   Rutas_Imagenes : Vector_Imgs_Recursos := (Image ("imgs/madera.bmp"), Image ("imgs/barro.bmp"), Image ("imgs/hierro.bmp"), Image ("imgs/cereal.bmp"));  

   Boton_Borrar            : Button_Type := Button (Panel_Recursos, (465, 115), 140, 25, Nom_Borrar, 'B');  
   Boton_Borrar_Produccion : Button_Type := Button (Panel_Recursos, (465, 155), 140, 25, Nom_Borrar_Produccion, 'M');  
   Boton_Produccion        : Button_Type := Button (Panel_Recursos, (465, 195), 140, 25, Nom_Produccion_Max, 'P');  

   Etiqueta_Fin        : Label_Type := Label (Panel_Recursos, (20, 170), 250, 20, Texto_Construccion_Posible);  
   Etiqueta_Fin_Exacto : Label_Type := Label (Panel_Recursos, (20, 190), 250, 20, " ");  

   Panel_Rec_Actuales   : Panel_Type := Panel (Panel_Recursos, (15, 20), 430, 55, Texto_Recursos_Actuales);  
   Panel_Rec_Necesarios : Panel_Type := Panel (Panel_Recursos, (15, 85), 430, 55, Texto_Recursos_Necesarios);  
   Panel_Produccion     : Panel_Type := Panel (Panel_Recursos, (625, 100), 125, 130, Texto_Produccion);  
   Panel_Sobras         : Panel_Type := Panel (Panel_Recursos, (465, 20), 285, 75, Texto_Sobras_Materiales);  

 Recursos_Img : Vector_Canvas_Recursos := (
      Canvas (Panel_Rec_Actuales, (16, 25), 18, 18),
      Canvas (Panel_Rec_Actuales, (116, 25), 18, 18),
      Canvas (Panel_Rec_Actuales, (216, 25), 18, 18),
      Canvas (Panel_Rec_Actuales, (316, 25), 18, 18),
      Canvas (Panel_Rec_Necesarios, (16, 25), 18, 18),
      Canvas (Panel_Rec_Necesarios, (116, 25), 18, 18),
      Canvas (Panel_Rec_Necesarios, (216, 25), 18, 18),
      Canvas (Panel_Rec_Necesarios, (316, 25), 18, 18),
      Canvas (Panel_Produccion, (16, 25), 18, 18),
      Canvas (Panel_Produccion, (16, 50), 18, 18),
      Canvas (Panel_Produccion, (16, 75), 18, 18),
      Canvas (Panel_Produccion, (16, 100), 18, 18),
      Canvas (Panel_Sobras, (15, 25), 18, 18),
      Canvas (Panel_Sobras, (15, 45), 18, 18),
      Canvas (Panel_Sobras, (160, 25), 18, 18),
      Canvas (Panel_Sobras, (160, 45), 18, 18)
                  );  

   Boxes_Recursos : Casillas_Recursos := ((
         Editbox (Panel_Rec_Actuales, (40, 24), 70, 20, ""),
         Editbox (Panel_Rec_Actuales, (140, 24), 70, 20, ""),
         Editbox (Panel_Rec_Actuales, (240, 24), 70, 20, ""),
         Editbox (Panel_Rec_Actuales, (340, 24), 70, 20, "")),
      (Editbox (Panel_Rec_Necesarios, (40, 24), 70, 20, ""),
         Editbox (Panel_Rec_Necesarios, (140, 24), 70, 20, ""),
         Editbox (Panel_Rec_Necesarios, (240, 24), 70, 20, ""),
         Editbox (Panel_Rec_Necesarios, (340, 24), 70, 20, "")),
      (Editbox (Panel_Produccion, (40, 24), 40, 20, ""),
         Editbox (Panel_Produccion, (40, 49), 40, 20, ""),
         Editbox (Panel_Produccion, (40, 74), 40, 20, ""),
         Editbox (Panel_Produccion, (40, 99), 40, 20, "")),
      (Editbox (Panel_Sobras, (35, 25), 70, 18, ""),
         Editbox (Panel_Sobras, (35, 45), 70, 18, ""),
         Editbox (Panel_Sobras, (180, 25), 70, 18, ""),
         Editbox (Panel_Sobras, (180, 45), 70, 18, "")));
           


   -- Cultura
   Panel_Datos_cultura : Panel_Type := Panel (Panel_Cultura, (15, 20), 625, 55, Nom_Datos);     
   Panel_Ayuntamientos : Panel_Type := Panel (Panel_Cultura, (15, 80), 740, 75, Nom_Ayuntamientos_por_nivel); 
   
   Boton_Borrar_Cultura: Button_Type := Button (Panel_Cultura, (655, 27), 100, 23, Nom_Borrar, 'A'); 

   Numero_Aldeas_Label : Label_Type:= Label(Panel_Datos_Cultura, (15, 25), 130, 20, Nom_Numero_Aldeas & ":");
   Numero_Aldeas       : Editbox_Type:= Editbox (Panel_Datos_Cultura, (145, 22), 35, 20, "1");
   
   Cultura_Actual_Label: Label_Type:= Label(Panel_Datos_Cultura, (210, 25), 100, 20,Nom_Cultura_Actual & ":");
   Cultura_Actual      : Editbox_Type:= Editbox (Panel_Datos_Cultura, (310, 22), 70, 20, "0");
   
   Produccion_Cultura_Label: Label_Type:= Label(Panel_Datos_Cultura, (425, 25), 120, 20, Nom_Produccion_Diaria & ":");
   Produccion_Cultura      : Editbox_Type:= Editbox (Panel_Datos_Cultura, (545, 22), 50, 20, "0");

   type Vector_Edit_Numero_Ayuntamientos is array (1.. Max_Niveles_Ayuntamiento) of Editbox_Type;
   type Vector_Label_Ayuntamientos is array (1.. Max_Niveles_Ayuntamiento) of Label_Type;
   
   Label_Nivel_Ayuntamiento :Vector_Label_Ayuntamientos:= (
         Label(Panel_Ayuntamientos, (20+0*35, 22), 36, 20, "1", center),
         Label(Panel_Ayuntamientos, (20+1*35, 22), 36, 20, "2", Center),
         Label(Panel_Ayuntamientos, (20+2*35, 22), 36, 20, "3", center),
         Label(Panel_Ayuntamientos, (20+3*35, 22), 36, 20, "4", Center),
         Label(Panel_Ayuntamientos, (20+4*35, 22), 36, 20, "5", center),
         Label(Panel_Ayuntamientos, (20+5*35, 22), 36, 20, "6", center),
         Label(Panel_Ayuntamientos, (20+6*35, 22), 36, 20, "7", center),
         Label(Panel_Ayuntamientos, (20+7*35, 22), 36, 20, "8", Center),
         Label(Panel_Ayuntamientos, (20+8*35, 22), 36, 20, "9", center),
         Label(Panel_Ayuntamientos, (20+9*35, 22), 36, 20, "10", Center),
         Label(Panel_Ayuntamientos, (20+10*35, 22), 36, 20, "11", center),
         Label(Panel_Ayuntamientos, (20+11*35, 22), 36, 20, "12", Center),
         Label(Panel_Ayuntamientos, (20+12*35, 22), 36, 20, "13", center),
         Label(Panel_Ayuntamientos, (20+13*35, 22), 36, 20, "14", center),
         Label(Panel_Ayuntamientos, (20+14*35, 22), 36, 20, "15", Center),
         Label(Panel_Ayuntamientos, (20+15*35, 22), 36, 20, "16", center),
         Label(Panel_Ayuntamientos, (20+16*35, 22), 36, 20, "17", Center),
         Label(Panel_Ayuntamientos, (20+17*35, 22), 36, 20, "18", center),
         Label(Panel_Ayuntamientos, (20+18*35, 22), 36, 20, "19", Center),
         Label(Panel_Ayuntamientos, (20+19*35, 22), 36, 20, "20", Center)  );
   
   Datos_Ayuntamiento : Vector_Edit_Numero_Ayuntamientos:= (
         Editbox (Panel_Ayuntamientos, (20+0*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+1*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+2*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+3*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+4*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+5*35, 40), 36, 20, ""),        
         Editbox (Panel_Ayuntamientos, (20+6*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+7*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+8*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+9*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+10*35, 40), 36, 20, ""),        
         Editbox (Panel_Ayuntamientos, (20+11*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+12*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+13*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+14*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+15*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+16*35, 40), 36, 20, ""),        
         Editbox (Panel_Ayuntamientos, (20+17*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+18*35, 40), 36, 20, ""),
         Editbox (Panel_Ayuntamientos, (20+19*35, 40), 36, 20, "")
         );


   Label_Info_N_Aldea : Label_Type:= Label (Panel_Cultura, (20,165),50,20, Nom_Aldea & ":");
   Label_Info_N_Aldea2: Label_Type:= Label (Panel_Cultura, (380,165),50,20, Nom_Aldea & ":");  
   
   Label_Info_PC_Necesarios : Label_Type:= Label (Panel_Cultura, (70,165),130,20,Nom_PC_Necesarios);
   Label_Info_Pc_Necesarios2: Label_Type:= Label (Panel_Cultura, (430,165),130,20,Nom_PC_Necesarios);
   
   Label_Info_Disponible : Label_Type:= Label (Panel_Cultura, (175,165),150,20, Texto_Construccion_Disponible);
   Label_Info_Disponible2: Label_Type:= Label (Panel_Cultura, (535,165),150,20, Texto_Construccion_Disponible); 
   
   type Vector_Aldeas_Futuras_Info is array (1..Numero_Aldeas_futuras) of Label_Type;


   Edit_Info_Aldeas_Futuras : Vector_Aldeas_Futuras_Info:= (
         Label   (Panel_Cultura, (25, 185), 36, 21, "-"),
         Label   (Panel_Cultura, (25, 205), 36, 21, "-"),
         Label   (Panel_Cultura, (25, 225), 36, 21, "-"),
         Label   (Panel_Cultura, (385, 185), 36, 21, "-"),
         Label   (Panel_Cultura, (385, 205), 36, 21, "-"),
         Label   (Panel_Cultura, (385, 225), 36, 21, "-"));  

   Label_PC_Necesaria : Vector_Aldeas_Futuras_Info:= (
         Label   (Panel_Cultura, (75, 185), 80, 21, "-"),
         Label   (Panel_Cultura, (75, 205), 80, 21, "-"),
         Label   (Panel_Cultura, (75, 225), 80, 21, "-"),
         Label   (Panel_Cultura, (435, 185), 80, 21, "-"),
         Label   (Panel_Cultura, (435, 205), 80, 21, "-"),
         Label   (Panel_Cultura, (435, 225), 80, 21, "-"));   

   Label_Disponible: Vector_Aldeas_Futuras_Info:= (
         Label   (Panel_Cultura, (180, 185), 200, 21, "-"),
         Label   (Panel_Cultura, (180, 205), 200, 21, "-"),
         Label   (Panel_Cultura, (180, 225), 200, 21, "-"),
         Label   (Panel_Cultura, (540, 185), 200, 21, "-"),
         Label   (Panel_Cultura, (540, 205), 200, 21, "-"),
         Label   (Panel_Cultura, (540, 225), 200, 21, "-"));   


   Version_Travian: T_Version_Travian:=V2;

   L_Version_Travian   : Label_Type   := Label (Panel_Cultura, (653, 55), 60, 20, Travian_V2); 
   B_Cambiar_Version   : Button_Type  := Button(Panel_Cultura,(715,52),40,23, Vx, 'V');

   procedure Recursos is 
   separate;
   procedure Cultura is 
   separate;

   procedure Guardar_Cargar(Guardar: Boolean;
                            Ruta   : String) is
      separate;
      
   procedure Plantilla (Guardar: Boolean) is
      separate;
   
   procedure Acerca_De is separate;


begin

   Show(Ven_Calculadora);

   Disable(Boxes_Recursos(4).Cereal);
   Disable(Boxes_Recursos(4).Hierro);
   Disable(Boxes_Recursos(4).Barro);
   Disable(Boxes_Recursos(4).Madera);

   Plantilla (false);  -- Cargamos la plantilla si existe

   -- Imagenes
   for I in 0..15 loop
      if Valid(Rutas_Imagenes((I mod 4)+1)) then
         Draw_Image(Recursos_Img(I+1),(0,0),(Width(Rutas_Imagenes((I mod 4)+1)),Height(Rutas_Imagenes((I mod 4)+1))),Rutas_Imagenes((I mod 4)+1));
      end if;
   end loop;



   loop
      Cultura;
      Recursos;
      if Command_Ready then
         case Next_Command is
            when 'Z'=>
               exit;
            when 'S'=>
               exit;
            when 'A' =>               
               for I in 1..Max_Niveles_Ayuntamiento loop
                  Set_Text(Datos_Ayuntamiento(I)," ");
               end loop;    
               Set_Text(Numero_Aldeas,"1");
               Set_Text(Cultura_Actual,"0");                                        
               Set_Text(Produccion_Cultura,"0");             
            when 'B'=>
               for I in 1..2 loop
                  Set_Text(Boxes_Recursos(I).Cereal," ");
                  Set_Text(Boxes_Recursos(I).Hierro," ");
                  Set_Text(Boxes_Recursos(I).Barro," ");
                  Set_Text(Boxes_Recursos(I).Madera," ");
               end loop;
            when 'M'=>
               Set_Text(Boxes_Recursos(3).Cereal," ");
               Set_Text(Boxes_Recursos(3).Hierro," ");
               Set_Text(Boxes_Recursos(3).Barro," ");
               Set_Text(Boxes_Recursos(3).Madera," ");
            when 'P'=>
               Set_Text(Boxes_Recursos(3).Cereal,"1000");
               Set_Text(Boxes_Recursos(3).Hierro,"1000");
               Set_Text(Boxes_Recursos(3).Barro, "1000");
               Set_Text(Boxes_Recursos(3).Madera,"1000");

               
         when 'c' =>
            Guardar_Cargar(False, ("GUI_Translation"-"config/Quicksave") & ("GUI_Translation"-".rdf")); -- CARGAR
         when 'g' =>
            Guardar_Cargar(True, ("GUI_Translation"-"config/Quicksave") & ("GUI_Translation"-".rdf")); -- GUARDAR   
         when 't' =>
            Plantilla (true); -- PLANTILLA  

         when 'a'=>
               Acerca_de;
         when 'V' =>
             case Version_Travian is
             when V2 =>
              Version_Travian:=V3;  
              Set_Text(L_Version_Travian, Travian_V3);    
             when V3 =>
              Version_Travian:=V2;
              Set_Text(L_Version_Travian, Travian_V2);
               end case;  
               
            when others=>
               null;
         end case;
      end if;
   end loop;

   Hide(Ven_Calculadora);



exception
   when Interfaces.C.Terminator_Error=>
      null;


end Calculadora;
