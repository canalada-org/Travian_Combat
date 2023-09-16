with Ada.Text_Io, Operaciones,Tablas;
use Ada.Text_Io, Operaciones,Tablas;

-- Archivo de ejemplo 
-- Con un poco más de trabajo se puede hacer un simulador de combate 
-- para consola


procedure Prueba is 

   Pueblo_Atacante      : T_Pueblos;  
   Atacante,  
   Defensor_Romano,  
   Defensor_Galo,  
   Defensor_Germano     : Ejercito;  
   Ratio_Habitantes     : Float     := 1.0;  
   Nivel_Palacio        : Integer   := 1;  
   Res_Atacante,  
   Res_Defensor_Romano,  
   Res_Defensor_Galo,  
   Res_Defensor_Germano : Ejercito;  
begin

   Pueblo_Atacante:=Germanos;
   Atacante:=((
         (10,0),
         (0,0),
         (50,0),
         (0,0),
         (60,0),
         (70,0),
         (50,0),
         (8,0),
         (0,0),
         (0,0)

         ),0);
   Defensor_Romano:=((
         (0,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0)

         ),0);

   Defensor_Galo:=((
         (60,0),
         (10,0),
         (0,0),
         (0,0),
         (60,0),
         (30,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0)

         ),0);

   Defensor_Germano:=((
         (0,0),
         (150,0),
         (1,0),
         (0,0),
         (1,0),
         (24,0),
         (0,0),
         (0,0),
         (0,0),
         (0,0)

         ),10);



   Calcular_Resultado (
      Pueblo_Atacante,
      Atacante,
      Defensor_Romano,
      Defensor_Galo,
      Defensor_Germano,
      Ratio_Habitantes,
      Nivel_Palacio,
      Res_Atacante,
      Res_Defensor_Romano,
      Res_Defensor_Galo,
      Res_Defensor_Germano );

   Put("Atacante:");
   New_Line;
   for I in 1..10 loop
      Put (Res_Atacante.Tropas(I).Cantidad'Img);
   end loop;
   New_Line;
   Put("Defensores:");
   New_Line;
   for I in 1..10 loop
      Put (Res_Defensor_Romano.Tropas(I).Cantidad'Img);
   end loop;
   New_Line;
   for I in 1..10 loop
      Put (Res_Defensor_Galo.Tropas(I).Cantidad'Img);
   end loop;
   New_Line;
   for I in 1..10 loop
      Put (Res_Defensor_Germano.Tropas(I).Cantidad'Img);
   end loop;

end Prueba;