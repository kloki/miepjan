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
require "TEsound"

game={
}


function game:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function game:reset()
   self.start=true
   self.starting=true
   self.counter=1
   self.index=math.random(1,5)
   self.step=0
   self.stepsize=0.5
   self.direction=math.random(0,1)
   self.answer="1"
   self.names={"Tally","Shortey","Gothicy","Stripey","Player"}
   self.userSpeak=false
   self.userMiep=false
   self.userJan=false
end

function game:update(dt)
   self.step=self.step+dt
   if self.start then
      if self.step>3 then
	 self.start=false
	 self.step=0
	 TEsound.play("sounds/beep.wav")
      end
   else
      if self.step>self.stepsize then
	 self.step=self.step-self.stepsize
	 self.counter=self.counter+1
	 
	 --if players turn check answer
	 if self.index==5 then
	    if self:playerFalse() then
	       TEsound.play("sounds/error.wav")
	       pause.On("You messed up. \n\n Your Score: "..self.counter.."\n\n Press the any key to try again.")

	    end
	    self.userSpeak=false
	    self.userMiep=false
	    self.userJan=false
	 end
	 self:updateIndex()
	 self:determineCorrect()


	 if self.answer=="Miep" or self.answer=="Miep ,Jan" then
	    if self.direction==0 then
	       self.direction=1
	    else
	       self.direction=0
	    end
	 end
	 TEsound.play("sounds/beep.wav")
      end
   end
end

function game:draw()
   if self.start then
      love.graphics.setColor(255,0,0)
      if self.direction==0 then
	 love.graphics.printf(self.names[self.index].. " starts! \n\n Clockwise",300,300,600,"center")
      else
	 love.graphics.printf(self.names[self.index] .. " starts! \n\n Counterclockwise",300,300,600,"center")
      end
      love.graphics.setColor(255,255,255)
   else
      love.graphics.print(self.counter,40,40)
      if self.index==1 then
	 love.graphics.print(self.answer,292,85)
      elseif self.index==2 then
	 love.graphics.print(self.answer,500,206)
      elseif self.index==3 then
	 love.graphics.print(self.answer,794,87)
      elseif self.index==4 then
	 love.graphics.print(self.answer,981,163)
      end
      --display player input
      if love.keyboard.isDown("z") then
	 love.graphics.setFont(fBig)
	 love.graphics.print(self.counter,500,280)
	 love.graphics.setFont(fSmall)
      elseif love.keyboard.isDown("n") then
	 love.graphics.setFont(fBig)
	 love.graphics.print("Jan",500,280)
	 love.graphics.setFont(fSmall)
      elseif love.keyboard.isDown("m") then
	 love.graphics.setFont(fBig)
	 love.graphics.print("Miep",500,280)
	 love.graphics.setFont(fSmall)
      end
   end
end

function game:updateIndex()
   if self.direction==0 then
      self.index=self.index+1
   else
      self.index=self.index-1
   end
   if self.index==6 then
      self.index=1
   elseif self.index==0 then
      self.index=5
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

function game:buttonpress(key)
   if self.index~=5 then
      TEsound.play("sounds/error.wav")
      pause.On("You spoke when you shouldn't have. \n\n Your Score: "..self.counter.."\n\n Press the any key to try again.")
   else 
      if key=="z" then
	 if self.userSpeak then
	    TEsound.play("sounds/error.wav")
	    pause.On("No spamming!!! \n\n Your Score: "..self.counter.."\n\n Press the any key to try again.")
	 else
	    self.userSpeak=true
	 end
      elseif key=="n" then
	 if self.userJan then
	    TEsound.play("sounds/error.wav")
	    pause.On("No spamming!!! \n\n Your Score: "..self.counter.."\n\n Press the any key to try again.")
	 else
	    self.userJan=true
	 end
      elseif key=="m" then
	 if self.userMiep then
	    TEsound.play("sounds/error.wav")
	    pause.On("No spamming!!! \n\n Your Score: "..self.counter.."\n\n Press the any key to try again.")
	 else
	    self.userMiep=true
	 end
      end
   end

end

function game:playerFalse()
   local incorrect=true
   if self.answer=="Miep"then
      if self.userSpeak==false and self.userJan==false and self.userMiep then incorrect=false end
   elseif self.answer=="Jan"then
	 if self.userSpeak==false and self.userJan and self.userMiep==false then incorrect=false end
   elseif self.answer=="Miep, Jan"then
      if self.userSpeak==false and self.userJan and self.userMiep then incorrect=false end
   else
      if self.userSpeak and self.userJan==false and self.useMiep==false then incorrect=false end
   end
   return incorrect
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