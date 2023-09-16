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


separate(simulador)

procedure Acerca_De is 

   Ven_Acerca : Frame_Type := Frame (385, 200, -"Travian Battle Simulator", 'Z');  

   Logo     : Canvas_Type := Canvas (Ven_Acerca, (15, 50), 159, 60);  
   Logo_Img : Image_Type  := Image ("imgs/logo.bmp");  

   Info_Txt : constant String := -"Made by Andres_age and released under the GPL";  
   Email    : constant String := "    andres.age @ gmail.com ";  

   Texto1            : Label_Type  := Label (Ven_Acerca, (50, 10), 280, 30, Nombre_Simulador, Left);  
   Texto2            : Label_Type  := Label (Ven_Acerca, (190, 45), 160, 50, Info_Txt, Left);  
   LEmail             : Label_Type  := Label (Ven_Acerca, (190, 95), 160, 50, Email, Left);  
   B_Volver          : Button_Type := Button (Ven_Acerca, (65, 130), 65, 25, -"Return", 'v');  
   Situacion_Ventana : Point_Type;  

begin
   Situacion_Ventana:=Get_Origin(Principal);
   Set_Origin(Ven_Acerca,
      (Situacion_Ventana.X+(Get_Width(Principal)/2)-(Get_Width(Ven_Acerca)/2),
         Situacion_Ventana.Y+(Get_Height(Principal)/2)-(Get_Height(Ven_Acerca)/2)));
   Hide(Principal);
   Show(Ven_Acerca);
   if Valid(Logo_Img) then
      Draw_Image(Logo,(0,0),(Width(Logo_Img),Height(Logo_Img)),Logo_Img);
   end if;
   loop
      case Next_Command is
         when 'Z'=>
            exit;
         when 'v'=>
            exit;
         when others=>
            null;
      end case;
   end loop;
   Hide(Ven_Acerca);
   Show(Principal);

end acerca_de;
