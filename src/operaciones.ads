----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' (and this package "operaciones") is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------


with Tablas;
use Tablas;

package Operaciones is

   type Casilla is 
      record 
         Cantidad : Integer := 0;  
         Nivel    : Integer := 0;  
      end record; 
   type Vector_Tropas is array (1 .. 10) of Casilla; 

   type Ejercito is 
      record 
         Tropas  : Vector_Tropas := (others => (0, 0));  
         Muralla : Integer       := 0;  
      end record; 



   procedure Calcular_Resultado (
         Pueblo_Atacante      :        T_Pueblos;        
         Atacante,                                       
         Defensor_Romano,                                
         Defensor_Galo,                                  
         Defensor_Germano     :        Ejercito;         
         Ratio_Habitantes     :        Float     := 1.0; 
         Nivel_Palacio        :        Integer   := 0;   
         Res_Atacante,                                   
         Res_Defensor_Romano,                            
         Res_Defensor_Galo,                              
         Res_Defensor_Germano :    out Ejercito          ); 

   -- Calcula el costo material del ejercito perdido. Las cantidades se suman 
   -- con lo que había antes así que hay que asegurarse de inicializarlas!!
   procedure Calcular_Perdidas (
         Pueblo :        T_Pueblos; 
         Tropas :        Ejercito;  
         Madera : in out Integer;   
         Barro  : in out Integer;   
         Hierro : in out Integer;   
         Cereal : in out Integer    ); 

   function Velocidad_Ejercito (
         Pueblo : T_Pueblos; 
         E      : Ejercito   ) 
     return Integer; 

end Operaciones;