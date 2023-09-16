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
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;


with Tablas;

package Formulas is

   -- Dado el ratio habitantes del agresor / habitantes del defensor
   -- calcula la moral que ganará el defensor
   function Moral (
         Ratio_Pob,        
         Ratio_Da  : Float ) 
     return Float; 

   -- Devuelve los puntos de defensa totales en función a la proporción de 
   -- infantería y caballería que ataca
   -- Si no hay atacante (ataque_infanteria=ataque_caballeria=0), devuelve
   -- "Defensa_infanteria"
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
   -- Normal indica si el ataque es normal (false) o si es atraco (true)
   -- Numero_Tropas es el número de soldados que intervienen en la batalla.
   --  NO cuenta el consumo de cereal: 10 imperatoris vs 100 lanceros y 30 druidas
   --  son 100+10+30=140 unidades
   -- V es la versión de travian (v2 o v3)
   function Proporcion_Perdidas (
         Ganador,                                              
         Perdedor      : Integer;                              
         Atraco        : Boolean;                              
         Numero_Tropas : Integer;                              
         V             : Tablas.T_Version_Travian := Tablas.V2 ) 
     return Float; 


   -- Calcula la defensa de la aldea en función del numero de tropas y del ataque 
   -- de cada una
   function Defensa_Basica (
         Ataque,            
         N_Tropas : Integer ) 
     return Integer; 




   -- Calcula el exponente de combate.
   -- Se usa en "Proporcion_Perdidas"
   function Calcular_Exponente (
         Numero_Tropas : Integer;                              
         V             : Tablas.T_Version_Travian := Tablas.V2 ) 
     return Float;


   -- Dada una cadena, devuelve su valor entero (una especie de atoi)
   function Valor (
         S : Unbounded_String ) 
     return Integer; 

   -- Devuelve la parte entera de F
   function Entero (
         F : Float ) 
     return Integer; 

   -- Devuelve la parte fraccionaria de f
   function Fraccion (
         F : Float ) 
     return Float; 

   -- Devuelve el string de un número con dos digitos (para las horas)
   function Dos_Digitos (
         N : Natural ) 
     return String; 

   -- Prec: S es un string de longitud 'l' >=0
   -- Post: Si 'l'>0 devuelve un string en minúsculas con el primer caracter
   --       en mayúsculas. Si 'l'=0 devuelve 'X'.
   function Formato (
         X : in     String ) 
     return String; 


   -- Se encarga de quitar los espacios iniciales. 
   -- Usado para quitar los espacios después de convertir un número
   -- a string que ada estupidamente mete.
   function Quita_Espacios (
         S : in     String ) 
     return String; 

end Formulas;