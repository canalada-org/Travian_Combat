----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat'  is distributed  in the  hope  that  it     
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
package Bbcode_Html is


   type T_Color is 
         (Red,   
          Blue,  
          White, 
          Green, 
          Black, 
          Yellow); 


   -- Tipo de informe
   -- 0 sin informe
   -- 1 texto plano
   -- 2 bbcode
   -- 3 html
   procedure Tipo_De_Informe (
         X : Natural ); 

   ------------------------------

   -- <b></b>
   procedure Negrita (
         F : File_Type ); 
   procedure Fin_Negrita (
         F : File_Type ); 

   -- <u></u>
   procedure Subrayado (
         F : File_Type ); 
   procedure Fin_Subrayado (
         F : File_Type ); 

   -- <i></i>
   procedure Cursiva (
         F : File_Type ); 
   procedure Fin_Cursiva (
         F : File_Type ); 

   -- <img src=>
   procedure Imagen (
         F    : File_Type; 
         Ruta : String     ); 

   -- <a href=></a>
   procedure Link (
         F    : File_Type; 
         Ruta : String     ); 
   procedure Fin_Link (
         F : File_Type ); 

   -- <font color=></font>
   procedure Color (
         F : File_Type; 
         C : T_Color    ); 
   procedure Fin_Color (
         F : File_Type ); 

   -- <font size=></font>
   procedure Tamaño (
         F : File_Type; 
         T : Positive   ); 
   procedure Fin_Tamaño (
         F : File_Type ); 

   -- <br>
   procedure Salto_Linea (
         F : File_Type ); 

private

   function Obtener_Codigo (
         S : String ) 
     return String; 
end Bbcode_Html;