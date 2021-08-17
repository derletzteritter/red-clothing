local FacialMale = {}
local FacialFemale = {}

CreateThread(function()
	for k, v in pairs(cloth_hash_names) do
		if v.category_hashname ~= "neckwear"
			and v.category_hashname ~= 'pants'
			and v.category_hashname ~= 'coats_closed'
			and v.category_hashname ~= 'hats'
			and v.category_hashname ~= 'shirts_full'
			and v.category_hashname ~= 'dresses'
			and v.category_hashname ~= 'belts'
			and v.category_hashname ~= 'chaps'
			and v.category_hashname ~= 'cloaks'
			and v.category_hashname ~= 'gunbelts'
			and v.category_hashname ~= 'boots'
			and v.category_hashname ~= 'ponchos'
			and v.category_hashname ~= 'coats'
			and v.category_hashname ~= 'gloves'
			and v.category_hashname ~= 'vests'
			and v.category_hashname ~= "belt_buckles"
			and v.category_hashname ~= "holsters_left"
			and v.category_hashname ~= "holsters_right"
			and v.category_hashname ~= "satchels"
			and v.category_hashname ~= "ammo_rifles"
			and v.category_hashname ~= "talisman_wrist"
			and v.category_hashname ~= "armor"
			and v.category_hashname ~= "jewelry_rings_left"
			and v.category_hashname ~= "jewelry_rings_right"
			and v.category_hashname ~= "jewelry_bracelets"
			and v.category_hashname ~= "gauntlets"
			and v.category_hashname ~= "neckties"
			and v.category_hashname ~= "holsters_knife"
			and v.category_hashname ~= "loadouts"
			and v.category_hashname ~= "talisman_satchel"
		then
			if v.ped_type == 'male' and v.is_multiplayer then
				if FacialMale[v.category_hashname] == nil then
					FacialMale[v.category_hashname] = {}
				end
				table.insert(FacialMale[v.category_hashname], v.hash)
			end
		end
	end
end)

RegisterNetEvent('chip-clothing:sendClothesValue')
AddEventHandler('chip-clothing:sendClothesValue', function(clothes)
	exports['chip-ui']:NUISendClothingValue(clothes);
end)

exports('LoadBody', function(body)
	print('I got the clothes')
	for key, value in pairs(body) do
		print(key, value)
		if FacialMale[key] ~= nil then
			Citizen.InvokeNative('0xD3A7B003ED343FD9', PlayerPedId(), FacialMale[key][value], false, true, true);
			
			-- N_0x704c908e9c405136
			Citizen.InvokeNative('0x704c908e9c405136', PlayerPedId());
			-- N_0xaab86462966168ce
			Citizen.InvokeNative('0xaab86462966168ce', PlayerPedId(), 1);
			
			-- UpdatePedVariation
			Citizen.InvokeNative('0xCC8CA3E88256E58F', PlayerPedId(), false, true, true, true, false);
		end
	end
end)
