with Adaintl;
use Adaintl;

with Traduccion_Gui;
use Traduccion_Gui;

package Traduccion_Coordinador is
   
   TraduccionCoord_Intl: Internationalization_Type:= Initialize_Adaintl (
         Language                => En,             
         Default_Domain          => "Coordinator_Translation", 
         Debug_Mode              => No_Debug,   
         Directory               => "locale/",         
         Load_Configuration_File => "config/Language.dat"          ); 


   Nombre_Coordinador : String := - "Attack Coordinator - TC  " & Version;  
   Nom_Hora           : String := - "Time:";  
   Nom_Fecha          : String := - "Date:";  
   Guion              : String := - "-";  
   Dos_Puntos         : String := - ":";  

   Nom_Nombre : String := - "Name:";  

   Ruta_Informe_Coordinador        : String := - "coordination_report.txt";  
   Ruta_Informe_Bbcode_Coordinador : String := - "coordination_report_BBCode.txt";  
   Ruta_Informe_Html_Coordinador   : String := - "coordination_report_HTML.txt";  

   Texto_Informe_Completo : String := - "Complet &report";  
   Texto_Informe_Añadir   : String := - "&Add to report";  

   Botones_Hoy                : String := - "Today";  
   Botones_Mañananoche        : String := - "Night";  
   Botones_Copiar_Llegada     : String := - "Copy arrival";  
   Botones_Copiar_Coordenadas : String := - "Copy coordinates";  
   Botones_Limpiar_Todo       : String := - "Clean all";  
   Botones_Limpiar_Aldeas     : String := - "Clean towns";  
   Botones_Limpiar_Llegada    : String := - "Clean arrival";  
   Botones_Limpiar_Tropas     : String := - "Clean troops";  

   Informacion_Tropas  : String := - "Attackers '  tribe           Attack troops type";  
   Informacion_Aldea   : String := - "Coordinates                  Square Tournament           Speed Artifact";  
   Informacion_Llegada : String := - "Arrival to target              Time-> HH:MM:SS            Date-> DD-MM-YYYY";  
   Informacion_Envio   : String := - "Departure                         Time-> HH:MM:SS            Date-> DD-MM-YYYY";  
end Traduccion_Coordinador;