local lastClothingCoords = nil
local currentClothingPosition = nil
local camera = nil

local clothingPrompt = exports['chip-prompts']:CreatePromptGroup('Clothing');
clothingPrompt.createPrompt('Customize', 0x41AC83D1, false, function()
	openClothingMenu()
end)

CreateThread(function()
	for k, v in pairs(Config.ClothingStores) do
		local zone = BoxZone:Create(v.vector, v.width, v.length, {
			name = v.name,
			heading = v.heading,
			minZ = v.minZ,
			maxZ = v.maxZ,
			debugPoly = false
		})
		
		zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
			if isPointInside then
				clothingPrompt.show();
				lastClothingCoords = zone:getBoundingBoxCenter()
				print('coords', lastClothingCoords)
			else
				clothingPrompt.hide();
			end
		end)
	end
end)


-- Functions

local setClothingPosition = function()
	local ped = PlayerPedId()
	local coords = vector3(-329.3356, 775.4654, 121.6339)
	SetEntityCoordsNoOffset(ped, coords, true, true, true)
	SetEntityHeading(ped, 261.549)
	FreezeEntityPosition(ped, true)
end

local createClothingCam = function()
	local coords = vector3(-327.9784, 774.4452, 121.839)
	local cam, camName = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, 0.0, 0.0, 0.0, 70.0, true, 2)
	SetCamActive(cam, true)
	RenderScriptCams(true, false, 0, 0, 0)
	PointCamAtCoord(cam, -334.0356, 779.0654, 121.6339)
	print('cam', cam)
	camera = cam
end

function openClothingMenu()
	setClothingPosition()
	createClothingCam()
	
	TriggerServerEvent('character:fetchClothing')
	
	exports['chip-ui']:NUISendClothing(ClothesMale)
end

exports('CloseClothing', function()
	local ped = PlayerPedId()
	SetEntityCoords(ped, lastClothingCoords)
	FreezeEntityPosition(ped, false)
	DestroyCam(camera, true)
end)


