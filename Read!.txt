Codigo fuente de Travian Combat v0.90
http://www.canalada.org/

El código fuente está listo para ser compilado con GNAT o cualquier otro compilador de Ada95.
La versión gráfica de Travian Combat usa las librerías JEWL, así que puede ser necesario usar GNAT-WIN para su correcto linkado.
También usa la librería AdaIntl para internacionalización.
Los iconos se crearon con rcl.exe

Para compilar el simulador:
Abrir Adagide o ejecutar gnatmake con el archivo "simulador.adb"

Para compilar el coordinador:
Abrir Adagide o ejecutar gnatmake con el archivo "coordinador.adb"

Para compilar la calculadora:
Abrir Adagide o ejecutar gnatmake con el archivo "calculadora.adb"

Aunque es posible ejecutar Travian Combat con Wine (0.9.8 en adelante), 
las librerías JEWL no compilan bajo Linux, lo siento :(

Sin embargo, se puede ver un ejemplo del simulador en consola en "prueba.adb".
También es posible obtener GTKJewl y compilarlo con esa librería (funciona en Linux), 
aunque el resultado deja bastante que desear.
Dado que la GUI está separada de las fórmulas, se puede hacer una GUI en otra librería como GtkAda (o hacer una en modo consola)


Archivos:
traduccion -> Archivos de traducción generales, contiene los strings usados
traduccion_gui -> Strings con detalles específicos del simulador y la calculadora
traduccion_coordinador -> Strings con detalles específicos del coordinador de ataques
formulas -> Contiene las fórmulas básicas usadas en TC, además de funciones para el  fomateo de texto
operaciones -> Funciones y procedimientos más abstractos un nivel por encima de las fórmulas básicas
BBCode_HTML -> Paquete que permite hacer informes en texto plano, bbcode o html
simulador -> El simulador de combate
calculadora -> La calculadora de recursos
coordinador -> El coordinador de ataques

Los archivos .o son los iconos pasados a objetos (para que el ejecutable sea más "bonito").

No incluido:
Jewl -> La librería gráfica
http://www.it.bton.ac.uk/staff/je/jewl/download.htm
AdaIntl -> La librería de internacionalización (incluye otros paquetes como aa_tree_package, etc)
http://canalada.org/foro/viewtopic.php?t=145
