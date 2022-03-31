local totals = 50
local lastMsg = 0
local lastAutoGreet = 0

-- ==================OPTIONS

-- true  für AN
-- false für AUS

local autoGZ = true
local leuteBegruessen = true

-- =========================
function weighted_total(choices)
    local total = 0
    for i, v in ipairs(choices) do total = total + v.weight end
    return total
end

function weighted_random_choice(choices)
    local threshold = math.random(0, totals)
    local last_choice
    for i, v in ipairs(choices) do
        threshold = threshold - v.weight
        if threshold <= 0 then return v.msg end
        last_choice = v.msg
    end
    return last_choice
end

function trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end

local msgs = {
    {msg = "das ist tolle Arbeit Freunde", weight = 10},
    {msg = "Endlich jemand, der seinen Shop versteht!", weight = 2},
    {msg = "Ich dreh durch, Klasse Typ", weight = 5},
    {msg = "Eher nicht so schwer, {name}", weight = 2},
    {msg = "Gute Arbeit bald hast du Bunter eingeholt! {name}", weight = 2},
    {msg = "Ne lass {name}", weight = 15},
    {msg = "Du {name}, weiß ned", weight = 15},
    {msg = "Gut gemacht {name}", weight = 25},
    {msg = "gz  {name}", weight = 40},
    {msg = "Ein toller Erfolg, {name}", weight = 15},
    {msg = "Atemberaubend, {name}", weight = 10}, {msg = "gz ", weight = 40},
    {msg = "gratz ", weight = 40}, {msg = "GZ {name}", weight = 40},
    {msg = "Bunter hat's schon lang {name}", weight = 5},
    {msg = "Puh.. {name}, Holla die Waldfee!", weight = 1},
    {msg = "{name} ich will ein Kind von dir!", weight = 2},
    {msg = "Hut ab! {name}", weight = 20},
    {msg = "Dieser {name} geht ab!", weight = 10},
    {msg = "Wie Charlie Sheen in Hot Shots!", weight = 1},
    {msg = "Sheesh, {name}!", weight = 30}, {msg = "gratz {name}", weight = 40},
    {msg = "Torgo approved, {name}!", weight = 5},
    {msg = "The Freak gefällt das, {name}!", weight = 5},
    {msg = "Ich bin stolz auf dich, {name}!", weight = 2},
    {msg = "Fantastisch, {name}!", weight = 10}, {msg = "Klasse!", weight = 20},
    {msg = "Spitzenmäßig!", weight = 20}, {msg = "Spitze!", weight = 20},
    {msg = "Gönn ich dir, {name}", weight = 6},
    {msg = "Cool {name}, hole ich mir auch!", weight = 2},
    {msg = "Geilomatic", weight = 8}, {msg = "Sickadelic", weight = 15},
    {msg = "Ich Fellipe aus {name}, richtig Großkreutz style", weight = 2},
    {msg = "Beste YA, {name}", weight = 30}, {msg = "Beste YA", weight = 30},
    {msg = "Super, {name}", weight = 30}, {msg = "Super", weight = 30},
    {msg = "Torgastisch!!!", weight = 10},
    {msg = "Teuflisch! {name}", weight = 10},
    {msg = "Unglaublich!", weight = 10}, {msg = "BOOM !", weight = 10},
    {msg = "Yeah achiev bitch", weight = 10},
    {msg = "Bumm Bumm {name}", weight = 10},
    {msg = "#achievement", weight = 10}, {msg = "#geilertyp", weight = 10},
    {msg = "richtig shorup {name}!", weight = 15},
    {msg = "was willscht da macha", weight = 10},
    {msg = "uff hartes achievement", weight = 10},
    {msg = "Blöderalbert approved", weight = 5},
    {msg = "Für Uli!", weight = 7},
    {msg = "Endlich einer der Leischtung zeigt", weight = 10},
    {msg = "Ich weiss nicht wehr du bist AMK", weight = 5},
    {msg = "{name}, rasiert euch mit Shampoo", weight = 5},
    {msg = "Scheiß Pimmelberger.", weight = 2}

}

local greets = {
    "Hallo", "Hui", "Huhu", "halo", "hallo", "hai", "wuhu", "boing", "hi",
    "halöööö", "wuihu"
}

local byes = {
    "bye", "tschüss", "tschau", "bis morgen", "bis dann", "bb", "bubu",
    "hau rein"
}

local ggs = {"gg", "gg wp", "ggwp", "wp", "stronk"}

local nps = {
    "np", "jo np", "gerne doch", "kein ding", "np brudah", "jo kein ding",
    "immer doch"
}
local yolos = {
    "swag", "swagalicious", "#swag", "#swaghettiyolonese", "#yoloswagbabbo!",
    "chabbo swag", "yolo", "BOOM yolo swag", "no homo", "shorup digga!"
}

local plexAnswers = {
    "mvp", "INGNITE SPREADED NIII !!!!", "Gürtel 1!!", "70 stunde", "MAN ey!"
}

local helpAnswers = {
    "Wenn man da etwas ändern möchte, dann probiert man den Leuten zu helfen."
}

local normals = {"Normal"}
local ask = {"didn't ask"}

local greetPatterns = {
    "abend", "hallo", "huhu", "servus", "sers", "was geht", "halo",
    "guten morgen", "moin", "hai", "hi", "tag", "holla"
}
local thanksPatterns = {"thx", "danke", "thanks", "dankeschön"}
local byePatterns = {
    "bye", "tschüss", "tschau", "bis morgen", "bis dann", "bb"
}
local normalPatterns = {
    "wie gehts", "was geht", "geiles addon", "macro", "wie geht es"
}
local plexPatterns = {"plex", "flex", "fleks"}
local helpPatterns = {
    "passiert nichts", "keine lust", "kein bock mehr", "kein bock"
}

totals = weighted_total(msgs)

local MDGZ = CreateFrame("frame")
MDGZ:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

MDGZ:RegisterEvent("ADDON_LOADED");
if (autoGZ) then MDGZ:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT"); end
if (leuteBegruessen) then MDGZ:RegisterEvent("CHAT_MSG_GUILD"); end


function MDGZ:ADDON_LOADED(addon,...)
	if addon == "mdgz" then
	mdGzData =
			{
				statetab =  (mdGzData ~= nil and mdGzData.statetab) or {},
			}
	end
end


function MDGZ:CHAT_MSG_GUILD_ACHIEVEMENT(...)
    if (lastMsg < time() and math.random(100) > 40) then
        local arg = {...}
        local msg = "gz"
        local name = arg[2]
        local msg = weighted_random_choice(msgs)

        index = string.find(name, "-")
        if (index ~= nil) then name = string.sub(name, 0, index - 1) end

        local checkName = string.lower(name)
        if checkName == "spacedout" then
            name = "Spaceworld"
        end

        if (name ~= UnitName("player")) then
            msg = string.gsub(msg, "{name}", name)
            SendChatMessage(msg, "GUILD")
        end
        lastMsg = time() + 2 -- 2 seconds 
    end
end

function MDGZ:CHAT_MSG_GUILD(...)
    local msg = ...
    local senderName = select(2, ...)

    index = string.find(senderName, "-")
    if (index ~= nil) then senderName = string.sub(senderName, 0, index - 1) end
    msg = string.lower(msg)

    if (senderName == UnitName("player")) then
        lastAutoGreet = time() + 5
        return
    end

    if (lastAutoGreet < time()) then
        if (string.find(trim(msg), ".*%?$")) then -- ending with ? | continue;
            SendChatMessage(ask[math.random(#ask)], "GUILD")
            lastAutoGreet = time() + 2
        end
        for i = 1, #greetPatterns do
            if (string.find(string.gsub(msg, "(.*)", " %1 "),
                            "[^%a]" .. greetPatterns[i] .. "[^%a]")) then
                SendChatMessage(greets[math.random(#greets)], "GUILD")
                lastAutoGreet = time() + 10
                return
            end
        end
        if (msg == "gg") then
            SendChatMessage(ggs[math.random(#ggs)], "GUILD")
            lastAutoGreet = time() + 5
            return
        end
        if (msg == "re") then
            SendChatMessage("wb", "GUILD")
            lastAutoGreet = time() + 5
            return
        end
        if (string.find(string.gsub(msg, "(.*)", " %1 "), "[^%a]yolo[^%a]")) then
            SendChatMessage(yolos[math.random(#yolos)], "GUILD")
            lastAutoGreet = time() + 5
            return
        end
        if (string.find(string.gsub(msg, "(.*)", " %1 "), "[^%a]swag[^%a]")) then
            SendChatMessage(yolos[math.random(#yolos)], "GUILD")
            lastAutoGreet = time() + 5
            return
        end
        for i = 1, #plexPatterns do
            if (string.find(string.gsub(msg, "(.*)", " %1 "),
                            "[^%a]" .. plexPatterns[i] .. "[^%a]")) then
                SendChatMessage(plexAnswers[math.random(#plexAnswers)], "GUILD")
                lastAutoGreet = time() + 5
                return
            end
        end
        for i = 1, #byePatterns do
            if (string.find(string.gsub(msg, "(.*)", " %1 "),
                            "[^%a]" .. byePatterns[i] .. "[^%a]")) then
                SendChatMessage(byes[math.random(#byes)], "GUILD")
                lastAutoGreet = time() + 10
                return
            end
        end
        for i = 1, #thanksPatterns do
            if (string.find(string.gsub(msg, "(.*)", " %1 "),
                            "[^%a]" .. thanksPatterns[i] .. "[^%a]")) then
                SendChatMessage(nps[math.random(#nps)], "GUILD")
                lastAutoGreet = time() + 5
                return
            end
        end
        for i = 1, #normalPatterns do
            if (string.find(string.gsub(msg, "(.*)", " %1 "),
                            "[^%a]" .. normalPatterns[i] .. "[^%a]")) then
                SendChatMessage(normals[math.random(#normals)], "GUILD")
                lastAutoGreet = time() + 5
                return
            end
        end
        for i = 1, #helpPatterns do
            if (string.find(string.gsub(msg, "(.*)", " %1 "),
                            "[^%a]" .. helpPatterns[i] .. "[^%a]")) then
                SendChatMessage(helpAnswers[math.random(#helpAnswers)], "GUILD")
                lastAutoGreet = time() + 5
                return
            end
        end
    end
   -- print(buildWords(msg))
end

function allwords(msg)
    local line = msg 
    local pos = 1 
    return function() 

        local s, e = string.find(line, "%w+", pos)
        if s then 
            pos = e + 1 
            return string.sub(line, s, e) 
        end

        return nil 
    end
end

function prefix(w1, w2) return w1 .. ' ' .. w2 end



function insert(index, value)
    if not mdGzData.statetab[index] then mdGzData.statetab[index] = {} end
    table.insert(mdGzData.statetab[index], value)
end

local N = 2
local MAXGEN = 100
local NOWORD = "\n"

function buildWords(msg)
       local out = ""
    local w1, w2 = NOWORD, NOWORD
    for w in allwords(msg) do

        insert(prefix(w1, w2), w)
        w1 = w2;
        w2 = w;
    end
    insert(prefix(w1, w2), NOWORD)

  
    w1 = NOWORD;
    w2 = NOWORD 

    for i = 1, MAXGEN do
        local list = mdGzData.statetab[prefix(w1, w2)]
        local nextword = list[math.random(#list)]
        if nextword == NOWORD then return out end
        out = out .. " " .. nextword
        w1 = w2;
        w2 = nextword
    end
    return out
end
