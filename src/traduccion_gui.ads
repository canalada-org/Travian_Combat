with Adaintl;
use Adaintl;

package Traduccion_Gui is

      Traducciongui_Intl : Internationalization_Type := Initialize_Adaintl
         (Language => En,
         Default_Domain => "GUI_Translation",
         Debug_Mode => No_Debug,
         Directory => "locale/",
         Load_Configuration_File => "config/Language.dat");  

   Version         : String := "v0.90b";  
   Nombre_Simulador: String := - "Travian Combat Simulator - TC" & Version;  
   Nombre_Calculadora: String := - "Resource and Culture Calculator - TC " & Version;  

   Informacion_Acercade   : String := - "Made by Andres_age under the GPL";  
   Texto_Menuarchivo      : String := - "&File";  
   Texto_Informe          : String := - "&Report";  
   Texto_Plano            : String := - "(Plain Text)";  
   Texto_Bbcode           : String := - "(BBCode)";  
   Texto_Html             : String := - "(HTML)";  
   Texto_Calc             : String := - "&Calculator";  
   Texto_Menuayuda        : String := - "Hel&p";  
   Texto_Salir            : String := - "&Exit";  
   Texto_Instrucciones    : String := - "&Instructions";  
   Texto_Acercade         : String := - "&About";  
   Texto_Menuherramientas : String := - "&Tools";  
   Texto_Opciones         : String := - "&Options";  
   Texto_Animales_Tropas  : String := - "&Nature (v3)/Troops";  

   Encabezado_Calculadora    : String := - "Resources calculator - TC" & Version;  
   Texto_Recursos_Actuales   : String := - "Stored resources";  
   Texto_Recursos_Necesarios : String := - "Wanted resources";  
   Texto_Produccion          : String := - "Production";  

   Texto_Construccion_Posible    : String := - "Enough resources in ";  
   Texto_Construccion_Imposible  : String := - "Impossible or too slow";  
   Texto_Construccion_Ahora      : String := - "You can already build";  
   Texto_Construccion_Disponible : String := - "Available: ";  
   Texto_Construccion_Hoy        : String := - "Today at ";  
   Texto_Sobras_Materiales       : String := - "Remainings";  

   Texto_Cultura_Ahora : String := - "You have already enough culture";  

   Ruta_Informe        : String := - "report.txt";  
   Ruta_Informe_Bbcode : String := - "report_BBCode.txt";  
   Ruta_Informe_Html   : String := - "report_HTML.txt";  

   Nom_Borrar            : String := - "Clean";  
   Nom_Borrar_Produccion : String := - "Clean production";  
   Nom_Produccion_Max    : String := - "Production to 1000";  

   Nom_Recursos : String := - "Resources";  
   Nom_Cultura  : String := - "Culture";  

   Nom_Datos                   : String := - "Data";  
   Nom_Ayuntamientos_Por_Nivel : String := - "Town Halls per level";  
   Nom_Numero_Aldeas           : String := - "Number of villages";  
   Nom_Aldea                   : String := - "Village";  
   Nom_Pc_Necesarios           : String := - "CP needed";  
   Nom_Cultura_Actual          : String := - "Actual CP";  
   Nom_Produccion_Diaria       : String := - "Daily CP production"; 
   Nom_Datos_Invalidos         : String := - "Error: Invalid data";    

   Nom_Menu_Guardar : String := - "Quicksave";  
   Nom_Menu_Cargar  : String := - "Quickload"; 
   Nom_Menu_Plantilla: String := - "Set Template";     
end Traduccion_Gui;