local totals=50
local lastMsg=0
local lastAutoGreet = 0

--==================OPTIONS

--true  für AN
--false für AUS

local autoGZ = true
local leuteBegruessen = true	

--=========================
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
		{msg="Endlich jemand, der seinen Shop versteht!", weight = 2},
		{msg="Ich dreh durch, Klasse Typ", weight=5},
		{msg="Eher nicht so schwer, {name}" , weight=2},
		{msg="Gute Arbeit bald hast du Bunter eingeholt! {name}", weight=2},
		{msg="Gut gemacht {name}", weight=25},
		{msg="gz  {name}", weight=40},
		{msg="Ein toller Erfolg, {name}", weight =5},
		{msg="Atemberaubend, {name}" , weight	=5},
		{msg="gz ", weight=40},
		{msg="gratz ", weight=40},
		{msg="GZ {name}", weight=40},
		{msg="Bunter hat's schon lang {name}", weight=5},
		{msg="Puh.. {name}, Holla die Waldfee!",weight=1},
		{msg="{name} ich will ein Kind von dir!",weight=2},
		{msg="Hut ab! {name}",weight=20},
		{msg="Dieser {name} geht ab!",weight=10},
		{msg="Wie Charlie Sheen in Hot Shots!",weight=1},
		{msg="Sheesh, {name}!",weight=30},
		{msg="gratz {name}", weight=40},
		{msg="Torgo approved, {name}!",weight=5},
		{msg="The Freak gefällt das, {name}!",weight=10},
		{msg="Ich bin stolz auf dich, {name}!",weight=2},
		{msg="Fantastisch, {name}!",weight=10},
		{msg="Klasse!",weight=20},
		{msg="Spitzenmäßig!",weight=20},
		{msg="Spitze!",weight=20},
		{msg="Gönn ich dir, {name}",weight=6},
		{msg="Cool {name}, hole ich mir auch!",weight=2},
		{msg="Geilomatic",weight=8},
		{msg="Sickadelic",weight=15},
		{msg="Ich Fellipe aus {name}, richtig Großkreutz style",weight=5},
		{msg="Beste YA, {name}",weight=30},
		{msg="Beste YA",weight=30},
		{msg="Super, {name}",weight=30},
		{msg="Super",weight=30},
		{msg="Torgastisch!!!",weight=10},
		{msg="Teuflisch! {name}",weight=10},
		{msg="{name}, kannst du mir später dabei helfen, das achievement auch zu machen, wär cool!",weight=5},
		{msg="Weiss jemand warum mein Bigwigs nicht funktioniert?",weight=2},
		{msg="Wie komm ich nochmal Schattenhochland?",weight=2},
		{msg="Kann später jmd meinen Twink durch Kloster ziehen?",weight=2},

}

local greets={
	"Hallo","Hui","Huhu","halo","hallo","hai","wuhu","boing","hi","halöööö","wuihu"
}

local  ggs = {
	"gg", "gg wp","ggwp","wp","stronk"
}

local nps = {
	"np","jo np","gerne doch","kein ding"
}

local greetPatterns = {"abend","hallo","huhu","guten tag","servus","was geht","halo","guten morgen","moin"}
local thanksPatterns={"thx","danke","thanks"}

totals=weighted_total(msgs)

local MDGZ = CreateFrame("frame")
MDGZ:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)


if (autoGZ) then MDGZ:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT"); end
if (leuteBegruessen) then MDGZ:RegisterEvent("CHAT_MSG_GUILD"); end


function MDGZ:CHAT_MSG_GUILD_ACHIEVEMENT(...)
	if (lastMsg < time())then
		local arg={...}
		local msg="gz"
		local name=arg[2]
		local msg=weighted_random_choice(msgs)
		name=string.gsub(name,"-Echsenkessel","")
		if (name ~=UnitName("player"))then
			msg=string.gsub(msg, "{name}", name)
			SendChatMessage(msg,"GUILD")
		end
		lastMsg=time()+2 --2 seconds 
	end
end

function MDGZ:CHAT_MSG_GUILD(...)
	local msg=...
	local senderName=select(2,...)
	msg=string.lower(msg)
	if (senderName == UnitName("player")) then return end
	if (lastAutoGreet < time()) then
		for i = 1, #greetPatterns do
			if (string.find(msg,greetPatterns[i]))then
				SendChatMessage(greets[math.random(#greets)],"GUILD")
				lastAutoGreet=time()+10
				return
			end	
		end
		if (msg=="gg") then
			SendChatMessage(ggs[math.random(#ggs)],"GUILD")
			lastAutoGreet=time()+2
		end
		if (msg=="re") then
			SendChatMessage("wb","GUILD")
			lastAutoGreet=time()+2
		end
		for i = 1, #thanksPatterns do
			if (string.find(msg,thanksPatterns[i]))then
				SendChatMessage(nps[math.random(#nps)],"GUILD")
				lastAutoGreet=time()+3
			end
		end
		if (string.find(msg,"ziehen")) then
			SendChatMessage("ja comatose macht das gerne","GUILD")
			lastAutoGreet=time()+10
		end
	end
end

