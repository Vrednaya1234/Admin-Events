
-- Библиотеки
require "lib.moonloader"
local tag = "{741DCE}RDS Events: {FFFFFF}"
local ev = require 'samp.events'
local sampev = require 'lib.samp.events'
local time = 11000
local real_time = os.date("%c")

local encoding							= require "encoding"
encoding.default 						= "CP1251"
u8 										= encoding.UTF8

local dlstatus = require('moonloader').download_status
local inicfg = require "inicfg"
local memory = require "memory"
local imgui = require("imgui")
local script_author = "Vrednaya."
local script_version = "Версия скрипта: 1.00"
local vkeys	= require "lib.vkeys"
local window_mess = imgui.ImBool(false)
local sw, sh = getScreenResolution()
local mp_combo = imgui.ImInt(0)
local arr_mp = {u8"Прятки на корабле", u8"Русская Рулетка", u8"Король Дигла", u8"Fall Guys", u8"UFC"}
local arr_prise = {u8"Вирты", u8"Очки", u8"Коины", u8"Рубли", u8"Стандарт"}
local mp_prise = imgui.ImInt(0)
local prise_kol = imgui.ImBuffer(200)
local mp_win = imgui.ImBuffer(200)
local player_id, player_nick

tServers = {
	'46.174.52.246', -- 01
        '46.174.55.87', -- 02
        '46.174.49.170', -- 03
        '46.174.55.169', -- 04
		"46.174.49.47" -- разработка
}

function checkServer(ip)
	for k, v in pairs(tServers) do
		if v == ip then 
			return true
		end
	end
	return false
end

update_state = false

local script_version = 2
local script_version_text = "1.20"

local update_url = "https://raw.githubusercontent.com/Vrednaya1234/Admin-Events/main/update.ini"
local update_path = getWorkingDirectory() .. '/config/Event/update.ini'

local script_url = "https://raw.githubusercontent.com/Vrednaya1234/Admin-Events/main/Events.lua"
local script_path = thisScript().path


local bNotf, notf = pcall(import, "imgui_notf.lua")


function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 8.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
	style.ChildWindowRounding = 8.0
	style.FrameRounding = 8.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 8.0
	style.GrabMinSize = 8.0
	style.GrabRounding = 8.0
	-- style.Alpha =
	-- style.WindowPadding =
	-- style.WindowMinSize =
	-- style.FramePadding =
	-- style.ItemInnerSpacing =
	-- style.TouchExtraPadding =
	-- style.IndentSpacing =
	-- style.ColumnsMinSpacing = ?
	-- style.ButtonTextAlign =
	-- style.DisplayWindowPadding =
	-- style.DisplaySafeAreaPadding =
	-- style.AntiAliasedLines =
	-- style.AntiAliasedShapes =
	-- style.CurveTessellationTol =

		colors[clr.Text]                 = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.22, 0.22, 0.22, 1.00)
    colors[clr.WindowBg]             = ImVec4(1.00, 1.00, 1.00, 0.71)
    colors[clr.ChildWindowBg]        = ImVec4(0.92, 0.92, 0.92, 0.00)
    colors[clr.PopupBg]              = ImVec4(1.00, 1.00, 1.00, 0.94)
    colors[clr.Border]               = ImVec4(1.00, 1.00, 1.00, 0.50)
    colors[clr.BorderShadow]         = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.77, 0.49, 0.66, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.76, 0.51, 0.66, 0.71)
    colors[clr.TitleBgActive]        = ImVec4(0.97, 0.74, 0.88, 0.74)
    colors[clr.TitleBgCollapsed]     = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(1.00, 1.00, 1.00, 0.54)
    colors[clr.ScrollbarBg]          = ImVec4(0.81, 0.81, 0.81, 0.54)
    colors[clr.ScrollbarGrab]        = ImVec4(0.78, 0.28, 0.58, 0.13)
    colors[clr.ScrollbarGrabHovered] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.Button]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.ButtonHovered]        = ImVec4(0.77, 0.52, 0.67, 0.54)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.78, 0.28, 0.58, 0.25)
    colors[clr.HeaderActive]         = ImVec4(0.79, 0.04, 0.48, 0.63)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.79, 0.44, 0.65, 0.64)
    colors[clr.SeparatorActive]      = ImVec4(0.79, 0.17, 0.54, 0.77)
    colors[clr.ResizeGrip]           = ImVec4(0.87, 0.36, 0.66, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.ResizeGripActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.76, 0.46, 0.64, 0.71)
    colors[clr.CloseButtonActive]    = ImVec4(0.78, 0.28, 0.58, 0.79)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
apply_custom_style()

local cmd = ""

function playersToStreamZone()
	local peds = getAllChars()
	local streaming_player = {}
	local _, pid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	for key, v in pairs(peds) do
		local result, id = sampGetPlayerIdByCharHandle(v)
		if result and id ~= pid and id ~= tonumber(control_recon_playerid) then
			streaming_player[key] = id
		end
	end
	return streaming_player
end

local arr_plaers = {u8""}
local combo_players = imgui.ImInt(0)   
 
function imgui.OnDrawFrame()
   if window_mess.v then
	local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.LockPlayer = false
		imgui.ShowCursor = true
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 1))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2.5, sh/2.5), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Быстрые сообщения /mess", window_mess)
		
	
		if imgui.CollapsingHeader(u8"Сторонние Программы") then
		imgui.Text(u8'================= Информация =================')
		imgui.Text(u8'На сервере запрещены Сторонние Программы.')
		imgui.Text(u8'Которые дают преимущества над игроками.')
		imgui.Text(u8'Если вы заметите игрока со Сторонними Программами.')
		imgui.Text(u8'Пишите администраторам:"/report id причина"')
		imgui.Text(u8'================= Информация =================')
		if imgui.Button(u8"Отправить", btn_size) then
		sampSendChat("/mess 12 ================= Информация =================")
		sampSendChat("/mess 6 На сервере запрещены Сторонние Программы.")
		sampSendChat("/mess 6 Которые дают преимущества над игроками.")
		sampSendChat("/mess 6 Если вы заметите игрока со Сторонними Программами.")
		sampSendChat("/mess 6 Пишите администраторам:'/report id причина' ")
		sampSendChat("/mess 12 ================= Информация =================")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
        
			if imgui.CollapsingHeader(u8"Спавн Транспорта") then
		imgui.Text(u8'====================== Респавн Авто ========================')
		imgui.Text(u8'Уважаемые игроки, через 15 секунд будет произведен.')
		imgui.Text(u8'Респавн Транспортного средства, чтобы не потерять его.')
		imgui.Text(u8'Займите Водительское/Пассажирское место')
		imgui.Text(u8'Приятной игры на Russian Drift Server.')
		imgui.Text(u8'================= Респавн Авто ===============')
		if imgui.Button(u8"Отправить", btn_size) then
		sampSendChat("/mess 12 ====================== Респавн Авто ========================")
		sampSendChat("/mess 6 Уважаемые игроки, через 15 секунд будет произведен.")
		sampSendChat("/mess 6 Респавн Транспортного средства, чтобы не потерять его.")
		sampSendChat("/mess 6 Займите Водительское/Пассажирское место")
		sampSendChat("/spawncars 15")
		sampSendChat("/delcarall")
		sampSendChat("/mess 12 ====================== Респавн Авто ========================")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
		
		if imgui.CollapsingHeader(u8"Жалоба на Администрацию") then
		imgui.Text(u8'================== Информация ==================')
		imgui.Text(u8'Не согласны с наказание какого-то администратора ?')
		imgui.Text(u8'Вы можете подать жалобу на него, либо разблокировку.')
		imgui.Text(u8'Просто перейдите в нужное обсуждение по ссылке ниже.')
		imgui.Text(u8'Группа: "https://vk.com/dmdriftgta".')
		imgui.Text(u8'============== Неверное наказание ===============')
		if imgui.Button(u8"Отправить", btn_size) then
		sampSendChat("/mess 12 ================== Информация ==================")
		sampSendChat("/mess 6 Не согласны с наказание какого-то администратора?")
		sampSendChat("/mess 6 Вы можете подать жалобу на него, либо разблокировку.")
		sampSendChat("/mess 6 Просто перейдите в нужное обсуждение по ссылке ниже.")
		sampSendChat("/mess 6 Группа: https://vk.com/dmdriftgta")
		sampSendChat("/mess 12 ============== Неверное наказание ===============")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
		
		if imgui.CollapsingHeader(u8"Центральный Рынок") then
		imgui.Text(u8'===================== Информация =====================')
		imgui.Text(u8'Желаете приобрести аксессуар за Вирты/Очки/Коины/Рубли?')
		imgui.Text(u8'Добро пожаловать на рынок, по команде: "/trade"')
		imgui.Text(u8'Так же, подойдя к NPC, можно обменять валюты. ')
		imgui.Text(u8'Но учтите... Не нужно вредить игрокам.')
		imgui.Text(u8'================= Рынок/Обмен валют ==================')
		if imgui.Button(u8"Отправить", btn_size) then
		sampSendChat("/mess 12 ===================== Информация =====================")
		sampSendChat("/mess 6 Желаете приобрести аксессуар за Вирты/Очки/Коины/Рубли?")
		sampSendChat("/mess 6 Добро пожаловать на рынок, по команде: /trade")
		sampSendChat("/mess 6 Так же, подойдя к NPC, можно обменять валюты.")
		sampSendChat("/mess 6 Но учтите... Не нужно вредить игрокам.")
		sampSendChat("/mess 12 ================= Рынок/Обмен валют ==================")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
		
		 local x, y, z = getCharCoordinates(playerPed)
         local str_cords = string.format("%.2f, %.2f, %.2f", x, y, z)
		if imgui.CollapsingHeader(u8"Мероприятия") then
		imgui.Text(u8'Позиция игрока: '..str_cords)
		imgui.Text(u8'Выберите мероприятие: ')
		imgui.SameLine()
		imgui.PushItemWidth(190)
		imgui.Combo(u8'', mp_combo, arr_mp, #arr_mp)
		
		imgui.Text(u8"Выберите тип приза и введите его количество: ")
		if imgui.Combo(u8"##Prise", mp_prise, arr_prise, #arr_prise) then
		if mp_prise.v == 0 then
		cmd = "/agivemoney"
		prise = "Вирт"
		end
		if mp_prise.v == 1 then
		cmd = "/givescore"
		prise = "Score"
		end
		if mp_prise.v == 2 then
		cmd = "/givecoin"
		prise = "RDS Coins"
		end
		if mp_prise.v == 3 then
		cmd = "/giverub"
		prise = "Donate Rub"
		end
		if mp_prise.v == 4 then
		cmd = "/mpwin"
		prise_kol.v = ""
		prise = "Стандартный"
		end
		end
		imgui.SameLine()
		imgui.InputText("##PriseKol", prise_kol)
		
		if imgui.Button(u8"Начать МП") then
		lua_thread.create(function()
		sampSendChat("/mess 13 ===================== МероПриятие =====================")
		sampSendChat("/mess 14 Проходит МероПриятие ".. u8:decode(arr_mp[mp_combo.v + 1]))
		sampSendChat("/mess 14 Телепорт будет открыт ровно 60 секунд")
		sampSendChat("/mess 14 Приз для победителя: "..prise_kol.v.." "..prise)
		sampSendChat("/mp")
        sampSendDialogResponse(5343, 1, 0)
		wait(900)
		sampSendDialogResponse(5344, 1, _, u8:decode(arr_mp[mp_combo.v + 1]))
		wait(900)
		sampSendDialogResponse(1)
		sampSendChat('/mess 14 Чтобы попасть на МероПриятие следует прописать "/tpmp"')
		sampSendChat("/mess 13 ===================== МероПриятие =====================")
		
		local v = 60
		for i=1, 60 do
		v = v - 1
		printString('~g~ '..v, 1000)
		wait(1000)
		end
		sampSendChat('/mess 14 Время на телепорт вышло.')
		wait(1000)
		sampSendChat('/mess 14 Закрываю телепорт')
		wait(500)
		sampSendChat("/mp")
		wait(700)
		sampSendDialogResponse(5343, 1, 0)
		window_mess.v = false
		end)
		end
		imgui.SameLine()
		if imgui.Button(u8"Закончить МП и выдать приз") then
		lua_thread.create(function()
		sampSendChat("/mess 13 ===================== МероПриятие =====================")
		wait(50)
		sampSendChat("/mess 14 Победитель мероприятия ".. u8:decode(arr_mp[mp_combo.v + 1]))
		wait(50)
	    sampSendChat("/mess 14 Становится игрок: " .. sampGetPlayerNickname(mp_win.v))
		wait(50)
	    sampSendChat("/mess 14 Поздравляем")
		wait(50)
		sampSendChat(cmd.." "..mp_win.v.." "..prise_kol.v)
		wait(50)
		sampSendChat("/aspawn "..mp_win.v)
		wait(50)
		sampSendChat("/mess 13 ===================== МероПриятие =====================")
		sampSendChat("/tweap "..player_id)
		window_mess.v = false
		end)
		end
		
		imgui.Text("")
		imgui.Text(u8"Введите ID победителя: ")
		imgui.SameLine()
		imgui.InputText("ID", mp_win)
	
		--if imgui.Combo("Игроки", combo_players, arr_plaers, #arr_plaers) then
		--local playerid_to_stream = playersToStreamZone()     
		--for _, v in pairs(playerid_to_stream) do
		--imgui.Text(u8"Players: \n"..v)
		--end
		--end
		
		end
		imgui.End()
	end
end


function sampev.onShowDialog(id, style, title, button1, button2, text)

end
function main()
	 if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

	_, player_id = sampGetPlayerIdByCharHandle(playerPed)
	player_nick = sampGetPlayerNickname(player_id)
	
	
	 sampRegisterChatCommand('event', function() 
	 window_mess.v = not window_mess.v
	 end)
     imgui.Process = false

	if bNotf then
	imgui.ShowCursor = false
    notf.addNotification(("Идет проверка сервера."), 5, 2)
	wait(1000)
	  if not checkServer(select(1, sampGetCurrentServerAddress())) then
		 notf.addNotification(("Скрипт работает только на серверах RDS!"), 5, 3)
		wait(1000)
		thisScript():unload()
	end
	 wait(1000)
    notf.addNotification(("Проверка прошла успешно! Скрипт загружен."), 5, 2)
	wait(500)
	end
	
	
	
	if not doesDirectoryExist(getWorkingDirectory() .. "/config/Event") then
	    notf.addNotification(("Создаю папку Event"), 5, 3)
		createDirectory(getWorkingDirectory() .. "/config/Event")
		wait(300)
		 notf.addNotification(("Папка Event создана."), 5, 2)
		else
		  notf.addNotification(("Папка Event найдена."), 5, 2)
		 
		  
	end
	
	if bNotf then
	wait(900)
	notf.addNotification(("Идет проверка обновления."), 5, 2)
	downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
			notf.addNotification(("Обновлений не найдено."), 5, 3)
            if tonumber(updateIni.info.vers) > script_vers then
               notf.addNotification(("Найдено новое обновление! Обновляюсь. Версия: "..updateIni.info.vers_text), 5, 3)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
	end
	
	
	--[[пытаюсь хукнуть эту строку из чата:
Alan_Butler[666] - [60 lvl] -{FFFFFF} [AFK: 0]{FFFFFF} - Репутация: 1111

вот таким кодом:
(%s+)%[(%d+)%] - %[(%d+) lvl%] (.+) - Репутация: (%d+)]]


	lua_thread.create(function()
	while true do
		wait(0)
	
	
	  if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage(tag.. "Скрипт успешно обновлен!")
                    thisScript():reload()
                end
            end)
            break
        end


   imgui.Process = window_mess.v
	
	
	end
	end)
end
