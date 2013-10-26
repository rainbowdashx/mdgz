
local MDGZ = CreateFrame("frame")
MDGZ:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

MDGZ:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT");




function MDGZ:CHAT_MSG_GUILD_ACHIEVEMENT(...)
	local arg={...}
	local msg="gz "
	local name=arg[2]
	local rnd = math.random(1,100)  
	if (rnd <30) then
		msg="das ist tolle Arbeit Freunde"
	elseif(rnd>29 and rnd <40) then
		msg ="ein toller erfolg, " .. name
	elseif(rnd >39 and rnd <60)then
		msg="gz  "..name
	elseif(rnd>59 and rnd <80) then
		msg="gut gemacht "..name
	elseif(rnd>99) then
		msg="Endlich jemand, der seinen Shop versteht!"		
	elseif(rnd>94) then 
		msg="Ich dreh durch, Klasse Typ"
	elseif(rnd>90) then
		msg="Eher nicht so schwer, " ..name
	elseif(rnd>85) then 
		msg="Bunter ist eh Besser, "..name
	else
		msg="gz "
	end
    SendChatMessage(msg,"GUILD")
end
