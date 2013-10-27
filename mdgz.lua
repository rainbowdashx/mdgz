local totals=50
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
		{msg="das ist tolle Arbeit Freunde" , weight=10},
		{msg="Endlich jemand, der seinen Shop versteht!", weight = 10},
		{msg="Ich dreh durch, Klasse Typ", weight=10},
		{msg="Eher nicht so schwer, {name}" , weight=10},
		{msg="Gute Arbeit bald hast du Bunter eingeholt! {name}", weight=10},
		{msg="gut gemacht {name}", weight=10},
		{msg="gz  {name}", weight=10},
		{msg="ein toller erfolg, {name}", weight =10},
		{msg="Atemberaubend {name}" , weight	=10},
		{msg="gz ", weight=10},
		{msg="gz trotz battle battle", weight=20},
}

totals=weighted_total(msgs)

local MDGZ = CreateFrame("frame")
MDGZ:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

MDGZ:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT");




function MDGZ:CHAT_MSG_GUILD_ACHIEVEMENT(...)
	local arg={...}
	local msg="gz"
	local name=arg[2]
	local msg=weighted_random_choice(msgs)
	msg=string.gsub(msg, "{name}", name)
    SendChatMessage(msg,"GUILD")
end




