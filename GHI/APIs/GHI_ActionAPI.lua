﻿--===================================================
--								GHI Action API
--									ghi_actionAPI.lua
--
--		Application Interface for scripts to execute functions relevant for actions
--		Handles relevant security checks on the API calls.
--	
-- 						(c)2012 The Gryphonheart Team
--								All rights reserved
--===================================================	


local class;
function GHI_ActionAPI()
	if class then
		return class;
	end

	class = GHClass("GHI_ActionAPI");

	local api = {};
	--local itemGuid, itemSlot, itemBag, itemCreatorGuid, playerIsCreator, playerGuid, playerName;

	local currentStack, currentItem;

	local expressionHandler = GHI_ExpressionHandler();
	local buffHandler = GHI_BuffHandler();
	local areaSound = GHI_AreaSound();
	local containerList = GHI_ContainerList();
	local log = GHI_Log();
	local itemList = GHI_ItemInfoList();
	local itemGuid;
	api._SetActionAPIItemGuid = function(guid)
		itemGuid = guid;
	end

	api.GHI_Emote = function(text, delay, target, evtManualItemGuid)
		expressionHandler.SendChatMessage(text, "EMOTE", nil, target, delay, evtManualItemGuid or itemGuid, true);
	end
	api.GHI_Say = function(text, delay, evtManualItemGuid) expressionHandler.SendChatMessage(text, nil, nil, nil, delay, evtManualItemGuid or itemGuid, true); end
	api.GHI_ApplyBuff = function(...) buffHandler.CastBuff(...); end
	api.GHI_CountBuffs = function(name, unit) return buffHandler.CountBuffs(name, unit) end
	api.GHI_RemoveBuff = function(name, filter, count, delay) return buffHandler.RemoveBuff(name, filter, count, delay) end
	api.GHI_RemoveAllBuffs = function() buffHandler.RemoveAllBuffs() end
	api.GHI_PlaySound = function(path, delay) areaSound.PlaySound(path, 0, delay); end
	api.GHI_PlayAreaSound = function(path, range, delay) areaSound.PlaySound(path, range, delay); end

	api.GHI_SendChatMessage = function(text, chatType, language, channel, delay, evtManualItemGuid)
		expressionHandler.SendChatMessage(text, chatType, language, channel, delay, evtManualItemGuid or itemGuid, true);
	end
	-- book 
	api.GHI_ShowBook = function(itemContainerGuid, itemSlotGuid,title, pages, material, font, normalSize, h1Size, h2Size)
		local currentStack = containerList.GetStack(itemContainerGuid, itemSlotGuid);
		if not(currentStack) then
			return;
		end
		local currentItem = currentStack.GetItemInfo();

		local edit = 0;
		if currentItem.IsCreatedByPlayer() then
			edit = 1;
		end

		local click = {};
		for i, page in pairs(pages) do
			click[i] = { text1 = page };
		end
		click.material = material;
		click.font = font;
		click.n = normalSize;
		click.h1 = h1Size;
		click.h2 = h2Size;
		click.pages = #(pages);
		click.Type = "book";
		click.type_name = "Book";
		click.details = title;
		click.title = title;


		GHI_ShowBook(click.title, click[1], edit, click.material, click.font, click.n, click.h1, click.h2)
		GHI_ItemTextFrameCurrentPage:SetText("1/" .. click.pages);

		if click.pages == 1 then
			GHI_ItemTextFramePrevPageButton:Hide();
			GHI_ItemTextFrameNextPageButton:Hide();
		else
			GHI_ItemTextFramePrevPageButton:Show();
			GHI_ItemTextFrameNextPageButton:Show();
		end

		GHI_ItemTextFrameScrollFrame:SetVerticalScroll(0);
		GHI_CurrentBookPage = 1;
		GHI_CurrentBookID = currentItem.GetGUID();
		GHI_CurrentBook = click;
		GHI_CurrentBookEdit = edit;
		GHI_CurrentMaterial = click.material;
	end;

	-- equip item = use EquipItemByName

	-- produce / consume item = requires the new structure
	api.GHI_ProduceItem = function(guid, amount, containerGuid)
		GHCheck("GHI_ProduceItem",{"string","number","numberStringNil"},{guid, amount, containerGuid})
		log.Add(3,"Inserting item in bag",{guid=guid, amount=amount, containerGuid=containerGuid})


		local item = itemList.GetItemInfo(guid);

		if not(item) then
			print("Item not found",guid)
			return
		end

        local _, _, _, stacksize = item.GetItemInfo();
		if containerGuid then
               if amount == 0 then return end

                    while amount > stacksize do
                         containerList.InsertItemInBag(guid, stacksize, containerGuid) ;
                         amount = amount - stacksize;
                    end
               --end
               return containerList.InsertItemInBag(guid, amount, containerGuid)
          else
               --if amount > stacksize then
               if amount == 0 then return end
                    while amount > stacksize do
                         containerList.InsertItemInMainBag(guid, stacksize, containerGuid) ;
                         amount = amount - stacksize;
                    end

               --end
			return containerList.InsertItemInMainBag(guid, amount);
		end
	end

	api.GHI_ConsumeItem = function(guid, amount)
		local stacks = containerList.FindAllStacks(guid);
	    for addr,stack in pairs(stacks) do
			local stackAmount = stack.GetTotalAmount();
			local deltaAmount = math.min(amount,stackAmount)
			containerList.DeleteItemFromBag(addr.containerGuid,addr.slot,deltaAmount);
			amount = amount - deltaAmount;
			if amount <= 0 then
				return;
			end
		end
	end

	-- bags
	api.GHI_OpenBag = function(itemContainerGuid, itemSlotGuid, size, texture)
		local currentStack = containerList.GetStack(itemContainerGuid, itemSlotGuid);
		if currentStack then
			local currentItem = currentStack.GetItemInfo();
			local containerGuid;
			for i = 1, currentStack.GetItemInstanceCount() do
				containerGuid = currentStack.GetAttribute("bagContainerGuid",i)
				if containerGuid then
					local name, icon;
					if currentItem then
						name, icon = currentItem.GetItemInfo();
					end
					containerList.OpenBag(containerGuid, currentStack, size, texture, name, icon)
					return;
				end
			end
			if currentItem then
				local name, icon = currentItem.GetItemInfo();
				containerList.OpenBag(currentItem.GetGUID() .. "Bag", currentStack, size, texture, name, icon)
				return;
			end
		end
	end
	--screen flash
	local GHFlashFrame
	api.GHI_ScreenFlash = function(fadeIn, fadeOut, duration, color,alpha)
		if alpha == nil then
			alpha = 1
		elseif alpha > 1 then
			alpha = 1
		end
		
		if not (GHFlashFrame) then
			GHFlashFrame = CreateFrame("Frame", "GHFlashFrame", UIParent);
			GHFlashFrame:SetFrameStrata("BACKGROUND");
			GHFlashFrame:SetAllPoints(UIParent);
			GHFlashFrame.bg = GHFlashFrame:CreateTexture(nil, "CENTER")
			GHFlashFrame.bg:SetAllPoints(GHFlashFrame)
		end		
		
        if type(color) == "string" then
			if string.find(color,"\\") then
				--print("\\ found")
				GHFlashFrame.bg:SetTexture(color)
				GHFlashFrame.bg:SetBlendMode("ADD")
				GHFlashFrame.bg:SetAlpha(alpha)
			else
				local api = GHI_MiscAPI().GetAPI()
				local colorList = api.GHI_GetColors()
				local color = colorList[color]
				--print("\\ not found")
				GHFlashFrame.bg:SetTexture(color.r or color[1], color.g or color[2], color.b or color[3],alpha)
				GHFlashFrame.bg:SetBlendMode("DISABLE")
			end
        elseif type(color) == "table" then
			GHFlashFrame.bg:SetTexture(color.r or color[1], color.g or color[2], color.b or color[3],alpha)
        end
		
          --if duration == nil then duration = 5 end;
		if UIFrameIsFading(GHFlashFrame) then return end --previous flash check
		UIFrameFlash(GHFlashFrame, fadeIn, fadeOut, duration, false, 0, duration - (fadeIn+fadeOut))
	end --end screen flash
	
	local flashAnims, isAni
	api.GHI_ScreenFlash2 = function(fadeIn, fadeOut, duration, color, alpha, repeating)
	  local delay = duration - (fadeIn + fadeOut)
	  	  if repeating == nil then
		repeating = 1
	  end
	  
	  if not (GHFlashFrame) then
		GHFlashFrame = CreateFrame("Frame", "GHFlashFrame", UIParent);
		GHFlashFrame:SetFrameStrata("BACKGROUND");
		GHFlashFrame:SetAllPoints(UIParent);
		GHFlashFrame.bg = GHFlashFrame:CreateTexture(nil, "CENTER")
		GHFlashFrame.bg:SetAllPoints(GHFlashFrame)
	  end 
	  if not (flashAnims) then
		flashAnims = GHFlashFrame:CreateAnimationGroup("Flashing")
		flashAnims.fadingIn = flashAnims:CreateAnimation("Alpha")
		flashAnims.fadingIn:SetOrder(1)
		flashAnims.fadingIn:SetSmoothing("NONE")
		flashAnims.fadingIn:SetChange(1)
		flashAnims.fadingOut = flashAnims:CreateAnimation("Alpha")
		flashAnims.fadingOut:SetOrder(2)
		flashAnims.fadingOut:SetSmoothing("NONE")
		flashAnims.fadingOut:SetChange(-1)
		flashAnims:SetScript("OnFinished",function(self,requested)
			GHFlashFrame:Hide()
			GHFlashFrame.bg:SetBlendMode("DISABLE")
			isAni = false
		end)
		flashAnims:SetScript("OnPlay",function(self)
		  GHFlashFrame:Show()
		  GHFlashFrame:SetAlpha(0)
		  isAni = true
		end)
	  end      
	  	  
	 flashAnims.fadingIn:SetDuration(fadeIn)
	 flashAnims.fadingIn:SetEndDelay(delay)
	 flashAnims.fadingOut:SetDuration(fadeOut)
	  
	  if repeating > 1 then
		flashAnims:SetLooping("REPEAT")
	  else
		flashAnims:SetLooping("NONE")
	  end
	  local timestart = time()
	  local looptime = duration * repeating
	  
	  flashAnims:SetScript("OnLoop", function(self, loopstate)
		  if loopstate == "FORWARD" then
			local curtime = time()
			if difftime(curtime, timestart) == looptime - duration then
			  flashAnims:SetLooping("NONE")
			end
		  end
	  end)
	  
	  if type(color) == "string" then
		if string.find(color,"\\") then
		  GHFlashFrame.bg:SetAlpha(alpha or 1)
		  GHFlashFrame.bg:SetTexture(color)
		  GHFlashFrame.bg:SetBlendMode("ADD")
		else
		  local api = GHI_MiscAPI().GetAPI()
		  local colorList = api.GHI_GetColors()
		  local color = colorList[color]
		  GHFlashFrame.bg:SetTexture(color.r or color[1], color.g or color[2], color.b or color[3])
		  GHFlashFrame.bg:SetAlpha(alpha or 1)
		end
	  elseif type(color) == "table" then
		GHFlashFrame.bg:SetTexture(color.r or color[1], color.g or color[2], color.b or color[3])
		GHFlashFrame.bg:SetAlpha(alpha or 1)
	  end
	  if isAni == true then -- if sone is already animating, stop it and do the new one
		GHFlashFrame:StopAnimating()
		GHFlashFrame.bg:SetAlpha(alpha or 1)
		flashAnims:Play()
	  else -- otherwise animate
		flashAnims:Play()
	  end
	  
	end


	api.GHI_ScreenShake = function(duration,intensity,text)
		if UnitAffectingCombat("player") then
			if text == nil then
			text = "The world around you shakes."
			end
			UIErrorsFrame:AddMessage(text, 1,0.25,0.25)
		else
			if intensity > 64 then
				intensity = 64
			end
			local f = CreateFrame("Frame")
			local WorldFrame = WorldFrame
			local WorldFramePoints = {}
			f:Hide()
			f:SetScript("OnUpdate",
			function(self, elapsed)
				duration = duration - elapsed
				if duration < 0 then
					duration = 0
					f:Hide()
				end
				local moveBy = math.random(-intensity, intensity) * duration
				WorldFrame:ClearAllPoints()
				for _, v in pairs(WorldFramePoints) do
					WorldFrame:SetPoint(v[1], v[2], v[3], v[4] + moveBy, v[5] + moveBy)
				end
			end
			)
			f:RegisterEvent("PLAYER_REGEN_DISABLED")
			f:SetScript("OnEvent",function(self,event)
				if event == "PLAYER_REGEN_DISABLED" then
				self:Hide()	
				end		
			end)
			for i = 1, WorldFrame:GetNumPoints() do
			WorldFramePoints[i] = { WorldFrame:GetPoint(i) }
			end
			f:Show()
		end
	end
	api.IsRequirementFullfilled = function(rType,rDetail,exeFunc)
		--req type check
		if rType == "Name" then
			local n = UnitName("player");
			if n == rDetail then
				return true;
			else
				return false;
			end;
		elseif rType == "Level" then
			local l = UnitLevel("player");
			if l >= tonumber(rDetail) then
				return true;
			else
				return false;
			end
		elseif rType == "Zone" then
			local n = GetRealZoneText();
			if n == rDetail then
				return true;
			else
				return false;
			end;
		elseif rType == "SubZone" then
			local n = GetSubZoneText();
			if n == rDetail then
				return true;
			else
				return false;
			end;
		elseif rType == "Guild" then
			local n = GetGuildInfo("player");
			if n == rDetail then
			   return true;
			else
				return false;
			end;
		elseif rType == "Class" then
			local n = UnitClass("player");
			if n == rDetail then
				return true;
			else
				return false;
			end;
		elseif rType == "Race" then
			local n = UnitRace("player");
			if n == rDetail then
				return true;
			else
				return false;
			end;
		elseif rType == "Gender" then
			local d = 0;
			if strlower(rDetail) == "n" or strlower(rDetail) == "none" then
				d = 1;
			elseif strlower(rDetail) == "m" or strlower(rDetail) == "male" then
				d = 2;
			elseif strlower(rDetail) == "f" or strlower(rDetail) == "female" then
				d = 3;
			end
			local n = UnitSex("player");
			if n == d then
				return true;
			else
				return false;
			end;
		elseif rType == "Normal Item" then
			local n = GetItemCount(rDetail);
			if n > 0 then
				return true;
			else
				return false;
			end;
		elseif rType == "Base Stats" then
			local  d = 0;
			if strlower(rDetail) == "str" or strlower(rDetail) == "strength" then
				d = 1;
			elseif strlower(rDetail) == "agi" or strlower(rDetail) == "agility" then
				d = 2;
			elseif strlower(rDetail) == "sta" or strlower(rDetail) == "stamina" then
				d = 3;
			elseif strlower(rDetail) == "int" or strlower(rDetail) == "intellect" then
				d = 4;
			elseif strlower(rDetail) == "spi" or strlower(rDetail) == "spirit" then
				d = 5;
			elseif strlower(rDetail) == "arm" or strlower(rDetail) == "armor" then
				d = 6;
			end
			local n = 0;
			if (d < 6) and (d > 0) then
				_, n = UnitStat("player", d);
			else
				n = UnitArmor("player");
			end
			local statNumb = tonumber(string.match(rDetail, "%d+"))
			if n >= statNumb then
				return true;
			else
			   return false;
			end
		elseif rType == "Reputation" then
			for i = 1, GetNumFactions() do
				local name, _, _, _, _, level = GetFactionInfo(i);
				if strlower(name) == strlower(rDetail) then
				local repNumb = tonumber(string.match(rDetail, "%d+"))
					 if level == repNumb then
						  return true;
					 else
						  return false
					 end
				end
			end
			return 0;
		elseif rType == "Honor Kills" then
			local n = GetPVPLifetimeStats();
			if n == tonumber(rDetail) then
				return true;
			else
				return false
			end
		elseif rType == "Normal Buff" then
			local i = 1;
			local name = "";
			local k = nil;
			while not (name == nil) and k == nil do
				name = UnitBuff("player", i);
				if name == rDetail then
					 k = i;
				end
				i = i + 1;
			end
			i = 1;
			while not (name == nil) and k == nil do
				name = UnitDebuff("player", i);
				if name == rDetail then
					 k = i;
				end
				i = i + 1;
			end

			if not (k == nil) then
				return true;
			else
				return false;
			end;
		elseif rType == "GHI Buff" then

			if api.GHI_CountBuffs(rDetail, "player") > 0 then
				return true;
			else
				return false;
			end
		elseif rType == "LUA Statement" then

		rDetail = gsub(rDetail, "\21", " ");
		rDetail = gsub(rDetail, "\22", ",");
			--print(rDetail)
			local res = exeFunc("return " .. rDetail..";");
			if res == true or res == 1 then
				return true
			else
				return false
			end
			--[[
			local codeblock = "if "..rDetail.." then return true else return false end"
			local res, errorMessage = loadstring(codeblock)
			--print(res())
			if res() == true or res() == 1 then
				return true;
			else
				return false;
			end --]]
		end

	end

	api.GHI_Message = function(msg)

		if itemGuid then
			msg = expressionHandler.InsertLinksInText(msg,itemGuid)
		end
		local info = ChatTypeInfo["LOOT"];
		DEFAULT_CHAT_FRAME:AddMessage(msg, info.r, info.g, info.b, info.id);
	end
	GHI_Message = api.GHI_Message;

	local effectFrame = CreateFrame("Frame");
	effectFrame:SetAllPoints(UIParent);
	effectFrame.GetParent = nil;
	effectFrame.GetPoint = nil;
	local effectTexture = effectFrame:CreateTexture();
	effectTexture:SetAllPoints(effectFrame);
	effectTexture:SetTexture(1,0,0);
	effectFrame:Hide();
	api.GHI_EffectFrameEffect3 = effectFrame;
	api.GHI_EffectFrameEffect3Texture = effectTexture;




	-- alias functions
	api.emote = api.GHI_Emote;
	api.Emote = api.GHI_Emote;
	api.GHI_DoEmote = api.GHI_Emote;
	api.DoEmote = function(e,target) api.GHI_Emote(e,nil,target); end
	api.say = api.GHI_Say;
	api.SendChatMessage = api.GHI_SendChatMessage;
	api.ApplyBuff = api.GHI_ApplyBuff;
	api.ApplyGHIBuff  = api.GHI_ApplyBuff;
	api.RemoveGHIBuff = api.GHI_RemoveBuff;
	api.RemoveAllGHIBuffs = api.GHI_RemoveAllBuffs;
	api.CountGHIBuff = api.GHI_CountBuff;
    api.GHI_FindItem = api.GHI_FindOneItem;

	class.GetAPI = function()
		local a = {};
		for i, f in pairs(api) do
			a[i] = f;
		end
		return a;
	end
	--[[
	class.UpdateMeta = function(stack)
		currentStack = stack;
		if stack then
			currentItem = stack.GetItemInfo()
			itemGuid = currentItem.GetGUID();
		else
			currentItem = nil;
		end
	end    --]]

	--playerGuid = UnitGUID("player");
	--playerName = UnitName("player");

	return class;
end


