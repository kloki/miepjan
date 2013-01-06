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

game={
}


function game:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function game:reset()
   self.starting=true
   self.counter=0
   self.index=math.random(0,4)
   self.step=0
   self.stepsize=0.5
   self.direction=math.random(0,1)
   self.answer="1"
end

function game:update(dt)
   self.step=self.step+dt
   if self.step>self.stepsize then
      self.step=self.step-self.stepsize
      self.counter=self.counter+1
      
      self:updateIndex()
      self:determineCorrect()
      
      if self.answer=="Miep" or self.answer=="Miep ,Jan" then
	 if self.direction==0 then
	    self.direction=1
	 else
	    self.direction=0
	 end
      end
   end
end

function game:draw()
   love.graphics.print(self.counter,40,40)
   love.graphics.print(self.answer,40,60)
end

function game:updateIndex()
   if self.direction==0 then
      self.index=self.index+1
   else
      self.index=self.index-1
   end
   if self.index==5 then
      self.index=0
   elseif self.index==-1 then
      self.index=4
   end
      
end

function game:determineCorrect()
   if self.counter%5==0 or instring(self.counter,"5")then
      if self.counter%7==0 or instring(self.counter,"7") then
	 self.answer="Miep ,Jan"
      else
	 self.answer="Jan"
      end
   elseif self.counter%7==0 or instring(self.counter,"7")then
      self.answer="Miep"
   else
      self.answer=self.counter
   end
end

function instring(stringer,match)
   stringer=tostring(stringer)
   local answer=false
   for i = 1, #stringer do
      local c = stringer:sub(i,i)
      if c==match then
	 answer=true
	 break
      end
   end

   return answer
end