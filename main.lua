# kloki
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# Koen Klinkers k.klinkers@gmail.com



function love.load()
   math.randomseed( os.time() )
   screenheight=640
   screenwidth=1024
   debug=false
end

function love.draw()

end

function love.update(dt)

end


function love.keypressed(key)

   if key=='escape' then
      love.event.quit()
   elseif key=='f' then
      love.graphics.toggleFullscreen()
   end


end


function love.quit()
  print("One step closer to world hegemony.")
end



