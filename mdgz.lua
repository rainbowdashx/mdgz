
local MDGZ = CreateFrame("frame")
MDGZ:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

MDGZ:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT");




function MDGZ:CHAT_MSG_GUILD_ACHIEVEMENT(...)
	local arg={...}
	local msg="gz "
	rnd = math.random(1,100)  
	if (rnd <30) then
		msg="gz "
	else if(rnd>29 and rnd <40) then
		msg ="ein toller erfolg, "
	else if(rnd >39 and rnd <60)then
		msg="gz  "
	else
		msg="gz "
	end
    SendChatMessage(msg..arg[2],"GUILD")
end
