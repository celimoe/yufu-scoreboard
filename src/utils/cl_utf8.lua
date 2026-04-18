local upperCharMap = {
	["А"] = "а", ["Б"] = "б", ["В"] = "в", ["Г"] = "г", ["Д"] = "д",
	["Е"] = "е", ["Ё"] = "ё", ["Ж"] = "ж", ["З"] = "з", ["И"] = "и",
	["Й"] = "й", ["К"] = "к", ["Л"] = "л", ["М"] = "м", ["Н"] = "н",
	["О"] = "о", ["П"] = "п", ["Р"] = "р", ["С"] = "с", ["Т"] = "т",
	["У"] = "у", ["Ф"] = "ф", ["Х"] = "х", ["Ц"] = "ц", ["Ч"] = "ч",
	["Ш"] = "ш", ["Щ"] = "щ", ["Ъ"] = "ъ", ["Ы"] = "ы", ["Ь"] = "ь",
	["Э"] = "э", ["Ю"] = "ю", ["Я"] = "я",
	["Є"] = "є", ["І"] = "і", ["Ї"] = "ї", ["Ґ"] = "ґ"
}

function utf8.lower(str)
	if type(str) ~= "string" then
		error(string.format("bad argument #1 to 'lower' (string expected, got %s)", type(str)), 2)
	end

	if str == "" then
		return ""
	end

	local source = utf8.force and utf8.force(str) or str
	local result = {}

	for _, code in utf8.codes(source) do
		local char = utf8.char(code)
		result[#result + 1] = upperCharMap[char] or string.lower(char)
	end

	return table.concat(result)
end