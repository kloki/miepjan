-- kloki
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.
--
-- Koen Klinkers k.klinkers@gmail.com

pause={
   layer=love.graphics.newImage("images/pause.png"),
   titleColor={255,255,255},
   text="press Z to speak the number, N to shout Jan and M to shout Miep.\n\n Press the any key to start.",
   switch=0,
   flicker=0.1,
}

function pause.update(dt)
   pause.switch=pause.switch+dt
   if pause.switch>pause.flicker then
      pause.switch=pause.switch-pause.flicker
      if pause.titleColor[3]==255 then
	 pause.titleColor={255,200,0}
      else
	 pause.titleColor={255,255,255}
      end
   end

end

function pause.draw()
   love.graphics.draw(pause.layer,0,0)
   love.graphics.setColor(pause.titleColor)
   love.graphics.setFont(fBig)
   love.graphics.printf("MiepJan the Game",0,100,1200,"center")
   love.graphics.setColor(255,255,255)
   love.graphics.setFont(fSmall)
   love.graphics.printf(pause.text,200,300,800,"center")
   
end

function pause.On(update)
   pause.text=update
   mode=0
end