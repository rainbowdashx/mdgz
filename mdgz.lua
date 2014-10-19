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
		{msg="Ein toller Erfolg, {name}", weight =15},
		{msg="Atemberaubend, {name}" , weight=10},
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
		{msg="The Freak gefällt das, {name}!",weight=5},
		{msg="Ich bin stolz auf dich, {name}!",weight=2},
		{msg="Fantastisch, {name}!",weight=10},
		{msg="Klasse!",weight=20},
		{msg="Spitzenmäßig!",weight=20},
		{msg="Spitze!",weight=20},
		{msg="Gönn ich dir, {name}",weight=6},
		{msg="Cool {name}, hole ich mir auch!",weight=2},
		{msg="Geilomatic",weight=8},
		{msg="Sickadelic",weight=15},
		{msg="Ich Fellipe aus {name}, richtig Großkreutz style",weight=2},
		{msg="Beste YA, {name}",weight=30},
		{msg="Beste YA",weight=30},
		{msg="Super, {name}",weight=30},
		{msg="Super",weight=30},
		{msg="Torgastisch!!!",weight=10},
		{msg="Teuflisch! {name}",weight=10},
		{msg="Unglaublich!",weight=10},
		{msg="BOOM !",weight=10},
		{msg="Yeah achiev bitch",weight=10},
		{msg="Bumm Bumm {name}",weight=10},
		{msg="#achievement",weight=10},
		{msg="#geilertyp",weight=10},
		{msg="richtig shorup {name}!",weight=15},
		{msg="was willscht da macha",weight=10},
		{msg="uff hartes achievement",weight=10},
		{msg="Blöderalbert approved",weight=5},
		{msg="Für Uli!",weight=7},

}

local greets={
	"Hallo","Hui","Huhu","halo","hallo","hai","wuhu","boing","hi","halöööö","wuihu"
}

local byes={
	"bye","tschüss","tschau","bis morgen","bis dann","bb","bubu","hau rein"
}

local  ggs = {
	"gg", "gg wp","ggwp","wp","stronk"
}

local nps = {
	"np","jo np","gerne doch","kein ding","np brudah","jo kein ding","immer doch"
}
local yolos = {
	"swag","swagalicious","#swag","#swaghettiyolonese","#yoloswagbabbo!","chabbo swag","yolo","BOOM yolo swag","no homo","shorup digga!"
}

local greetPatterns = {"abend","hallo","huhu","servus","sers","was geht","halo","guten morgen","moin","hai","hi","tag","holla"}
local thanksPatterns={"thx","danke","thanks","dankeschön"}
local byePatterns={
	"bye","tschüss","tschau","bis morgen","bis dann","bb"
}

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
		name=string.gsub(name,"-Taerar","")
		name=string.gsub(name,"-Mal'Ganis","")
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

	senderName=string.gsub(senderName,"-Echsenkessel","")
	senderName=string.gsub(senderName,"-Taerar","")
	senderName=string.gsub(senderName,"-Mal'Ganis","")
	msg=string.lower(msg)
	
	if (senderName == UnitName("player")) then
		lastAutoGreet=time()+5
		return 
	end

	if (lastAutoGreet < time()) then
		for i = 1, #greetPatterns do
			if (string.find(string.gsub(msg,"(.*)"," %1 "), "[^%a]"..greetPatterns[i].."[^%a]"))then
				SendChatMessage(greets[math.random(#greets)],"GUILD")
				lastAutoGreet=time()+10
				return
			end	
		end
		if (msg=="gg") then
			SendChatMessage(ggs[math.random(#ggs)],"GUILD")
			lastAutoGreet=time()+5
			return
		end
		if (msg=="re") then
			SendChatMessage("wb","GUILD")
			lastAutoGreet=time()+5
			return
		end
		if (string.find(string.gsub(msg,"(.*)"," %1 "), "[^%a]yolo[^%a]")) then
			SendChatMessage(yolos[math.random(#yolos)],"GUILD")
			lastAutoGreet=time()+5
			return
		end
		if (string.find(string.gsub(msg,"(.*)"," %1 "), "[^%a]swag[^%a]")) then
			SendChatMessage(yolos[math.random(#yolos)],"GUILD")
			lastAutoGreet=time()+5
			return			
		end
		for i = 1, #byePatterns do
			if (string.find(string.gsub(msg,"(.*)"," %1 "), "[^%a]"..byePatterns[i].."[^%a]"))then
				SendChatMessage(byes[math.random(#byes)],"GUILD")
				lastAutoGreet=time()+10
				return
			end
		end
		for i = 1, #thanksPatterns do
			if (string.find(string.gsub(msg,"(.*)"," %1 "), "[^%a]"..thanksPatterns[i].."[^%a]"))then
				SendChatMessage(nps[math.random(#nps)],"GUILD")
				lastAutoGreet=time()+5
				return
			end
		end
	end
end

