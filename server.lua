RegisterNetEvent("ui-bugreport:sendReport")
AddEventHandler("ui-bugreport:sendReport", function(data)

  discord = data['data'][1]
  description = data['data'][2]

  local fields = {}
  table.insert(fields, { name = "Name:", value = GetPlayerName(source), inline = true })
  table.insert(fields, { name = "Steam ID:", value = GetPlayerIdentifiers(src)[1], inline = true })
  table.insert(fields, { name = "Bug name:", value = discord, inline = true })
  table.insert(fields, { name = "Description:", value = description, inline = false }) 


  PerformHttpRequest(Config.discordwebhooklink, function(err, text, headers) end, 'POST', json.encode(
    {
      username = "Bug Reports",
      embeds = {
        {
          title = "New Bug Report",
          color = 16769280,
          fields = fields
        }
      },
    }), { ['Content-Type'] = 'application/json' })


  TriggerClientEvent("ui-bugreport:reportSent", source)
TriggerClientEvent("pNotify:SendNotification", source,{text = "Your bug report was successfully sent to our developers", type = "success", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_open", close = "gta_effects_fade_out"},killer = true})


end)


Citizen.CreateThread(function()
	if (GetCurrentResourceName() ~= "ui-bugreport") then 
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named ui-bugreport for it to work properly!");
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named ui-bugreport for it to work properly!");
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named ui-bugreport for it to work properly!");
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named ui-bugreport for it to work properly!");
	end
end)

-- Version Check
Citizen.CreateThread(
	function()
		local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
		if vRaw and Config.versionCheck then
			local v = json.decode(vRaw)
			PerformHttpRequest(
				'https://raw.githubusercontent.com/techygamebar/standalone-ui-bugreport/main/version.json',
				function(code, res, headers)
					if code == 200 then
						local rv = json.decode(res)
						if rv.version ~= v.version then
							print(
								([[^1-------------------------------------------------------ui-bugreport UPDATE: %s AVAILABLECHANGELOG: %s-------------------------------------------------------^0]]):format(rv.version,rv.changelog))

						end
					else
						print('^ui-bugreport was unable to check version^0')
					end
				end,
				'GET'
			)
		end
	end
)
