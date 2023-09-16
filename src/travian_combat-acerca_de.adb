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


separate(Travian_Combat)
   
procedure Acerca_de is 

   Ven_acerca:          Frame_Type := Frame (350, 200, "Simulador de Batallas de Travian", 'Z');  

        
   Logo: Canvas_type:=Canvas (ven_acerca, (15, 50), 159, 60);
   Logo_img: Image_type:= Image ("imgs/logo.bmp");
        
   Info_Txt : constant String     :=
           
       " Realizado por Andres_age y liberado bajo licencia GPL     "
      & "                                                           "
      & "  Contacto:            "       
      & "          andres.age @ gmail.com                           "
      & "                                                                                       ";
      

   Texto1    :Label_Type  := Label (Ven_acerca, (50, 10), 280, 30, Nombre_programa, Left);  
   Texto2    :Label_Type  := Label (Ven_Acerca, (190, 30), 140, 100, Info_Txt, Left); 
   B_Volver :Button_Type := Button (Ven_Acerca, (65, 130), 65, 25, "Volver", 'v');
   Situacion_ventana:Point_Type;

begin
   Situacion_Ventana:=Get_Origin(Principal);
   Set_Origin(Ven_Acerca,
      (Situacion_Ventana.X+(Get_Width(Principal)/2)-(Get_Width(Ven_Acerca)/2),
         Situacion_Ventana.Y+(Get_Height(Principal)/2)-(Get_Height(Ven_Acerca)/2)));

   Show(Ven_Acerca);
   if Valid(logo_img) then
     Draw_Image(logo,(0,0),(Width(logo_img),Height(logo_img)),logo_img);
   end if;
   loop
     case Next_Command is
         when 'Z'=> exit;
         when 'v'=> exit;
         when others=> null;
     end case;
   end loop;     
   Hide(Ven_acerca);


end Acerca_de;
