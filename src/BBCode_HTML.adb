----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat'  is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------

with Formulas;

with Adaintl; use Adaintl;



package body Bbcode_Html is


 TraduccionGui_Intl: Internationalization_Type:= Initialize_Adaintl (
         Language                => En,             
         Default_Domain          => "BBCode_HTML", 
         Debug_Mode              => No_Debug,   
         Directory               => "locale/",         
         Load_Configuration_File => "config/Language.dat"          ); 




   Tipo_Informe : Natural := 0;  

   Fin_Html : String := -">";  
   Fin_Bb   : String := -"]";  

   Negrita_Bb       : String := -"[b]";  
   Fin_Negrita_Bb   : String := -"[/b]";  
   Negrita_Html     : String := -"<b>";  
   Fin_Negrita_Html : String := -"</b>";  

   Subrayado_Bb       : String := -"[u]";  
   Fin_Subrayado_Bb   : String := -"[/u]";  
   Subrayado_Html     : String := -"<u>";  
   Fin_Subrayado_Html : String := -"</u>";  

   Cursiva_Bb       : String := -"[i]";  
   Fin_Cursiva_Bb   : String := -"[/i]";  
   Cursiva_Html     : String := -"<i>";  
   Fin_Cursiva_Html : String := -"</i>";  

   Img_Bb     : String := -"[img]";  
   Fin_Img_Bb : String := -"[/img]";  
   Img_Html   : String := -"<img src=";  

   Link_Bb       : String := -"[url=";  
   Fin_Link_Bb   : String := -"[/url]";  
   Link_Html     : String := -"<a href=";  
   Fin_Link_Html : String := -"</a>";  

   Size_Bb       : String := -"[size=";  
   Fin_Size_Bb   : String := -"[/size]";  
   Size_Html     : String := -"<font size=";  
   Fin_Size_Html : String := -"</font>";  

   Color_Bb       : String := -"[color=";  
   Fin_Color_Bb   : String := -"[/color]";  
   Color_Html     : String := -"<font color=";  
   Fin_Color_Html : String := -"</font>";  

   Salto_Html : String := -"<br>";  


   ---------------
   Link_Tc : String := -"Link_TC";  

   Icono_1  : String := -"Icon1.gif";  
   Icono_2  : String := -"Icon2.gif";  
   Icono_3  : String := -"Icon3.gif";  
   Icono_4  : String := -"Icon4.gif";  
   Icono_5  : String := -"Icon5.gif";  
   Icono_6  : String := -"Icon6.gif";  
   Icono_7  : String := -"Icon7.gif";  
   Icono_8  : String := -"Icon8.gif";  
   Icono_9  : String := -"Icon9.gif";  
   Icono_10 : String := -"Icon10.gif";  

   Icono_11 : String := -"Icon11.gif";  
   Icono_12 : String := -"Icon12.gif";  
   Icono_13 : String := -"Icon13.gif";  
   Icono_14 : String := -"Icon14.gif";  
   Icono_15 : String := -"Icon15.gif";  
   Icono_16 : String := -"Icon16.gif";  
   Icono_17 : String := -"Icon17.gif";  
   Icono_18 : String := -"Icon18.gif";  
   Icono_19 : String := -"Icon19.gif";  
   Icono_20 : String := -"Icon20.gif";  

   Icono_21 : String := -"Icon21.gif";  
   Icono_22 : String := -"Icon22.gif";  
   Icono_23 : String := -"Icon23.gif";  
   Icono_24 : String := -"Icon24.gif";  
   Icono_25 : String := -"Icon25.gif";  
   Icono_26 : String := -"Icon26.gif";  
   Icono_27 : String := -"Icon27.gif";  
   Icono_28 : String := -"Icon28.gif";  
   Icono_29 : String := -"Icon29.gif";  
   Icono_30 : String := -"Icon30.gif";  

   Icono_31 : String := -"Icon31.gif";  
   Icono_32 : String := -"Icon32.gif";  
   Icono_33 : String := -"Icon33.gif";  
   Icono_34 : String := -"Icon34.gif";  
   Icono_35 : String := -"Icon35.gif";  
   Icono_36 : String := -"Icon36.gif";  
   Icono_37 : String := -"Icon37.gif";  
   Icono_38 : String := -"Icon38.gif";  
   Icono_39 : String := -"Icon39.gif";  
   Icono_40 : String := -"Icon40.gif";  

   Icono_Madera : String := -"ResourceIcon1.gif";  
   Icono_Barro  : String := -"ResourceIcon2.gif";  
   Icono_Hierro : String := -"ResourceIcon3.gif";  
   Icono_Grano  : String := -"ResourceIcon4.gif"; 
   
   Consumo_Cereal: String:= -"CropPerHour.gif";

   ---------------------
   -- Tipo_De_Informe --
   ---------------------
   procedure Tipo_De_Informe (
         X : Natural ) is 
   begin
      Tipo_Informe:=X;
   end Tipo_De_Informe;




   -------------
   -- Negrita --
   -------------

   procedure Negrita (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Negrita_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Negrita_Html);
      end if;
   end Negrita;

   -----------------
   -- Fin_Negrita --
   -----------------

   procedure Fin_Negrita (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Fin_Negrita_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Fin_Negrita_Html);
      end if;
   end Fin_Negrita;

   ---------------
   -- Subrayado --
   ---------------

   procedure Subrayado (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Subrayado_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Subrayado_Html);
      end if;
   end Subrayado;


   -------------------
   -- Fin_Subrayado --
   -------------------

   procedure Fin_Subrayado (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Fin_Subrayado_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Fin_Subrayado_Html);
      end if;
   end Fin_Subrayado;




   -------------
   -- Cursiva --
   -------------

   procedure Cursiva (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Cursiva_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Cursiva_Html);
      end if;
   end Cursiva;

   -----------------
   -- Fin_Cursiva --
   -----------------

   procedure Fin_Cursiva (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Fin_Cursiva_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Fin_Cursiva_Html);
      end if;
   end Fin_Cursiva;



   ------------
   -- Imagen --
   ------------

   procedure Imagen (
         F    : File_Type; 
         Ruta : String     ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Img_Bb);
         Put(F,Obtener_Codigo(Ruta));
         Put(F,Fin_Img_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Img_Html);
         Put(F,Obtener_Codigo(Ruta));
         Put(F,Fin_Html);
      end if;
   end Imagen;



   ----------
   -- Link --
   ----------

   procedure Link (
         F    : File_Type; 
         Ruta : String     ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Link_Bb);
         Put(F,Obtener_Codigo(Ruta));
         Put(F,Fin_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Link_Html);
         Put(F,Obtener_Codigo(Ruta));
         Put(F,Fin_Html);
      end if;
   end Link;

   --------------
   -- Fin_Link --
   --------------

   procedure Fin_Link (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Fin_Link_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Fin_Link_Html);
      end if;
   end Fin_Link;


   ------------
   -- Tamaño --
   ------------

   procedure Tamaño (
         F : File_Type; 
         T : Positive   ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Size_Bb);
         Put(F, formulas.Quita_Espacios(Positive'Image(T)));
         Put(F, Fin_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Size_Html);
         Put(F, formulas.Quita_Espacios(Positive'Image(T)));
         Put(F, Fin_Html);
      end if;
   end Tamaño;

   ----------------
   -- Fin_Tamaño --
   ----------------

   procedure Fin_Tamaño (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F, Fin_Size_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F, Fin_Size_Html);
      end if;
   end Fin_Tamaño;


   -----------
   -- Color --
   -----------

   procedure Color (
         F : File_Type; 
         C : T_Color    ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F,Color_Bb);
         Put(F, T_Color'Image(C));
         Put(F, Fin_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F,Color_Html);
         Put(F, T_Color'Image(C));
         Put(F, Fin_Html);
      end if;
   end Color;


   ---------------
   -- Fin_Color --
   ---------------

   procedure Fin_Color (
         F : File_Type ) is 
   begin
      if Tipo_Informe=2 then -- BBCODE
         Put(F, Fin_Color_Bb);
      elsif Tipo_Informe=3 then -- HTML
         Put(F, Fin_Color_Html);
      end if;
   end Fin_Color;


   -- <br>
   procedure Salto_Linea (
         F : File_Type ) is 
   begin
      if Tipo_Informe=3 then -- HTML
         Put(F, Salto_Html);
         --New_Line(F);
      else
         New_Line(F);
      end if;
   end Salto_Linea;


   -- Mira los código y devuelve la equivalencia
   function Obtener_Codigo (
         S : String ) 
     return String is 
   begin
      if S="Link_Tc" then
         return Link_Tc;
      elsif S="Icono_1" then
         return Icono_1;
      elsif S="Icono_2" then
         return Icono_2;
      elsif S="Icono_3" then
         return Icono_3;
      elsif S="Icono_4" then
         return Icono_4;
      elsif S="Icono_5" then
         return Icono_5;
      elsif S="Icono_6" then
         return Icono_6;
      elsif S="Icono_7" then
         return Icono_7;
      elsif S="Icono_8" then
         return Icono_8;
      elsif S="Icono_9" then
         return Icono_9;
      elsif S="Icono_10" then
         return Icono_10;

      elsif S="Icono_11" then
         return Icono_11;
      elsif S="Icono_12" then
         return Icono_12;
      elsif S="Icono_13" then
         return Icono_13;
      elsif S="Icono_14" then
         return Icono_14;
      elsif S="Icono_15" then
         return Icono_15;
      elsif S="Icono_16" then
         return Icono_16;
      elsif S="Icono_17" then
         return Icono_17;
      elsif S="Icono_18" then
         return Icono_18;
      elsif S="Icono_19" then
         return Icono_19;
      elsif S="Icono_20" then
         return Icono_20;

      elsif S="Icono_21" then
         return Icono_21;
      elsif S="Icono_22" then
         return Icono_22;
      elsif S="Icono_23" then
         return Icono_23;
      elsif S="Icono_24" then
         return Icono_24;
      elsif S="Icono_25" then
         return Icono_25;
      elsif S="Icono_26" then
         return Icono_26;
      elsif S="Icono_27" then
         return Icono_27;
      elsif S="Icono_28" then
         return Icono_28;
      elsif S="Icono_29" then
         return Icono_29;
      elsif S="Icono_30" then
         return Icono_30;

      elsif S="Icono_31" then
         return Icono_31;
      elsif S="Icono_32" then
         return Icono_32;
      elsif S="Icono_33" then
         return Icono_33;
      elsif S="Icono_34" then
         return Icono_34;
      elsif S="Icono_35" then
         return Icono_35;
      elsif S="Icono_36" then
         return Icono_36;
      elsif S="Icono_37" then
         return Icono_37;
      elsif S="Icono_38" then
         return Icono_38;
      elsif S="Icono_39" then
         return Icono_39;
      elsif S="Icono_40" then
         return Icono_40;

      elsif S="Icono_Madera" then
         return Icono_Madera;
      elsif S="Icono_Barro" then
         return Icono_Barro;
      elsif S="Icono_Hierro" then
         return Icono_Hierro;
      elsif S="Icono_Grano" then
         return Icono_Grano;
         
      elsif S="Consumo_Cereal_Defensor" then
         return Consumo_Cereal;
      elsif S="Consumo_Cereal_Atacante" then
         return Consumo_Cereal;         
      end if;
      return S;
   end Obtener_Codigo;


end Bbcode_Html;

