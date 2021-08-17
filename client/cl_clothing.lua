ClothesMale = {}
ClothesFemale = {}

CreateThread(function()
	-- clothes
	for k, v in pairs(cloth_hash_names) do
		if v.category_hashname ~= "BODIES_LOWER"
			and v.category_hashname ~= "BODIES_UPPER"
			and v.category_hashname ~= "heads"
			and v.category_hashname ~= "hair"
			and v.category_hashname ~= "teeth"
			and v.category_hashname ~= "eyes"
			and v.category_hashname ~= "eyewear"
			and v.category_hashname ~= "beards_chin"
			and v.category_hashname ~= "beards_chops"
			and v.category_hashname ~= ""
			and v.category_hashname ~= "spats"
			and v.category_hashname ~= "masks"
			and v.category_hashname ~= "badges"
			and v.category_hashname ~= "accessories"
			and v.category_hashname ~= "boot_accessories"
			and v.category_hashname ~= "jewelry_rings_left"
			and v.category_hashname ~= "jewelry_rings_right"
			and v.category_hashname ~= "jewelry_bracelets"
			and v.category_hashname ~= "gauntlets"
			and v.category_hashname ~= "neckties"
			and v.category_hashname ~= "holsters_knife"
			and v.category_hashname ~= "loadouts"
			and v.category_hashname ~= "talisman_satchel"
			and v.category_hashname ~= "dresses"
			and v.category_hashname ~= "belt_buckles"
			and v.category_hashname ~= "holsters_left"
			and v.category_hashname ~= "holsters_right"
			and v.category_hashname ~= "satchels"
			and v.category_hashname ~= "ammo_rifles"
			and v.category_hashname ~= "talisman_wrist"
			and v.category_hashname ~= "armor"
		then
			if v.ped_type == 'male' and v.is_multiplayer then
				if ClothesMale[v.category_hashname] == nil then
					ClothesMale[v.category_hashname] = {}
				end
				table.insert(ClothesMale[v.category_hashname], v.hash)
			end
		end
	end
end)


exports('ChangeClothes', function(data)
	print(data.value)
	if data.value == -1 then
		Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), GetHashKey(data.key), 0)
	end
	
	-- ApplyShopItemToPed
	Citizen.InvokeNative('0xD3A7B003ED343FD9', PlayerPedId(), ClothesMale[data.key][data.value], false, true, true);
	
	-- N_0x704c908e9c405136
	Citizen.InvokeNative('0x704c908e9c405136', PlayerPedId());
	-- N_0xaab86462966168ce
	Citizen.InvokeNative('0xaab86462966168ce', PlayerPedId(), 1);
	
	-- UpdatePedVariation
	Citizen.InvokeNative('0xCC8CA3E88256E58F', PlayerPedId(), false, true, true, true, false);
end)

exports('UpdateClothes', function(clothes)
	print(clothes)
	TriggerServerEvent('chip-character:updateClothes', clothes);
end)

exports('LoadClothes', function(clothing)
	for key, value in pairs(clothing) do
		if ClothesMale[key] ~= nil then
			Citizen.InvokeNative('0xD3A7B003ED343FD9', PlayerPedId(), ClothesMale[key][value], false, true, true);
			
			-- N_0x704c908e9c405136
			Citizen.InvokeNative('0x704c908e9c405136', PlayerPedId());
			-- N_0xaab86462966168ce
			Citizen.InvokeNative('0xaab86462966168ce', PlayerPedId(), 1);
			
			-- UpdatePedVariation
			Citizen.InvokeNative('0xCC8CA3E88256E58F', PlayerPedId(), false, true, true, true, false);
		end
	end
end)