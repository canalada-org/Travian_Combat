----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' (and this package "tablas") is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------


package Tablas is

   type T_Pueblos is (Romanos, Galos, Germanos); 


   type Tabla_Valores is array (1 .. 10, 1 .. 9) of Integer; 




   -- En % y nivel
   -- La muralla es acumulable (^), el palacio, la defensa y ataque de unidades no (*).
   Bonus_Muralla_Romana  : Float := 3.0;  
   Bonus_Muralla_Gala    : Float := 2.5;  
   Bonus_Muralla_Germana : Float := 2.0;  

   Bonus_Defensa         : Float :=1.5;
   Bonus_Ataque          : Float :=1.5; 
   
   Bonus_Palacio         : Float := 0.5; 
   
   Capacidad_Acechar     : Integer:=122;
   Defensa_Acechar       : Integer:=69;

   -- La cuarta componente indica si es infantería o no
   Tablas_Romanos : Tabla_Valores := (
      ( 40,  35, 50, 1,  120 ,  100,  180,   40, 6),  -- Legionario
      ( 30,  65, 35, 1,  100 ,  130,  160,   70, 5),  -- Pretoriano
      ( 70,  40, 25, 1,  150 ,  160,  210,   80, 7),  -- Imperano
      ( 0,   20, 10, 0,  140 ,  160,   20,   40,16),  -- Legati
      (120,  65, 50, 0,  550 ,  440,  320,  100,14),  -- Imperatoris
      (180,  80,105, 0,  550 ,  640,  800,  180,10),  -- Caesaris
      ( 60,  30, 75, 1,  900 ,  360,  500,   70, 4),  -- Carnero
      ( 75,  60, 10, 1,  950,  1350,  600,   90, 3),  -- Catapulta
      ( 50,  40, 30, 1,30750, 27200,45000,37500, 4),  -- Senador
      (  0,  80, 80, 1, 5800,  5300, 7200, 5500, 5)); -- Descubridor


   Tablas_Galos: Tabla_Valores := (
      ( 15, 40, 50,1,  100,	130,   55,	 30, 7),  -- Falange
      ( 65, 35, 20,1,  140,	150,  185,	 60, 6),  -- Espada
      (  0, 20, 10,0,  170,	150,   20,   40,17),  -- Batidor
      ( 90, 25, 40,0,  350,	450,  230,   60,19),  -- Rayo
      ( 45,115, 55,0,  360,	330,  280,  120,16),  -- Druida
      (140, 50,165,0,  500,	620,  675,  170,13),  -- Haeduano
      ( 50, 30,105,1,  950,	555,  330,	 75, 4),  -- Carnero
      ( 70, 45, 10,1,  960,  1450,  630,	 90, 3),  -- Catapulta
      ( 40, 50, 50,1,30750, 45400,31000,37500, 5),  -- Cacique
      (  0, 80, 80,1, 5500,  7000, 5300, 4900, 5)); -- Descubridor


   Tablas_Germanos: Tabla_Valores := (
      ( 40,  20,  5,1,   95,	75   ,40 	,40,   7),   -- Porras
      ( 10,  35, 60,1,  145,	70   ,85 	,40,   7),   -- Lanza
      ( 60,  30, 30,1,  130,	120  ,170 	,70,   6),   -- Hacha
      (  0,  10,  5,0,  160,	100  ,50 	,50,   9),   -- Emisario
      ( 55, 100, 40,0,  370,	270  ,290 	,75,  10),   -- Paladin
      (150,  50, 75,0,  450,	515  ,480 	,80,   9),   -- Teutona
      ( 65,  30, 80,1, 1000,	300  ,350 	,70,   4),   -- Ariete
      ( 50,  60, 10,1,  900,	1200 ,600 	,60,   3),   -- Catapulta
      ( 40,  60, 40,1,35500,	26600,25000 ,27200,4),   -- Cabecilla
      ( 10,  80, 80,1, 7200,	5500,	5800,	6500,  5));  -- Descubridor

end Tablas;