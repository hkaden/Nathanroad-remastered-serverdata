local languageCode = ConfigData.primaryLanguage
local languageData

function _translate(translateName, ...) 
    if languageData == nil then
        print("[veryinsanee's Authentication] Unknown error while translating: " .. translateName)
        return
    end

    if languageData.messages[translateName] == nil then
        print("[veryinsanee's Authentication] Translation \"" .. translateName .. "\" in languages/" .. languageCode .. ".json not avaliable.")
        return
    end

    return string.format(languageData.messages[translateName], ...)
end

function initLanguages()
    languageData = LoadResourceFile(GetCurrentResourceName(), "languages/" .. languageCode .. '.json')

    if languageData == nil then
        print("[veryinsanee's Authentication] Language languages/" .. languageCode .. ".json doesn't exist.")
        return
    end

    languageData = json.decode(languageData)

    local count = 0
    for value in pairs(languageData.messages) do
        count = count + 1
    end

    print("[veryinsanee's Authentication] Language " .. languageData.languageName .. " (languages/" .. languageData.languageCode .. ".json) from " .. languageData.author .. " with " .. count  .. " translations has been loaded.")
    return languageData
end
