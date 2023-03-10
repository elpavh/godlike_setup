CaveBot.Editor.ExampleFunctions = {}

local function addExampleFunction(title, text)
  return table.insert(CaveBot.Editor.ExampleFunctions, {title, text:trim()})
end

addExampleFunction("Click to browse example functions", [[
-- available functions/variables:
-- prev - result of previous action (true or false)
-- retries - number of retries of current function, goes up by one when you return "retry"
-- delay(number) - delays bot next action, value in milliseconds
-- gotoLabel(string) - goes to specific label, return true if label exists
-- you can easily access bot extensions, Depositer.run() instead of CaveBot.Extensions.Depositer.run()
-- also you can access bot global variables, like CaveBot, TargetBot
-- use storage variable to store date between calls

-- function should return false, true or "retry"
-- if "retry" is returned, function will be executed again in 20 ms (so better call delay before)

return true
]])

addExampleFunction("buy 200 mana potion from npc Eryn", [[
--buy 200 mana potions
local npc = getCreatureByName("Eryn")
if not npc then 
  return false 
end
if retries > 10 then
  return false
end
local pos = player:getPosition()
local npcPos = npc:getPosition()
if math.max(math.abs(pos.x - npcPos.x), math.abs(pos.y - npcPos.y)) > 3 then
  autoWalk(npcPos, {precision=3})
  delay(300)
  return "retry"
end
if not NPC.isTrading() then
  NPC.say("hi")
  NPC.say("trade")
  delay(200)
  return "retry"
end
NPC.buy(268, 100)
schedule(1000, function()
  -- buy again in 1s
  NPC.buy(268, 100)
  NPC.closeTrade()
  NPC.say("bye")
end)
delay(1200)
return true
]])

addExampleFunction("Say hello 5 times with some delay", [[
--say hello
if retries > 5 then
  return true -- finish
end
say("hello")
delay(100 + retries * 100)
return "retry"
]])

addExampleFunction("Disable TargetBot", [[
TargetBot.setOff()
return true
]])

addExampleFunction("Enable TargetBot", [[
TargetBot.setOn()
return true
]])

addExampleFunction("Enable TargetBot luring", [[
TargetBot.enableLuring()
return true
]])

addExampleFunction("Disable TargetBot luring", [[
TargetBot.disableLuring()
return true
]])

addExampleFunction("Logout", [[
g_game.safeLogout()
delay(1000)
return "retry"
]])

addExampleFunction("Tirar Lux en 40 monsters (7sqm de distancia)", [[
    local amount = 0
    for _, n in ipairs(getSpectators(false)) do
        if n:isMonster() and getDistanceBetween(pos(), n:getPosition()) <= 7 then
            amount = amount + 1
        end
    end

    if amount <= 40 then
        return true
    end

    if manapercent() > 50 then
        say('exevo mas lux')
    end

    return "retry"
]])