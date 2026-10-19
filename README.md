# MSUHub-UI

Glassmorphic UI Library and Script Template for Roblox (based on MacLib) styled with **MSU HUB** iOS Glassmorphism theme.

## 🚀 Quick Start (Loadstring)

### 1. รันตัวอย่าง MSU HUB (Full UI Template)
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dommeeeee/MSUHub-UI/main/MSUHub.lua"))()
```

### 2. นำ MacLib (MSU Hub Edition) ไปใช้สร้างสคริปต์ของคุณเอง
```lua
local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dommeeeee/MSUHub-UI/main/Maclib.lua"))()

local Window = MacLib:Window({
    Title = "MSU HUB",
    Subtitle = "v1.0",
    Size = UDim2.fromOffset(868, 650),
    DragStyle = 1,
    AcrylicBlur = true,
})
```

## 📂 โครงสร้างไฟล์
- `Maclib.lua` — ซอร์สโค้ดตัวไลบรารี MacLib ดัดแปลงธีม MSU Hub
- `MSUHub.lua` — สคริปต์หน้าต่าง Hub เต็มรูปแบบพร้อม Tab, Section, Slider, Toggle, Dropdown, Colorpicker, Keybind, ฯลฯ
