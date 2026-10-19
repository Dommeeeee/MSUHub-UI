--// โหลดไลบรารี MacLib MSU Hub จาก GitHub ของคุณ
local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dommeeeee/MSUHub-UI/main/Maclib.lua"))()

--// ฟังก์ชันแปลงโฉม MacLib ให้เป็นธีม MSU HUB (iPhone / iOS Glassmorphic) อัตโนมัติ
local function ApplyMSUHubTheme(logoAssetId)
	local TweenService = game:GetService("TweenService")
	local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
	local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

	local Theme = {
		BaseBg = Color3.fromRGB(10, 15, 28),          -- พื้นหลังกระจกสีกรมท่าเข้มสไตล์ iOS
		CardBg = Color3.fromRGB(18, 27, 48),          -- พื้นหลังการ์ด Section
		ControlBg = Color3.fromRGB(22, 34, 60),       -- พื้นหลังปุ่ม / Dropdown / Input
		Cyan = Color3.fromRGB(0, 195, 255),           -- สีฟ้าเนออน MSU Hub
		ElectricBlue = Color3.fromRGB(0, 115, 255),   -- สีน้ำเงินเข้มไซเบอร์
		StrokeCyan = Color3.fromRGB(60, 195, 255),    -- สีขอบเรืองแสง
	}

	task.spawn(function()
		task.wait(0.1)
		local targetGui
		for _, gui in ipairs(( PlayerGui and PlayerGui:GetChildren() ) or {}) do
			if gui:IsA("ScreenGui") and gui:FindFirstChild("Base") then targetGui = gui break end
		end
		if not targetGui then
			for _, gui in ipairs(CoreGui:GetChildren()) do
				if gui:IsA("ScreenGui") and gui:FindFirstChild("Base") then targetGui = gui break end
			end
		end
		if not targetGui then return end

		local base = targetGui:WaitForChild("Base")
		base.BackgroundColor3 = Theme.BaseBg
		base.BackgroundTransparency = 0.08

		-- ความโค้งมนสไตล์ iPhone + ขอบไล่เฉดสีฟ้าไซเบอร์
		local baseCorner = base:FindFirstChildOfClass("UICorner")
		if baseCorner then baseCorner.CornerRadius = UDim.new(0, 16) end

		local baseStroke = base:FindFirstChildOfClass("UIStroke")
		if baseStroke then
			baseStroke.Color = Theme.StrokeCyan
			baseStroke.Thickness = 1.5
			baseStroke.Transparency = 0.3
			local grad = Instance.new("UIGradient")
			grad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 225, 255)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 100, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 215, 255))
			})
			grad.Rotation = 45
			grad.Parent = baseStroke
		end

		-- เพิ่มโลโก้ MSU HUB ด้านซ้ายบนของ Sidebar
		local sidebar = base:FindFirstChild("Sidebar")
		if sidebar and sidebar:FindFirstChild("Information") then
			local infoHolder = sidebar.Information:FindFirstChild("InformationHolder")
			if infoHolder and not infoHolder:FindFirstChild("MSULogo") then
				local logo = Instance.new("ImageLabel")
				logo.Name = "MSULogo"
				logo.AnchorPoint = Vector2.new(0, 0.5)
				logo.Position = UDim2.fromScale(0, 0.5)
				logo.Size = UDim2.fromOffset(38, 38)
				logo.BackgroundColor3 = Color3.fromRGB(14, 24, 45)
				logo.BackgroundTransparency = 0.2
				logo.Image = logoAssetId or "rbxassetid://18821914323"
				logo.Parent = infoHolder

				local lc = Instance.new("UICorner", logo)
				lc.CornerRadius = UDim.new(0, 10)

				local ls = Instance.new("UIStroke", logo)
				ls.Color = Theme.Cyan
				ls.Thickness = 1.2
				ls.Transparency = 0.35

				local titleFrame = infoHolder:FindFirstChild("TitleFrame")
				if titleFrame then
					titleFrame.Position = UDim2.fromOffset(48, 0)
					titleFrame.Size = UDim2.new(1, -68, 1, 0)
					local titleLabel = titleFrame:FindFirstChild("Title")
					if titleLabel then
						local tg = Instance.new("UIGradient", titleLabel)
						tg.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 210, 255))
						})
					end
				end
			end

			-- การ์ดโปรไฟล์ผู้เล่นมุมซ้ายล่าง
			local sidebarGroup = sidebar:FindFirstChild("SidebarGroup")
			if sidebarGroup and sidebarGroup:FindFirstChild("UserInfo") then
				local infoGroup = sidebarGroup.UserInfo:FindFirstChild("InformationGroup")
				if infoGroup then
					infoGroup.BackgroundColor3 = Theme.CardBg
					infoGroup.BackgroundTransparency = 0.45
					infoGroup.Size = UDim2.new(1, 0, 0, 64)
					infoGroup.AnchorPoint = Vector2.new(0, 0.5)
					infoGroup.Position = UDim2.fromScale(0, 0.5)
					local uc = Instance.new("UICorner", infoGroup)
					uc.CornerRadius = UDim.new(0, 12)
					local us = Instance.new("UIStroke", infoGroup)
					us.Color = Theme.StrokeCyan
					us.Transparency = 0.65
				end
			end
		end

		-- ปรับแต่ง Section, Toggle, Slider, Dropdown ให้เป็นโทน iPhone iOS Cyan
		for _, obj in ipairs(base:GetDescendants()) do
			if obj:IsA("Frame") and obj.Name == "Section" and obj.Parent.Name ~= "TabSwitchersScrollingFrame" then
				obj.BackgroundColor3 = Theme.CardBg
				obj.BackgroundTransparency = 0.45
				local sc = obj:FindFirstChildOfClass("UICorner")
				if sc then sc.CornerRadius = UDim.new(0, 12) end
				local ss = obj:FindFirstChildOfClass("UIStroke")
				if ss then
					ss.Color = Theme.StrokeCyan
					ss.Transparency = 0.72
				end
			elseif obj:IsA("TextButton") and obj.Name == "TabSwitcher" then
				obj.BackgroundColor3 = Theme.Cyan
				local tc = obj:FindFirstChildOfClass("UICorner")
				if tc then tc.CornerRadius = UDim.new(0, 10) end
				local ts = obj:FindFirstChildOfClass("UIStroke")
				if ts then ts.Color = Color3.fromRGB(130, 230, 255) end
				local tg = Instance.new("UIGradient", obj)
				tg.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Theme.ElectricBlue),
					ColorSequenceKeypoint.new(1, Theme.Cyan)
				})
			elseif obj:IsA("ImageButton") and obj.Name == "Toggle" then
				local head = obj:FindFirstChild("TogglerHead")
				local function updateToggleColor()
					local isOn = head and head.Position.X.Scale > 0.7
					TweenService:Create(obj, TweenInfo.new(0.15), {
						ImageColor3 = isOn and Theme.Cyan or Color3.fromRGB(45, 60, 90),
						ImageTransparency = isOn and 0 or 0.3
					}):Play()
				end
				updateToggleColor()
				if head then
					head:GetPropertyChangedSignal("Position"):Connect(updateToggleColor)
				end
			elseif obj:IsA("ImageLabel") and obj.Name == "SliderBar" then
				obj.ImageColor3 = Color3.fromRGB(45, 62, 95)
				local head = obj:FindFirstChild("SliderHead")
				if head then
					head.ImageColor3 = Color3.fromRGB(150, 235, 255)
					local fill = Instance.new("Frame")
					fill.Name = "SliderFill"
					fill.AnchorPoint = Vector2.new(0, 0.5)
					fill.Position = UDim2.fromScale(0, 0.5)
					fill.Size = UDim2.fromScale(head.Position.X.Scale, 1)
					fill.BackgroundColor3 = Theme.Cyan
					fill.BorderSizePixel = 0
					fill.Parent = obj
					Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
					head:GetPropertyChangedSignal("Position"):Connect(function()
						fill.Size = UDim2.fromScale(head.Position.X.Scale, 1)
					end)
				end
			end
		end
	end)
end

--// 1. สร้างหน้าต่างหลัก MSU HUB
local LOGO_ASSET_ID = "rbxassetid://18821914323" -- << นำเลข Asset ID รูปโลโก้ MSU Hub ของคุณมาใส่ตรงนี้

local Window = MacLib:Window({
	Title = "MSU HUB",
	Subtitle = "PREMIUM v1.0",
	Logo = LOGO_ASSET_ID,
	Size = UDim2.fromOffset(868, 650),
	DragStyle = 1,
	DisabledWindowControls = {},
	ShowUserInfo = true,
	Keybind = Enum.KeyCode.RightControl,
	AcrylicBlur = true,
})

--// 2. ตั้งค่า Global Settings (มุมขวาบนของแถบชื่อ)
Window:GlobalSetting({
	Name = "UI Blur (iOS Acrylic)",
	Default = Window:GetAcrylicBlurState(),
	Callback = function(bool)
		Window:SetAcrylicBlurState(bool)
		Window:Notify({
			Title = "MSU HUB",
			Description = (bool and "เปิดใช้งาน" or "ปิดใช้งาน") .. " เอฟเฟกต์กระจกเบลอ (UI Blur)",
			Lifetime = 4
		})
	end,
})

Window:GlobalSetting({
	Name = "Notifications",
	Default = Window:GetNotificationsState(),
	Callback = function(bool)
		Window:SetNotificationsState(bool)
	end,
})

Window:GlobalSetting({
	Name = "Show User Info",
	Default = Window:GetUserInfoState(),
	Callback = function(bool)
		Window:SetUserInfoState(bool)
	end,
})

--// 3. สร้างหมวดหมู่แท็บ (Sidebar Tabs) ตามภาพต้นแบบ
local TabGroup = Window:TabGroup()

local Tabs = {
	Demo = TabGroup:Tab({ Name = "Demo", Image = "rbxassetid://18821914323" }),
	Visuals = TabGroup:Tab({ Name = "Visuals", Image = "rbxassetid://10723346959" }),
	Combat = TabGroup:Tab({ Name = "Combat", Image = "rbxassetid://10734975486" }),
	Teleports = TabGroup:Tab({ Name = "Teleports", Image = "rbxassetid://10734886004" }),
	Misc = TabGroup:Tab({ Name = "Misc", Image = "rbxassetid://10723407389" }),
	Settings = TabGroup:Tab({ Name = "Settings", Image = "rbxassetid://10734950309" })
}

--// 4. สร้าง Section และใส่องค์ประกอบ UI ครบทุกชนิด (เหมือนในภาพตัวอย่าง)
local LeftSection = Tabs.Demo:Section({ Side = "Left" })
local RightSection = Tabs.Demo:Section({ Side = "Right" })

LeftSection:Header({ Name = "Header #1" })

LeftSection:Button({
	Name = "Button",
	Callback = function()
		Window:Dialog({
			Title = "MSU HUB • Confirmation",
			Description = "คุณต้องการรันฟังก์ชันพิเศษของ MSU HUB ใช่หรือไม่?",
			Buttons = {
				{
					Name = "Confirm",
					Callback = function()
						Window:Notify({
							Title = "MSU HUB",
							Description = "รันคำสั่งสำเร็จเรียบร้อยแล้ว!",
							Lifetime = 3
						})
					end,
				},
				{
					Name = "Cancel"
				}
			}
		})
	end,
})

LeftSection:Slider({
	Name = "Slider",
	Default = 50,
	Minimum = 0,
	Maximum = 100,
	DisplayMethod = "Percent",
	Precision = 0,
	Callback = function(Value)
		print("Slider Value:", Value)
	end
}, "MSU_Slider")

LeftSection:Toggle({
	Name = "Toggle",
	Default = true,
	Callback = function(value)
		Window:Notify({
			Title = "MSU HUB",
			Description = (value and "เปิดใช้งาน " or "ปิดใช้งาน ") .. "Toggle เรียบร้อยแล้ว"
		})
	end,
}, "MSU_Toggle1")

local fruitOptions = { "Apple", "Orange", "Banana", "Grapes", "Pineapple", "Mango" }

LeftSection:Dropdown({
	Name = "Dropdown",
	Search = true,
	Multi = true,
	Required = false,
	Options = fruitOptions,
	Default = { "Apple", "Orange" },
	Callback = function(Value)
		local selected = {}
		for item, state in next, Value do
			if state then table.insert(selected, item) end
		end
		print("Selected:", table.concat(selected, ", "))
	end,
}, "MSU_Dropdown")

LeftSection:Divider()

LeftSection:Header({ Text = "Header #2" })

LeftSection:Paragraph({
	Header = "Paragraph",
	Body = "MSU HUB UI ออกแบบในสไตล์กระจกฝ้า iOS (Glassmorphism) โทนสีฟ้าเนออนไซเบอร์ เข้ากับโลโก้ของคุณอย่างลงตัว"
})

--// ฝั่งขวา (Right Section)
RightSection:Header({ Name = "Controls & Customization" })

RightSection:Input({
	Name = "Input",
	Placeholder = "Config Name...",
	AcceptedCharacters = "All",
	Callback = function(input)
		Window:Notify({
			Title = "MSU HUB",
			Description = "ตั้งค่าข้อความเป็น: " .. input
		})
	end,
}, "MSU_Input")

RightSection:Toggle({
	Name = "Auto Farm (MSU Mode)",
	Default = false,
	Callback = function(value)
		print("Auto Farm:", value)
	end,
}, "MSU_Toggle2")

RightSection:Keybind({
	Name = "Keybind",
	Default = Enum.KeyCode.F,
	Callback = function(binded)
		Window:Notify({
			Title = "MSU HUB",
			Description = "กดปุ่มลัด: " .. tostring(binded.Name),
			Lifetime = 2
		})
	end,
}, "MSU_Keybind")

RightSection:Colorpicker({
	Name = "Colorpicker",
	Default = Color3.fromRGB(0, 195, 255),
	Alpha = 0,
	Callback = function(color, alpha)
		print("Selected Color:", color, "Alpha:", alpha)
	end,
}, "MSU_Colorpicker")

--// 5. ระบบบันทึกการตั้งค่า (Config System) ในแท็บ Settings
MacLib:SetFolder("MSUHub")
Tabs.Settings:InsertConfigSection("Left")

Tabs.Demo:Select()
MacLib:LoadAutoLoadConfig()

-- เรียกใช้ฟังก์ชันปรับแต่งธีม MSU HUB iOS Glassmorphic
ApplyMSUHubTheme(LOGO_ASSET_ID)
