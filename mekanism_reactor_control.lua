--               [Mekanism Reactor]
-- for Mekanism's Reactor (by Ectalite)
--
--                 [IMPORTANT]
-- This requires:
-- the graphing lib by BrainGamer https://pastebin.com/yBXSK095
-- the buttonAPI by MoparDan https://oc.cil.li/topic/255-button-api-now-for-oc-updated-9-6-2014/
-- connection to the Reactor
--
-- This is coded to fit a 5 wide and 4 high display (Tier 3)
 
buttonAPI = require("buttonAPI")
g = require("graphing")
event = require("event")
computer = require("computer")
term = require("term")
component = require("component")
gpu = component.gpu
 
reactor = component.proxy(component.list("reactor_logic_adapter")())
colors = require("colors")
side = require("sides")
 
--reactor variables
maxCaseHeat = reactor.getMaxCaseHeat()
maxPlasmaHeat = reactor.getMaxPlasmaHeat()
 
injectionRate = tonumber(reactor.getInjectionRate())
caseHeat = tonumber(reactor.getCaseHeat())
plasmaHeat = tonumber(reactor.getPlasmaHeat())
hasFuel = reactor.hasFuel()
isIgnited = reactor.isIgnited()
programQuit = false
 
--Table of buttons
function buttonAPI.fillTable()
  buttonAPI.setTable("+1", add1, 10,20,19,21)  -- x debut, x fin, y debut, y fin
  buttonAPI.setTable("+10", add10, 22,32,19,21)
  buttonAPI.setTable("+20", add20, 34,44,19,21)
  buttonAPI.setTable("-1", remove1, 10,20,23,25)
  buttonAPI.setTable("-10", remove10, 22,32,23,25)
  buttonAPI.setTable("-20", remove20, 34,44,23,25)
  buttonAPI.setTable("QUIT", quit, 65,75,22,24)
  buttonAPI.screen()
end
 
function getClick()
  local _, _, x, y = event.pull(1,touch)
  if x == nil or y == nil then
    local h, w = gpu.getResolution()
    gpu.set(h, w, ".")
    gpu.set(h, w, " ")
  else 
    buttonAPI.checkxy(x,y)
  end
end
 
function add1()
    displayGraphics()
    --injectionRate.
    --reactor.setInjectionRate(injectionRate)
    changeInjection(1)
    buttonAPI.label(1,5,"add1")
end
 
function add10()
    displayGraphics()
    --injectionRate.
    --reactor.setInjectionRate(injectionRate)
    changeInjection(10)
    buttonAPI.label(1,5,"add10")
end
 
function add20()
    displayGraphics()
    --injectionRate.
    --reactor.setInjectionRate(injectionRate)
    changeInjection(20)
    buttonAPI.label(1,5,"add20")
end
 
function remove1()
    displayGraphics()
    --injectionRate.
    --reactor.setInjectionRate(injectionRate)
    changeInjection(-1)
    buttonAPI.label(1,5,"remove1")
end
 
function remove10()
    displayGraphics()
    --injectionRate.
    --reactor.setInjectionRate(injectionRate)
    changeInjection(-10)
    buttonAPI.label(1,5,"remove10")
end
 
function remove20()
    displayGraphics()
    --injectionRate.
    --reactor.setInjectionRate(injectionRate)
    changeInjection(-20)
    buttonAPI.label(1,5,"remove20")
end
 
function quit()
    programQuit = true
end

function changeInjection(value)
    if ((injectionRate + value) > 4 or (injectionRate + value) < 100) then
      injectionRate = injectionRate + value
    end
end
 
function displayGraphics()
    buttonAPI.clear()
    buttonAPI.fillTable()
    buttonAPI.heading("Mekanism Fusion Reactor")
    buttonAPI.label(1,2,"Reactor online: "..tostring(isIgnited))
    buttonAPI.label(1,3,"InjectionRate: "..tostring(injectionRate))
end
 
gpu.setResolution(80, 25)
displayGraphics()
 
while not programQuit do
  getClick()
end