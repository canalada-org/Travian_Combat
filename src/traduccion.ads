with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Traduccion is


   type Tablas_Nombres is array (1 .. 10) of Unbounded_String; 

   Nom_Romanos  : String := "Romanos";  
   Nom_Galos    : String := "Galos";  
   Nom_Germanos : String := "Germanos";  

   -- Varios
   Nom_Agresor         : String := "Agresor";  
   Nom_Nivel           : String := "Nivel";  
   Nom_Tropas          : String := "Tropas";  
   Nom_Habitantes      : String := "Habitantes";  
   Nom_Defensores      : String := "Defensores";  
   Nom_Perdidas        : String := "Pérdidas";  
   Nom_Perd_Materiales : String := "Pérdidas materiales";  

   Nom_Aldea_Agresora  : String := "Aldea agresora";  
   Nom_Aldea_Defensora : String := "Aldea defensora";  
   Nom_Aldea_X         : String := "X:";  
   Nom_Aldea_Y         : String := "Y:";  

   Nom_Tiempo : String := "Tiempo:";  

   -- Edificios no comunes
   Nom_Muralla    : String := "Muralla romana";  
   Nom_Terraplen  : String := "Terraplen germ.";  
   Nom_Empalizada : String := "Empalizada gala";  

   -- Comunes
   Nom_Palacio      : String := "Palacio";  
   Nom_Catapulta    : String := "Catapulta";  
   Nom_Descubridor  : String := "Descubridor";  

   -- Tropas romanas
   Nom_Legionario    : String := "Legionario";  
   Nom_Pretoriano    : String := "Pretoriano";  
   Nom_Imperano      : String := "Imperano";  
   Nom_Legati        : String := "Legati";  
   Nom_Imperatoris   : String := "Imperatoris";  
   Nom_Caesaris      : String := "Caesaris";  
   Nom_Ariete_Romano : String := "Carnero";  
   Nom_Senador       : String := "Senador";  

   -- Tropas Galos
   Nom_Falange     : String := "Falange";  
   Nom_Espada      : String := "Luchador de espada";  
   Nom_Batidor     : String := "Batidor";  
   Nom_Rayo        : String := "Rayo de Theutates";  
   Nom_Druida      : String := "Druida";  
   Nom_Haeduano    : String := "Haeduano";  
   Nom_Ariete_Galo : String := "Carnero de madera";  
   Nom_Cacique     : String := "cacique";  


   -- Tropas Germanas
   Nom_Porra          : String := "Lanzador de porras";  
   Nom_Lanza          : String := "Luchador de lanza";  
   Nom_Hacha          : String := "Luchador de hacha";  
   Nom_Emisario       : String := "Emisario";  
   Nom_Paladin        : String := "Paladín";  
   Nom_Teutona        : String := "Caballista teutona";  
   Nom_Ariete_Germano : String := "Ariete";  
   Nom_Cabecilla      : String := "Cabecilla";  

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


end Traduccion;