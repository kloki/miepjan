-- kloki
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
-- along with this program. If not, see <http://www.gnu.org/licenses/>.-

-- Koen Klinkers k.klinkers@gmail.com
require "pause"
require "game"
require "TEsound"
require "highscore"

function love.load()
   math.randomseed( os.time() )
   screenheight=640
   screenwidth=1024
   debug=false
   mode=0
   background=love.graphics.newImage("images/background.jpg")
   fTiny=love.graphics.newFont("font/ChronoTrigger.ttf",20)
   fSmall=love.graphics.newFont("font/ChronoTrigger.ttf",40)
   fBig=love.graphics.newFont("font/ChronoTrigger.ttf",150)
   love.graphics.setFont(fSmall)
   cgame=game:new()
   cgame:reset()
end

function love.draw()
   love.graphics.draw(background,0,0)
   highscore.draw()
 if mode==0 then
      pause.draw()
   else
      cgame:draw()
   end
end

function love.update(dt)
   if mode==0 then
      pause.update(dt)
   else
      cgame:update(dt)
   end
   TEsound.cleanup()
end


function love.keypressed(key)
   
   if key=='escape' then
      love.event.quit()
   elseif key=='f' then
      love.graphics.toggleFullscreen()
   else
      if mode==0 then
	 mode=1
      else
	 if key=="m"or key=="n"or key=="z" then
	    TEsound.play("sounds/button.wav")
	    cgame:buttonpress(key)
	 end
      end
   end


end


function love.quit()
  print("One step closer to world hegemony.")
end



