with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Adaintl;
use AdaIntl;

package Traduccion is

   Traduccion_Intl: Internationalization_Type:= Initialize_Adaintl (
         Language                => En,             
         Default_Domain          => "Common_Translation", 
         Debug_Mode              => No_Debug,   
         Directory               => "locale/",         
         Load_Configuration_File => "config/Language.dat"          ); 

   type Tablas_Nombres is array (positive range <>) of Unbounded_String; 

   Nom_Romanos  : String := -"Romans";  
   Nom_Galos    : String := -"Gauls";  
   Nom_Germanos : String := -"Teutons";  

   -- Varios
   Nom_Agresor         : String := -"Agressor";  
   Nom_Nivel           : String := -"Level";  
   Nom_Tropas          : String := -"Troops";  
   Nom_Habitantes      : String := -"Population";  
   Nom_Defensores      : String := -"Defender";  
   Nom_Perdidas        : String := -"Losses";  
   Nom_Perd_Materiales : String := -"Material lost";  


   Nom_Aldea_Agresora  : String := -"Agressor town";  
   Nom_Aldea_Defensora : String := -"Defender town"; 
   Nom_Aldea_Objetivo  : String := -"Target";    
   Nom_Aldea_X         : String := -"X:";  
   Nom_Aldea_Y         : String := -"Y:";  

   Nom_Tiempo : String := -"Time:";  
   
   Nom_Normal : String :=-"Attack";
   Nom_Atraco : String :=-"Raid";
   
   Nom_Artefacto_abreviado   : String:=-"SA:";
   Nom_Artefacto             : String:=-"Artifact";   
   Nom_PT                    : String:=-"Tourn. square";
   Nom_PT_abreviado          : String:=-"TS:";

   
   -- Edificios no comunes
   Nom_Muralla    : String := -"Roman wall";  
   Nom_Terraplen  : String := -"Teuton wall";  
   Nom_Empalizada : String := -"Galic wall";  

   -- Comunes
   Nom_Palacio      : String := -"Palace";  
   Nom_Catapulta    : String := -"Catapult";  
   Nom_Descubridor  : String := -"Settler";  

   -- Tropas romanas
   Nom_Legionario    : String := -"Legionnaire";  
   Nom_Pretoriano    : String := -"Praetorian";  
   Nom_Imperano      : String := -"Imperian";  
   Nom_Legati        : String := -"Legati";  
   Nom_Imperatoris   : String := -"Imperatoris";  
   Nom_Caesaris      : String := -"Caesaris";  
   Nom_Ariete_Romano : String := -"Battering ram";  
   Nom_Senador       : String := -"Senator";  

   -- Tropas Galos
   Nom_Falange     : String := -"Phalanx";  
   Nom_Espada      : String := -"Swordsman";  
   Nom_Batidor     : String := -"Pathfinder";  
   Nom_Rayo        : String := -"Theutates Thunder";  
   Nom_Druida      : String := -"Druidrider";  
   Nom_Haeduano    : String := -"Haeduan";  
   Nom_Ariete_Galo : String := -"Ram";  
   Nom_Cacique     : String := -"Chieftain";  


   -- Tropas Germanas
   Nom_Porra          : String := -"Clubswinger";  
   Nom_Lanza          : String := -"Spearfighter";  
   Nom_Hacha          : String := -"Axefighter";  
   Nom_Emisario       : String := -"Scout";  
   Nom_Paladin        : String := -"Paladin";  
   Nom_Teutona        : String := -"Teuton Knight";  
   Nom_Ariete_Germano : String := -"Ram";  
   Nom_Cabecilla      : String := -"Chief"; 
   

   -- Animalicos bonitos xD
   Nom_Rata           : String := -"Rat";  
   Nom_Araña          : String := -"Spider";  
   Nom_Serpiente      : String := -"Serpent";  
   Nom_Murcielago     : String := -"Bat"; 
   Nom_Jabalí         : String := -"Wild boar";
   Nom_Lobo           : String := -"Wolf"; 
   Nom_Oso            : String := -"Bear";  
   Nom_Cocodrilo      : String := -"Crocodile";  
   Nom_Tigre          : String := -"Tiger";  
   Nom_Elefante       : String := -"Elephant";  


   Ejercito_Romano : Tablas_Nombres := (
      To_Unbounded_String(Nom_Legionario),
      To_Unbounded_String(Nom_Pretoriano),
      To_Unbounded_String(Nom_Imperano),
      To_Unbounded_String(Nom_Legati),
      To_Unbounded_String(Nom_Imperatoris),
      To_Unbounded_String(Nom_Caesaris),
      To_Unbounded_String(Nom_Ariete_Romano),
      To_Unbounded_String(Nom_Catapulta),         
      To_Unbounded_String(Nom_Senador),
      To_Unbounded_String(Nom_Descubridor)); 
      
   Ejercito_Galo: Tablas_Nombres := (
      To_Unbounded_String(Nom_Falange),
      To_Unbounded_String(Nom_Espada),
      To_Unbounded_String(Nom_Batidor),
      To_Unbounded_String(Nom_Rayo),
      To_Unbounded_String(Nom_Druida),
      To_Unbounded_String(Nom_Haeduano),
      To_Unbounded_String(Nom_Ariete_Galo),
      To_Unbounded_String(Nom_Catapulta),  
      To_Unbounded_String(Nom_Cacique), 
      To_Unbounded_String(Nom_Descubridor)); 
      
   Ejercito_Germano: Tablas_Nombres := (
      To_Unbounded_String(Nom_Porra),
      To_Unbounded_String(Nom_Lanza),
      To_Unbounded_String(Nom_Hacha),
      To_Unbounded_String(Nom_Emisario),
      To_Unbounded_String(Nom_Paladin),
      To_Unbounded_String(Nom_Teutona),
      To_Unbounded_String(Nom_Ariete_Germano),
      To_Unbounded_String(Nom_Catapulta),  
      To_unbounded_string(Nom_Cabecilla), 
      To_Unbounded_String(Nom_Descubridor)); 
      

   Animalicos: Tablas_Nombres := (
      To_Unbounded_String(Nom_Rata),
      To_Unbounded_String(Nom_Araña),
      To_Unbounded_String(Nom_Serpiente),
      To_Unbounded_String(Nom_Murcielago),
      To_Unbounded_String(Nom_Jabalí),
      To_Unbounded_String(Nom_Lobo),
      To_Unbounded_String(Nom_Oso),
      To_Unbounded_String(Nom_Cocodrilo),  
      To_unbounded_string(Nom_Tigre), 
      To_Unbounded_String(Nom_Elefante));  


  -- Otros
   Calendario: Tablas_Nombres:=(
      To_Unbounded_String(-"January"),
      To_Unbounded_String(-"February"),
      To_Unbounded_String(-"March"),
      To_Unbounded_String(-"April"),
      To_Unbounded_String(-"May"),
      To_Unbounded_String(-"June"),         
      To_Unbounded_String(-"July"),
      To_Unbounded_String(-"August"),
      To_Unbounded_String(-"September"),
      To_Unbounded_String(-"October"),
      To_Unbounded_String(-"November"),
      To_Unbounded_String(-"December"));        
      
   -- Versiones de Travian
   Travian_V2: String:= -"Travian v2";
   Travian_V3: String:= -"Travian v3";
   Vx: String:= -"V2/V3";   
      
end Traduccion;