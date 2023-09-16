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


separate(simulador)

procedure Cambiar_Naturaleza is 


begin

   Naturaleza:= not Naturaleza;


   -- Cambiamos dibujos
   Cargar_Imagenes;


   if Naturaleza then
      -- Cambiamos a combate contra animales

      -- Desactivamos casillas
      for I in 1..10 loop
         Set_Text(Casillas_Tropas_Defensor_Romano(I).Nivel,"");
         Disable(Casillas_Tropas_Defensor_Romano(I).Nivel);
         Set_Text(Casillas_Tropas_Defensor_Galo(I).Nivel,"");
         Disable(Casillas_Tropas_Defensor_Galo(I).Nivel);
         Set_Text(Casillas_Tropas_Defensor_Galo(I).Tropas,"");
         Disable(Casillas_Tropas_Defensor_Galo(I).Tropas);
         Set_Text(Casillas_Tropas_Defensor_Germano(I).Nivel,"");
         Disable(Casillas_Tropas_Defensor_Germano(I).Nivel);
         Set_Text(Casillas_Tropas_Defensor_Germano(I).Tropas,"");
         Disable(Casillas_Tropas_Defensor_Germano(I).Tropas);
      end loop;

      ---- Habitantes agresor
      Set_Text(Edit_Hab_Agresor , "");
      Disable(Edit_Hab_Agresor);
      ---- Habitantes defensor
      Set_Text(Edit_Hab_Defensor, "");
      Disable(Edit_Hab_Defensor);
      ---- Palacio
      Set_Text(Edit_Palacio_Defensor, "");
      Disable(Edit_Palacio_Defensor);
      ---- Murallas
      Set_Text( Edit_Muralla_Defensor, "");
      Disable( Edit_Muralla_Defensor);
      Set_Text( Edit_Terraplen_Defensor, "");
      Disable( Edit_Terraplen_Defensor);
      Set_Text( Edit_Empalizada_Defensor, "");
      Disable( Edit_Empalizada_Defensor);



      -- Cambiamos tipo de ataque
      Set_State(Radio_Atraco, True);
      Set_State(Radio_Normal,False);
      Disable (Radio_Normal);

   else
      -- Cambiamos a combate contra tropas

      -- Activar casillas
      for I in 1..10 loop
         Enable(Casillas_Tropas_Defensor_Romano(I).Nivel);
         Enable(Casillas_Tropas_Defensor_Galo(I).Nivel);
         Enable(Casillas_Tropas_Defensor_Galo(I).Tropas);
         Enable(Casillas_Tropas_Defensor_Germano(I).Nivel);
         Enable(Casillas_Tropas_Defensor_Germano(I).Tropas);
      end loop;

      ---- Habitantes agresor
      Enable(Edit_Hab_Agresor);
      ---- Habitantes defensor
      Enable(Edit_Hab_Defensor);
      ---- Palacio
      Enable(Edit_Palacio_Defensor);
      ---- Murallas
      Enable( Edit_Muralla_Defensor);
      Enable( Edit_Terraplen_Defensor);
      Enable( Edit_Empalizada_Defensor);



      -- Cambiamos tipo de ataque
      Set_State(Radio_Atraco, False);
      Set_State(Radio_Normal,True);
      Enable(Radio_Normal);

   end if;





end cambiar_Naturaleza;
