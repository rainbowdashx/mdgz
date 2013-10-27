local totals=50
local lastMsg=0
function weighted_total(choices)
	local total = 0
	for i, v in ipairs(choices) do
		total = total + v.weight
	end
	return total
end

function weighted_random_choice(choices)
	local threshold = math.random(0, totals)
	local last_choice
	for i,v in ipairs(choices) do
		threshold = threshold - v.weight
		if threshold <= 0 then return v.msg end
		last_choice = v.msg
	end
	return last_choice
end


local msgs={
		{msg="das ist tolle Arbeit Freunde" , weight=20},
		{msg="Endlich jemand, der seinen Shop versteht!", weight = 25},
		{msg="Ich dreh durch, Klasse Typ", weight=20},
		{msg="Eher nicht so schwer, {name}" , weight=25},
		{msg="Gute Arbeit bald hast du Bunter eingeholt! {name}", weight=30},
		{msg="Gut gemacht {name}", weight=35},
		{msg="gz  {name}", weight=30},
		{msg="Ein toller Erfolg, {name}", weight =35},
		{msg="Atemberaubend, {name}" , weight	=30},
		{msg="gz ", weight=35},
		{msg="Bunter hat's schon lang {name}", weight=20},
		{msg="Puh.. {name}, Holla die Waldfee!",weight=20},
		{msg="{name} ich will ein Kind von dir!",weight=20},
		{msg="Hut ab! {name}",weight=20},
		{msg="Dieser {name} geht ab!",weight=20},
		{msg="Wie Charlie Sheen in Hot Shots!",weight=20},
}

totals=weighted_total(msgs)

local MDGZ = CreateFrame("frame")
MDGZ:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

MDGZ:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT");




function MDGZ:CHAT_MSG_GUILD_ACHIEVEMENT(...)
	if (lastMsg < time())then
		local arg={...}
		local msg="gz"
		local name=arg[2]
		local msg=weighted_random_choice(msgs)

		if (name ~=UnitName("player"))then
			msg=string.gsub(msg, "{name}", name)
			SendChatMessage(msg,"GUILD")
		end
		lastMsg=time()+2 --2 seconds 
	end
end




