----------------------------------------------------------------------------
--   This is  free software;  you can  redistribute it  and/or  modify       
--   it  under terms of the GNU  General  Public License as published by     
--   the Free Software Foundation; either version 2, or (at your option)     
--   any later version.   'Travian Combat' is distributed  in the  hope  that  it     
--   will be useful, but WITHOUT ANY  WARRANTY; without even the implied     
--   warranty of MERCHANTABILITY   or FITNESS FOR  A PARTICULAR PURPOSE.     
--   See the GNU General Public  License  for more details.
--   You should have received a copy of the GNU General Public License
--   along with this program; if not, write to the Free Software
--   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.        
--   More info:
--   http://www.gnu.org/copyleft/gpl.html         
----------------------------------------------------------------------------
with Formulas,Ada.Strings.Unbounded,Ada.Calendar;
use Formulas,Ada.Strings.Unbounded,Ada.Calendar;

with Operaciones;


separate(Calculadora)

procedure Cultura is 

   Salir : exception;  


   -- Comprobamos si el usuario ha introducido algún dato nuevo. 
   function Usuario_Introducio_Datos_Nuevos return Boolean is 
   begin
      if Modified(Produccion_Cultura) or Modified(Cultura_Actual) or
            Modified(Numero_Aldeas) then
         return True;
      end if;

      for I in 1..Max_Niveles_Ayuntamiento loop
         if Modified( Datos_Ayuntamiento(I) ) then
            return True;
         end if;
      end loop;
      return False;
   end Usuario_Introducio_Datos_Nuevos;



   -- Ponemos "-" en todas las labels porque los datos son nulos 
   procedure Poner_Datos_Nulos is 
   begin
      for J in 1..Numero_Aldeas_Futuras loop
         Set_Text(Edit_Info_Aldeas_Futuras(J), "-");
         Set_Text(Label_Pc_Necesaria(J), "-");
         Set_Text(Label_Disponible(J), "-");
      end loop;
   end Poner_Datos_Nulos;


   -- Ponemos "-" en todas las labels porque los datos son  incorrectos
   -- Dejamos el resto de los datos
   procedure Poner_Datos_Incorrectos is 
   begin
      for J in 1..Numero_Aldeas_Futuras loop
         Set_Text(Label_Disponible(J), Nom_Datos_Invalidos);
      end loop;
   end Poner_Datos_Incorrectos;



   -- Dado un nivel de ayuntamiento, devuelve el tiempo en segundos hasta la próxima fiesta 
   -- que de más cultura (es decir, niveles 1-9 fiesta pequeña, 10-20 fiesta grande)
   function Tiempo_Proxima_Fiesta (
         Nivel : Natural ) 
     return Integer is 
   begin
      if Nivel<10 then
         return  Tiempo_Necesario_Fiesta_Pequeña(Nivel);
      elsif Nivel>=10 and Nivel<=20 then
         return  Tiempo_Necesario_Fiesta_Grande(Nivel);
      else
         return -1;
      end if;
   end Tiempo_Proxima_Fiesta;




   -- Devuelve un string con la fecha obtenida de sumar
   -- el Tiempo en segundos a la hora actual.
   -- Tiempo debe ser POSITIVO.
   function Obtener_Hora (
         Tiempo : Integer ) 
     return String is 
      Tiempo_Final : Time;  
      Horas,  
      Minutos      : Integer;  
   begin
      Tiempo_Final:=Clock+Duration(Tiempo);

      Horas:=Integer(Seconds(Tiempo_Final))/3600;
      Minutos:=(Integer(Seconds(Tiempo_Final))-(3600*Horas))/60;

      -- Hoy
      if Day (Tiempo_Final)=Day(Clock) and Month(Tiempo_Final)=Month(
            Clock) and Year(Tiempo_Final)=Year(Clock) then
         return
            Texto_Construccion_Hoy
            & "  "
            & Quita_Espacios(Natural'Image(Horas))
            & " : "
            & Quita_Espacios(Dos_Digitos(Minutos))
            ;
      else
         -- Otro dia
         return
            Integer'Image(Day (Tiempo_Final))
            & " / "
            & To_String(Calendario(Month(Tiempo_Final)))
            & " / "
            & Quita_Espacios(Integer'Image(Year(Tiempo_Final)))
            & "  "
            & Quita_Espacios(Natural'Image(Horas))
            & " : "
            & Quita_Espacios(Dos_Digitos(Minutos))
            ;
      end if;


   end Obtener_Hora;




   type R_Datos_Aldeas is 
      record 
         Aldea             : Positive;  
         Cultura_Necesaria : Integer;  
      end record; 
   type Vector_Cultura is array (1 .. Numero_Aldeas_Futuras) of R_Datos_Aldeas; 
   Cultura_Aldeas_Futuras : Vector_Cultura;  


   type R_Datos_Ayuntamientos is 
      record 
         Cantidad                    : Natural;  
         Tiempo_Hasta_Proxima_Fiesta : Integer;  
      end record; 
   type Vector_Numero_Ayuntamientos is array (1 .. Max_Niveles_Ayuntamiento) of R_Datos_Ayuntamientos; 
   Numero_Ayuntamientos : Vector_Numero_Ayuntamientos;  

   Numero_Actual_Aldeas,  
   Cultura_Acumulada_Actual,  
   Produccion_Cultura_Diaria  : Integer;  
   Produccion_Cultura_Segundo : Float;  


   type Vector_Enteros is array (Integer range <>) of Integer; 

   Cultura_Simulada         : Float   := 0.0;  
   Tiempo_Simulacion        : Integer := 0;   -- Tiempo transcurrido en segundos                        
   Unidad_Tiempo_Simulacion : Integer;        -- Tiempo que transcurre en cada ciclo                  

   Etapas_Simulacion : Vector_Enteros := (3600 * 24 * 3, 3600 * 24 * 7, 3600 * 24 * 7 * 4, 3600 * 24 * 7 * 8, 3600 * 24 * 7 * 20, 3600 * 24 * 365); -- 3 dias-- 1 semana-- 4 semanas-- 8 semanas-- 20 semanas-- 1 año);     

   Etapas_Unidad_Tiempo_Simulacion : Vector_Enteros := (60, 60 * 5, 60 * 15, 60 * 30, 60 * 60, 60 * 60 * 6); -- 1 minuto-- 5 minutos-- 15 minutos-- 30 minutos-- 1 hora-- 6 horas               

   Aldea_Actual_En_Analisis : Integer := 1;  


begin

   if Usuario_Introducio_Datos_Nuevos then
      raise Salir; -- No funciona, menuda mierda de JEWL!!!
   end if;

   -- Cogemos los datos
   Numero_Actual_Aldeas:= Valor(To_Unbounded_String(Get_Text(
            Numero_Aldeas)));
   Cultura_Acumulada_Actual:= Valor(To_Unbounded_String(Get_Text(
            Cultura_Actual)));
   Produccion_Cultura_Diaria:= Valor(To_Unbounded_String(Get_Text(
            Produccion_Cultura)));
   if Numero_Actual_Aldeas<0  then
      Set_Text(Numero_Aldeas, "1");
      Poner_Datos_Nulos;
      raise Salir;
   elsif Numero_Actual_Aldeas=0 then
      Poner_Datos_Nulos;
      raise Salir;
   elsif Numero_Actual_Aldeas>399  then
      Set_Text(Numero_Aldeas, "399");
      Poner_Datos_Nulos;
      raise Salir;
   end if;
   if Cultura_Acumulada_Actual<0  then
      Set_Text(Cultura_Actual, "0");
      Poner_Datos_Nulos;
      raise Salir;
   end if;
   if Produccion_Cultura_Diaria<0  then
      Set_Text(Produccion_Cultura, "0");
      Poner_Datos_Nulos;
      raise Salir;
   else
      Produccion_Cultura_Segundo:=Float(Produccion_Cultura_Diaria)/(
         3600.0*24.0);
   end if;



   for I in 1..Max_Niveles_Ayuntamiento loop
      Numero_Ayuntamientos(I).Tiempo_Hasta_Proxima_Fiesta:=
         Tiempo_Proxima_Fiesta(I);

      if Valor(To_Unbounded_String(Get_Text(Datos_Ayuntamiento(I))))>399 then
         Numero_Ayuntamientos(I).Cantidad:=399;
         Set_Text(Datos_Ayuntamiento(I), "399");
      elsif Valor(To_Unbounded_String(Get_Text(Datos_Ayuntamiento(I))))<0 then
         Numero_Ayuntamientos(I).Cantidad:=0;
         Set_Text(Datos_Ayuntamiento(I), "0");
      else
         Numero_Ayuntamientos(I).Cantidad:=Valor(To_Unbounded_String(
               Get_Text(Datos_Ayuntamiento(I))));
      end if;
   end loop;



   -- Tomamos el número de aldeas actual del jugador
   -- y calculamos la cultura necesaria que falta para las otras
   for I in Vector_Cultura'range loop
      Cultura_Aldeas_Futuras(I).Aldea:=I+Valor(To_Unbounded_String(
            Get_Text(Numero_Aldeas)));
      Set_Text(Edit_Info_Aldeas_Futuras(I), Positive'Image(
            Cultura_Aldeas_Futuras(I).Aldea));
      Cultura_Aldeas_Futuras(I).Cultura_Necesaria:=
         Operaciones.Calcular_Cultura_Necesaria(Cultura_Aldeas_Futuras(I).
         Aldea, Version_Travian)-Cultura_Acumulada_Actual;
      Set_Text(Label_Pc_Necesaria(I), Integer'Image(
            Operaciones.Calcular_Cultura_Necesaria(Cultura_Aldeas_Futuras(
                  I).Aldea, Version_Travian)));
   end loop;




   -- Si no producimos cultura, ni nos molestamos en hacer la simulacion!
   -- Para ello ponemos el tiempo de simulacion cercano al final para que termine pronto
   Tiempo_Simulacion:=Etapas_Simulacion(Etapas_Simulacion'Last)-2*
      Etapas_Unidad_Tiempo_Simulacion(Etapas_Unidad_Tiempo_Simulacion'
      First);
   if Produccion_Cultura_Diaria>0 then
      Tiempo_Simulacion:=0;
   else
      for J in 1..Max_Niveles_Ayuntamiento loop
         if Numero_Ayuntamientos(J).Cantidad>0 then
            Tiempo_Simulacion:=0;
         end if;
      end loop;
   end if;

   -- Si el usuario pone menos cultura de la necesaria (por ejemplo tiene 3 aldeas, minimo debe tener 8k, pero pone 7k)
   -- entonces los datos son erroneos!
   if Cultura_Acumulada_Actual<Operaciones.Calcular_Cultura_Necesaria(Numero_Actual_Aldeas, Version_Travian) then
      Poner_Datos_Incorrectos;
      raise Salir;
   end if;



   -------------------------------
   -- Empezamos la simulación!! --
   -------------------------------
   Unidad_Tiempo_Simulacion:=Etapas_Unidad_Tiempo_Simulacion(
      Etapas_Unidad_Tiempo_Simulacion'First);

   loop
      Tiempo_Simulacion:=Tiempo_Simulacion+Unidad_Tiempo_Simulacion;

      -- Miramos si llegamos al límite de la simulación
      -- (todas las aldeas analizadas o tiempo maximo)
      if  Aldea_Actual_En_Analisis> Numero_Aldeas_Futuras then
         exit;
      else
         if Tiempo_Simulacion > Etapas_Simulacion(Etapas_Simulacion'Last) then
            for X in Aldea_Actual_En_Analisis..Numero_Aldeas_Futuras loop
               Set_Text(Label_Disponible(X), Texto_Construccion_Imposible);
            end loop;
            exit;
         end if;
      end if;

      -- No hemos terminado la simulacion, continuamos!
      Cultura_Simulada:=Cultura_Simulada+Float(Unidad_Tiempo_Simulacion)*
         Produccion_Cultura_Segundo;

      -- Analizamos ayuntamientos
      for I in 1..Max_Niveles_Ayuntamiento loop
         Numero_Ayuntamientos(I).Tiempo_Hasta_Proxima_Fiesta:=
            Numero_Ayuntamientos(I).Tiempo_Hasta_Proxima_Fiesta-
            Unidad_Tiempo_Simulacion;
         if Numero_Ayuntamientos(I).Tiempo_Hasta_Proxima_Fiesta<=0 then
            -- Hemos terminado una festorra, empezamos otra y añadimos cultura!!
            Numero_Ayuntamientos(I).Tiempo_Hasta_Proxima_Fiesta:=
               Tiempo_Proxima_Fiesta(I);

            if I<10 then
               Cultura_Simulada:=Cultura_Simulada+Float(
                  Cultura_Fiesta_Pequeña*Numero_Ayuntamientos(I).Cantidad);
            else
               Cultura_Simulada:=Cultura_Simulada+Float(
                  Cultura_Fiesta_Grande*Numero_Ayuntamientos(I).Cantidad);
            end if;
         end if;
      end loop;

      -- Analizamos si hemos llegado a la cultura suficiente
      declare
         procedure Mirar_Cultura_De_Aldea is 
         begin
            if Aldea_Actual_En_Analisis > Numero_Aldeas_Futuras then
               null;
            else

               -- Miramos si hemos llegado a la cultura necesaria
               if Cultura_Aldeas_Futuras (Aldea_Actual_En_Analisis).
                     Cultura_Necesaria <=0 then
                  -- Ya teníamos cultura suficiente!!!
                  Set_Text(Label_Disponible(Aldea_Actual_En_Analisis),
                     Texto_Cultura_Ahora);
                  Aldea_Actual_En_Analisis:=Aldea_Actual_En_Analisis+1;
                  Mirar_Cultura_De_Aldea;
               elsif Float(Cultura_Aldeas_Futuras (
                        Aldea_Actual_En_Analisis).Cultura_Necesaria) <
                     Cultura_Simulada then
                  Set_Text(Label_Disponible(Aldea_Actual_En_Analisis),
                     Obtener_Hora(Tiempo_Simulacion));
                  Aldea_Actual_En_Analisis:=Aldea_Actual_En_Analisis+1;
                  Mirar_Cultura_De_Aldea;
               end if;


            end if;
         end Mirar_Cultura_De_Aldea;
      begin
         Mirar_Cultura_De_Aldea;
      end;


      -- Cambiamos la unidad de tiempo
      for Ind in 1..Etapas_Unidad_Tiempo_Simulacion'Length-1 loop
         if Tiempo_Simulacion>=Etapas_Simulacion(Etapas_Simulacion'Last-
               Ind)
               and Unidad_Tiempo_Simulacion<
               Etapas_Unidad_Tiempo_Simulacion(
               Etapas_Unidad_Tiempo_Simulacion'Last-Ind+1) then
            Unidad_Tiempo_Simulacion:= Etapas_Unidad_Tiempo_Simulacion(
               Etapas_Unidad_Tiempo_Simulacion'Last-Ind+1);
         end if;
      end loop;



   end loop;
   --------------------------------

exception
   when Salir =>

      null;
end Cultura;