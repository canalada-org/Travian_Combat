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

separate(Coordinador)

procedure Cargar_Imagenes_y_bloquear_campos is 
Rutas_Imagenes : Vector_Image:= (Image ("imgs/1.bmp"),
        Image ("imgs/2.bmp"),
        Image ("imgs/3.bmp"),
        Image ("imgs/4.bmp"),
        Image ("imgs/5.bmp"),
        Image ("imgs/6.bmp"),
        Image ("imgs/7.bmp"),
        Image ("imgs/8.bmp"),
        Image ("imgs/9.bmp"),
        Image ("imgs/10.bmp"),
        Image ("imgs/11.bmp"),
        Image ("imgs/12.bmp"),
        Image ("imgs/13.bmp"),
        Image ("imgs/14.bmp"),
        Image ("imgs/15.bmp"),
        Image ("imgs/16.bmp"),
        Image ("imgs/17.bmp"),
        Image ("imgs/18.bmp"),
        Image ("imgs/19.bmp"),
        Image ("imgs/20.bmp"),
        Image ("imgs/21.bmp"),
        Image ("imgs/22.bmp"),
        Image ("imgs/23.bmp"),
        Image ("imgs/24.bmp"),
        Image ("imgs/25.bmp"),
        Image ("imgs/26.bmp"),
        Image ("imgs/27.bmp"),
        Image ("imgs/28.bmp"),
        Image ("imgs/29.bmp"),
        Image ("imgs/30.bmp"));  
begin
  
for j in Imagenes_tropas'range loop
   -- Cargar imagenes defensores
   for I in 1..10 loop
       if Valid(Rutas_Imagenes(I)) then
          Draw_Image(Imagenes_tropas(j,I),(0,0),(Width(Rutas_Imagenes(I)),Height(Rutas_Imagenes(I))),Rutas_Imagenes(I));
       end if;
   end loop;
   for I in 11..20 loop
       if Valid(Rutas_Imagenes(I)) then
          Draw_Image(Imagenes_tropas(j,I),(0,0),(Width(Rutas_Imagenes(I)),Height(Rutas_Imagenes(I))),Rutas_Imagenes(I));
       end if;
   end loop;
   for I in 21..30 loop
       if Valid(Rutas_Imagenes(I)) then 
          Draw_Image(Imagenes_tropas(j,I),(0,0),(Width(Rutas_Imagenes(I)),Height(Rutas_Imagenes(I))),Rutas_Imagenes(I));
       end if;
   end loop;
end loop;     
   
for I in Envio_Atacante'range loop
      for J in 1..6 loop
         disable(Envio_Atacante(i,j));
      end loop;
end loop;

end Cargar_Imagenes_y_bloquear_campos;