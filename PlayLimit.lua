local frame = CreateFrame("FRAME", "PlayLimitFrame");
frame:RegisterEvent("ADDON_LOADED");

local function eventHandler(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "PlayLimit" then
		if PlayLimitDB == nil then
			PlayLimitDB = {};
			PlayLimitDB.endDate = getNewEndDate();
			PlayLimitDB.gameTimer = 0; 
		end
	startPlayCounter();
	end
end

frame:SetScript("OnEvent", eventHandler);

function getNewEndDate()
  local today = os.date("*t", os.time());
  local endDate = os.time() + (8 - today.wday) * 24 * 3600;
  
  return endDate;
end

function startPlayCounter()
	for (;;)
		if (os.time() > PlayLimitDB.endDate) then
  			print("start new timer and set end date to next sunday.");
  			PlayLimitDB.endDate = getNewEndDate();
  			PlayLimitDB.gameTimer = 0;
		end
		sleep(60);
		PlayLimitDB.gameTimer = PlayLimitDB.gameTimer + 60;
		
		if (os.time() < PlayLimitDB.endDate and PlayLimitDB.gameTimer >= 21600) then
  			print('playtime has expired, kick player offline.');
  			Logout();
		end
	end

	local function sleep(n)
		local t0 = clock()
  		while clock() - t0 <= n do end
	end
end
