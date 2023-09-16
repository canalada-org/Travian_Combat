----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' (and this package "formulas") is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------

package Formulas is

   -- Dado el ratio habitantes del agresor / habitantes del defensor
   -- calcula la moral que ganará el defensor
   function Moral (
         Ratio : Float ) 
     return Float; 

   -- Devuelve los puntos de defensa totales en función a la proporción de 
   -- infantería y caballería que ataca
   function Defensa_Total (
         Ataque_Infanteria,           
         Ataque_Caballeria,           
         Defensa_Infanteria,          
         Defensa_Caballeria : Integer ) 
     return Integer; 

   -- Dados los puntos de ataque y defensa, dice quien gana
   function Gana_Atacante (
         Ataque_Total,           
         Defensa_Total : Integer ) 
     return Boolean; 

   -- Devuelve el porcentaje de perdidas del Ganador
   function Proporcion_Perdidas (
         Ganador,           
         Perdedor : Integer ) 
     return Float; 


   -- Calcula la defensa de la aldea en función del numero de tropas y del ataque 
   -- de cada una
   function Defensa_Basica (
         Ataque,            
         N_Tropas : Integer ) 
     return Integer; 

end Formulas;