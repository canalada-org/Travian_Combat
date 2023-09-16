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


   type Tabla_Valores is array (1 .. 10, 1 .. 10) of Integer; 




   -- En % y nivel
   -- Las cantidades son acumulables (^) excepto los bonus de defensa y ataque
   Bonus_Muralla_Romana  : Float := 3.0;  
   Bonus_Muralla_Gala    : Float := 2.5;  
   Bonus_Muralla_Germana : Float := 2.0;  


   -- La defensa o ataque de armamentería/armería es:
   -- (A*GRANO_POR_HORA + 0,015*VALOR_BASE )* NIVEL/2
   -- Donde A es:
   Cte_Bonus_Defensa_Ataque         : Float :=0.641627;
   
   -- El bonus de palacio se calcula: Bonus * n**2 donde n es el nivel
   Bonus_Palacio         : Float := 2.0; 
   
   Capacidad_Acechar     : Integer:=35;
   Defensa_Acechar       : Integer:=20;

   -- La cuarta componente indica si es infantería
   -- Ataque/Defensa inf/Defensa caballería/ Inf o no/ Madera / Barro / Hierro / Cereal / Velocidad / Consumo 
   Tablas_Romanos : Tabla_Valores := (
      ( 40,  35, 50, 1,  120 ,  100,  180,   40, 6, 1),  -- Legionario
      ( 30,  65, 35, 1,  100 ,  130,  160,   70, 5, 1),  -- Pretoriano
      ( 70,  40, 25, 1,  150 ,  160,  210,   80, 7, 1),  -- Imperano
      ( 0,   20, 10, 0,  140 ,  160,   20,   40,16, 2),  -- Legati
      (120,  65, 50, 0,  550 ,  440,  320,  100,14, 3),  -- Imperatoris
      (180,  80,105, 0,  550 ,  640,  800,  180,10, 4),  -- Caesaris
      ( 60,  30, 75, 1,  900 ,  360,  500,   70, 4, 3),  -- Carnero
      ( 75,  60, 10, 1,  950,  1350,  600,   90, 3, 6),  -- Catapulta
      ( 50,  40, 30, 1,30750, 27200,45000,37500, 4, 5),  -- Senador
      (  0,  80, 80, 1, 5800,  5300, 7200, 5500, 5, 1)); -- Descubridor


   Tablas_Galos: Tabla_Valores := (
      ( 15, 40, 50,1,  100,	130,   55,	 30, 7, 1),  -- Falange
      ( 65, 35, 20,1,  140,	150,  185,	 60, 6, 1),  -- Espada
      (  0, 20, 10,0,  170,	150,   20,   40,17, 2),  -- Batidor
      ( 90, 25, 40,0,  350,	450,  230,   60,19, 2),  -- Rayo
      ( 45,115, 55,0,  360,	330,  280,  120,16, 2),  -- Druida
      (140, 50,165,0,  500,	620,  675,  170,13, 3),  -- Haeduano
      ( 50, 30,105,1,  950,	555,  330,	 75, 4, 3),  -- Carnero
      ( 70, 45, 10,1,  960,  1450,  630,	 90, 3, 6),  -- Catapulta
      ( 40, 50, 50,1,30750, 45400,31000,37500, 5, 4),  -- Cacique
      (  0, 80, 80,1, 5500,  7000, 5300, 4900, 5, 1)); -- Descubridor


   Tablas_Germanos: Tabla_Valores := (
      ( 40,  20,  5,1,   95,	75   ,40 	,40,   7, 1),   -- Porras
      ( 10,  35, 60,1,  145,	70   ,85 	,40,   7, 1),   -- Lanza
      ( 60,  30, 30,1,  130,	120  ,170 	,70,   6, 1),   -- Hacha
      (  0,  10,  5,0,  160,	100  ,50 	,50,   9, 1),   -- Emisario
      ( 55, 100, 40,0,  370,	270  ,290 	,75,  10, 2),   -- Paladin
      (150,  50, 75,0,  450,	515  ,480 	,80,   9, 3),   -- Teutona
      ( 65,  30, 80,1, 1000,	300  ,350 	,70,   4, 3),   -- Ariete
      ( 50,  60, 10,1,  900,	1200 ,600 	,60,   3, 6),   -- Catapulta
      ( 40,  60, 40,1,35500,	26600,25000 ,27200,4, 4),   -- Cabecilla
      ( 10,  80, 80,1, 7200,	5500,	5800,	6500,  5, 1));  -- Descubridor
         


   Tablas_Naturaleza: Tabla_Valores := (
      ( 10,  25, 20,1,   0,	0    ,0	,0,    20, 1),   -- Rata
      ( 20,  35, 40,1,   0,	0    ,0     ,0,    20, 1),   -- Araña
      ( 60,  40, 60,1,   0,	0    ,0     ,0,    20, 1),   -- Serpiente
      ( 80,  66, 50,1,   0,	0    ,0	,0,    20, 1),   -- Murcielago
      ( 50,  70, 33,1,   0,	0    ,0	,0,    20, 2),   -- Jabalí
      (100,  80, 70,1,   0,	0    ,0	,0,    20, 1),   -- Lobo
      (250, 140,200,1,   0,	0    ,0	,0,    20, 1),   -- Oso
      (450, 380,240,1,   0,	0    ,0	,0,    20, 1),   -- Cocodrilo
      (200, 170,250,1,   0,	0    ,0     ,0,    20, 1),   -- Tigre
      (600, 440,520,1,   0,	0,	0     ,0,    20, 1));  -- Elefante


   -- Nivel máximo de un ayuntamiento
   Max_Niveles_Ayuntamiento: constant Natural:= 20;
   

   -- Cultura por fiesta (fiesta, fiesta!!! xD)
   Cultura_Fiesta_Pequeña: constant natural := 500;   
   Cultura_Fiesta_Grande : constant natural := 2000;   

   type V_Tiempo_Necesario is array (1..Max_Niveles_Ayuntamiento) of Integer;
   
   -- Tiempo que tarda en hacerse una fiesta, en segundos y según el nivel
   -- del ayuntamiento
   Tiempo_Necesario_Fiesta_Pequeña: V_Tiempo_Necesario :=
     (24*3600,
      23*3600+8*60+9,
      22*3600+18*60+11,
      21*3600+30*60,
      20*3600+43*60+34,
      19*3600+58*60+48,
      19*3600+15*60+38,
      18*3600+34*60*2,
      17*3600+53*60+56,
      17*3600+15*60+16,
      16*3600+38*60,
      16*3600+2*60+4,
      15*3600+27*60+26,
      14*3600+54*60+3,
      14*3600+21*60+52,
      13*3600+50*60+50,
      13*3600+20*60+55,
      12*3600+52*60+5,
      12*3600+24*60+18,
      11*3600+57*60+30        
            );


   Tiempo_Necesario_Fiesta_Grande: V_Tiempo_Necesario :=
     (-1, -- Indica que no está disponible
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      43*3600+8*60+11,
      41*3600+35*60,
      40*3600+5*60+11,
      38*3600+38*60+36,
      37*3600+15*60+8,
      35*3600+1*60+1, -- CUIDADO! No es seguro
      34*3600+37*60+06,
      33*3600+22*60+19,
      32*3600+10*60+14,
      31*3600+0*60+45,
      29*3600+53*60+46        
            );

   -- Version de travian y tamaño del mapa
   type T_Version_Travian is (V2, V3);

   Distancia_X_V2: constant integer:=250;
   Distancia_Y_V2: constant Integer:=250;
   Distancia_X_V3: constant Integer:=400;  
   Distancia_Y_V3: constant integer:=400;     

end Tablas;