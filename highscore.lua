highscore={
   scores={0,0,0,0,0,0,0,0,0,0}
}


function highscore.draw()
   love.graphics.setFont(fTiny)
   love.graphics.print("Highscores",1100,5)
   local x=22
   for i=1,10 do
      love.graphics.print(i .. ".",1100,x)
      love.graphics.printf(highscore.scores[i],1100,x,75,'right')
      x=x+17
   end
   love.graphics.setFont(fSmall)

end

function highscore.update(score)
   for i=1,10 do
      if score>highscore.scores[i] then
	 highscore.pushScore(i,score)
	 break
      end
   end

end

function highscore.pushScore(index,score)
   for i=1,10-index do
      highscore.scores[11-i]=highscore.scores[10-i]
   end
   highscore.scores[index]=score
end
