
-- ����������
require "lib.moonloader"
local tag = "{741DCE}RDS Events: {FFFFFF}"
local ev = require 'samp.events'
local sampev = require 'lib.samp.events'
local time = 11000
local real_time = os.date("%c")

local encoding							= require "encoding"
encoding.default 						= "CP1251"
u8 										= encoding.UTF8

local inicfg = require "inicfg"
local dlstatus = require('moonloader').download_status
local memory = require "memory"
local imgui = require("imgui")
local script_author = "Vrednaya."
local vkeys	= require "lib.vkeys"
local window_mess = imgui.ImBool(false)
local sw, sh = getScreenResolution()
local mp_combo = imgui.ImInt(0)
local arr_mp = {u8"������ �� �������", u8"������� �������", u8"������ �����", u8"Fall Guys", u8"UFC"}
local arr_prise = {u8"�����", u8"����", u8"�����", u8"�����", u8"��������"}
local mp_prise = imgui.ImInt(0)
local prise_kol = imgui.ImBuffer(200)
local mp_win = imgui.ImBuffer(200)

tServers = {
	'46.174.52.246', -- 01
        '46.174.55.87', -- 02
        '46.174.49.170', -- 03
        '46.174.55.169', -- 04
		"46.174.49.47" -- ����������
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

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/Vrednaya1234/Admin-Events/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://github.com/thechampguess/scripts/blob/master/autoupdate_lesson_16.luac?raw=true" -- ��� ���� ������
local script_path = thisScript().path

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

			colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 0.85);
	colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
	colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
	colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
	colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
	colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
	colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
	colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
	colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
	colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
	colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
	colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
	colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
	colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
	colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
	colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
	colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
	colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
	colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
	colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
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
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 1))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2.5, sh/2.5), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"������� ��������� /mess", window_mess)
		
	
		if imgui.CollapsingHeader(u8"��������� ���������") then
		imgui.Text(u8'================= ���������� =================')
		imgui.Text(u8'�� ������� ��������� ��������� ���������.')
		imgui.Text(u8'������� ���� ������������ ��� ��������.')
		imgui.Text(u8'���� �� �������� ������ �� ���������� �����������.')
		imgui.Text(u8'������ ���������������:"/report id �������"')
		imgui.Text(u8'================= ���������� =================')
		if imgui.Button(u8"���������", btn_size) then
		sampSendChat("/mess 12 ================= ���������� =================")
		sampSendChat("/mess 6 �� ������� ��������� ��������� ���������.")
		sampSendChat("/mess 6 ������� ���� ������������ ��� ��������.")
		sampSendChat("/mess 6 ���� �� �������� ������ �� ���������� �����������.")
		sampSendChat("/mess 6 ������ ���������������:'/report id �������' ")
		sampSendChat("/mess 12 ================= ���������� =================")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
        
			if imgui.CollapsingHeader(u8"����� ����������") then
		imgui.Text(u8'====================== ������� ���� ========================')
		imgui.Text(u8'��������� ������, ����� 15 ������ ����� ����������.')
		imgui.Text(u8'������� ������������� ��������, ����� �� �������� ���.')
		imgui.Text(u8'������� ������������/������������ �����')
		imgui.Text(u8'�������� ���� �� Russian Drift Server.')
		imgui.Text(u8'================= ������� ���� ===============')
		if imgui.Button(u8"���������", btn_size) then
		sampSendChat("/mess 12 ====================== ������� ���� ========================")
		sampSendChat("/mess 6 ��������� ������, ����� 15 ������ ����� ����������.")
		sampSendChat("/mess 6 ������� ������������� ��������, ����� �� �������� ���.")
		sampSendChat("/mess 6 ������� ������������/������������ �����")
		sampSendChat("/spawncars 15")
		sampSendChat("/delcarall")
		sampSendChat("/mess 12 ====================== ������� ���� ========================")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
		
		if imgui.CollapsingHeader(u8"������ �� �������������") then
		imgui.Text(u8'================== ���������� ==================')
		imgui.Text(u8'�� �������� � ��������� ������-�� �������������� ?')
		imgui.Text(u8'�� ������ ������ ������ �� ����, ���� �������������.')
		imgui.Text(u8'������ ��������� � ������ ���������� �� ������ ����.')
		imgui.Text(u8'������: "https://vk.com/dmdriftgta".')
		imgui.Text(u8'============== �������� ��������� ===============')
		if imgui.Button(u8"���������", btn_size) then
		sampSendChat("/mess 12 ================== ���������� ==================")
		sampSendChat("/mess 6 �� �������� � ��������� ������-�� ��������������?")
		sampSendChat("/mess 6 �� ������ ������ ������ �� ����, ���� �������������.")
		sampSendChat("/mess 6 ������ ��������� � ������ ���������� �� ������ ����.")
		sampSendChat("/mess 6 ������: https://vk.com/dmdriftgta")
		sampSendChat("/mess 12 ============== �������� ��������� ===============")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
		
		if imgui.CollapsingHeader(u8"����������� �����") then
		imgui.Text(u8'===================== ���������� =====================')
		imgui.Text(u8'������� ���������� ��������� �� �����/����/�����/�����?')
		imgui.Text(u8'����� ���������� �� �����, �� �������: "/trade"')
		imgui.Text(u8'��� ��, ������� � NPC, ����� �������� ������. ')
		imgui.Text(u8'�� ������... �� ����� ������� �������.')
		imgui.Text(u8'================= �����/����� ����� ==================')
		if imgui.Button(u8"���������", btn_size) then
		sampSendChat("/mess 12 ===================== ���������� =====================")
		sampSendChat("/mess 6 ������� ���������� ��������� �� �����/����/�����/�����?")
		sampSendChat("/mess 6 ����� ���������� �� �����, �� �������: /trade")
		sampSendChat("/mess 6 ��� ��, ������� � NPC, ����� �������� ������.")
		sampSendChat("/mess 6 �� ������... �� ����� ������� �������.")
		sampSendChat("/mess 12 ================= �����/����� ����� ==================")
		window_mess.v = false
		imgui.Process = false
		end
		imgui.Separator()
		end
		
		 local x, y, z = getCharCoordinates(playerPed)
         local str_cords = string.format("%.2f, %.2f, %.2f", x, y, z)
		if imgui.CollapsingHeader(u8"�����������") then
		imgui.Text(u8'������� ������: '..str_cords)
		imgui.Text(u8'�������� �����������: ')
		imgui.SameLine()
		imgui.PushItemWidth(190)
		imgui.Combo(u8'', mp_combo, arr_mp, #arr_mp)
		
		imgui.Text(u8"�������� ��� ����� � ������� ��� ����������: ")
		if imgui.Combo(u8"##Prise", mp_prise, arr_prise, #arr_prise) then
		if mp_prise.v == 0 then
		cmd = "/agivemoney"
		prise = "����"
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
		prise = "�����������"
		end
		end
		imgui.SameLine()
		imgui.InputText("##PriseKol", prise_kol)
		
		if imgui.Button(u8"������ ��") then
		lua_thread.create(function()
		sampSendChat("/mess 13 ===================== ����������� =====================")
		sampSendChat("/mess 14 �������� ����������� ".. u8:decode(arr_mp[mp_combo.v + 1]))
		sampSendChat("/mess 14 �������� ����� ������ ����� 60 ������")
		sampSendChat("/mess 14 ���� ��� ����������: "..prise_kol.v.." "..prise)
		sampSendChat("/mp")
        sampSendDialogResponse(5343, 1, 0)
		wait(900)
		sampSendDialogResponse(5344, 1, _, u8:decode(arr_mp[mp_combo.v + 1]))
		wait(900)
		sampSendChat('/mess 14 ����� ������� �� ����������� ������� ��������� "/tpmp"')
		sampSendChat("/mess 13 ===================== ����������� =====================")
		local v = 60
		for i=1, 60 do
		v = v - 1
		printString('~g~ '..v, 1000)
		wait(1000)
		end
		sampSendChat('/mess 14 ����� �� �������� �����.')
		wait(1000)
		sampSendChat('/mess 14 �������� ��������')
		wait(500)
		sampSendChat("/mp")
		wait(700)
		sampSendDialogResponse(5343, 1, 0)
		window_mess.v = false
		end)
		end
		imgui.SameLine()
		if imgui.Button(u8"��������� �� � ������ ����") then
		lua_thread.create(function()
		sampSendChat("/mess 13 ===================== ����������� =====================")
		wait(100)
		sampSendChat("/mess 14 ���������� ����������� ".. u8:decode(arr_mp[mp_combo.v + 1]))
		wait(100)
	    sampSendChat("/mess 14 ���������� �����: " .. sampGetPlayerNickname(mp_win.v))
		wait(100)
	    sampSendChat("/mess 14 �����������")
		wait(100)
		sampSendChat(cmd.." "..mp_win.v.." "..prise_kol.v)
		wait(100)
		sampSendChat("/aspawn "..mp_win.v)
		wait(100)
		sampSendChat("/mess 13 ===================== ����������� =====================")
		window_mess.v = false
		end)
		end
		
		imgui.Text("")
		imgui.Text(u8"������� ID ����������: ")
		imgui.SameLine()
		imgui.InputText("ID", mp_win)
	
		--if imgui.Combo("������", combo_players, arr_plaers, #arr_plaers) then
		--local playerid_to_stream = playersToStreamZone()     
		--for _, v in pairs(playerid_to_stream) do
		--imgui.Text(u8"Players: \n"..v)
		--end
		--end
		
		end
		imgui.End()
	end
end

function main()
	 if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	
	
	
	sampAddChatMessage(tag .. "���� �������� �� ������.")
	 wait(1000)
	  if not checkServer(select(1, sampGetCurrentServerAddress())) then
		sampAddChatMessage(tag .. "������ �������� ������ �� �������� RDS!")
		wait(4000)
		thisScript():unload()
	end
   wait(2000)
 sampAddChatMessage(tag .. "�������� ������ �������")
sampAddChatMessage(tag .. "������� ��������!")
	sampAddChatMessage(tag .. "����� �������: "..script_author.." ������: " ..script_vers_text)
	
	 downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
	
	 sampRegisterChatCommand('event', function() 
	 window_mess.v = not window_mess.v
	 end)
     imgui.Process = true

	--[[������� ������� ��� ������ �� ����:
Alan_Butler[666] - [60 lvl] -{FFFFFF} [AFK: 0]{FFFFFF} - ���������: 1111

��� ����� �����:
(%s+)%[(%d+)%] - %[(%d+) lvl%] (.+) - ���������: (%d+)
	config = inicfg.load(defTable, directIni)
	Anti_Afk.v = config.setting.Anti_Afk
	Auto_Sbor.v = config.setting.Auto_Sbor]]


	lua_thread.create(function()
	while true do
		wait(0)
	

     if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� ��������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end
		
   imgui.Process = window_mess.v
	
	
	end
	end)
end