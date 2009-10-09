-- And this is how small a chat icon addon can go!

local _addMessage = ChatFrame1.AddMessage
local TypeIcons = {}

local function iconify(link)
	local type, id = link:match("|H(%w+):(%w+)")

	local icon = TypeIcons[type] and TypeIcons[type](id)
	if(not icon) then return link end

	-- Don't like: brackets
	link = link:gsub("%[(.-)%]", "%1")

	return ("|T%s:16:16:0:0|t %s"):format(icon, link)
end

local function addMessage(self, text, ...)
	text = text:gsub("(|c%x+|H.-|h|r)", iconify)
	return _addMessage(self, text, ...)
end

TypeIcons["spell"] = function(id) return select(3, GetSpellInfo(id)) end
TypeIcons["achievement"] = function(id) return select(10, GetAchievementInfo(id)) end
TypeIcons["item"] = GetItemIcon

for i=1, 7 do
	_G["ChatFrame"..i].AddMessage = addMessage
end