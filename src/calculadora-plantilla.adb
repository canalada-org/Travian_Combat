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
with Ada.Text_Io;
use Ada.Text_Io;

separate(Calculadora)

procedure Plantilla (
      Guardar : Boolean ) is 
   F : File_Type;  
begin

   if not Guardar then -- Cargamos al inicio

      -- Debemos comprobar que exista el fichero de plantilla!!
      begin
         Open(F, In_File, ("GUI_Translation"-"config/Template") & ("GUI_Translation"-".rdf"));
         Close(F);
         Guardar_Cargar(Guardar, ("GUI_Translation"-"config/Template") & ("GUI_Translation"-".rdf"));
         -- Si el fichero no existe, entonces no hacemos nada
      exception
         when others=>
            null;
      end;
      
   else -- Guardamos cuando el usuario quiera
      Guardar_Cargar(Guardar, ("GUI_Translation"-"config/Template") & ("GUI_Translation"-".rdf"));
   end if;
end Plantilla;
