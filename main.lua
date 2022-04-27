io.stdout:setvbuf('no') -- show debug output live in SublimeText console
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local composer = require "composer"

local layout_idx = 0
local layout = nil

local window_w = 0
local window_h = 0

local isShowMenu = false
local showpos = {x=0,y=0}

local function updateLayout()
	local is_debug = true

	-- layout_idx = layout_idx + 1
	-- if layout_idx > 4 then layout_idx = 1 end

	-- local path = "examples/example" .. layout_idx .. ".lua"
	-- print("loading:", path)
	layout = composer.load("examples/example4.lua", is_debug)
	layout.getElement('text', function (e)
		e.widget.setText("Haha")
	end)

	layout.getElement('testview1', function (e)
		e.widget.addText("1 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("2 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("3 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("4 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("5 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("6 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("7 Hahafasdfasdfasdfasd  asdfasdf f")
		e.widget.addText("8 Hahafasdfasdfasdfasd  asdfasdf f")
	end)

	layout.getElement('Button_1', function (e)
		e.widget.setButtonAction(function(x, y)
			isShowMenu = false
		end
		)
	end)

	layout.getElement('Button_2', function (e)
		e.widget.setButtonAction(function(x, y)
			isShowMenu = false
		end
		)
	end)


	

	-- layout.getElement("test1", function(e)
	-- 	e.widget.setText("this text is changed using the ID")
	-- end)

	-- layout.getElement("button", function(e)
	-- 	e.widget.setTitle("these colors are changed using the ID")
	-- 	e.widget.setColors({ 0.5, 0.0, 0.0 }, { 0.0, 0.5, 0.0, 0.5 })
	-- end)
end

local function resizeLayout()
	layout.resize(window_w, window_h, function(e)
		e.widget.setFrame(e.rect.x, e.rect.y, e.rect.w, e.rect.h)
		print(e)
	end)
end

function love.load(args)
    local desktop_w, desktop_h = love.window.getDesktopDimensions()
    local flags = {
        resizable = true,
        minwidth = desktop_w * 0.4,
        minheight = desktop_h * 0.5,
    }
    love.window.setMode(desktop_w * 0.6, desktop_h * 0.7, flags)

    love.keyboard.pressed = {}
    love.keyboard.wasPressed = function(key)
        return love.keyboard.pressed[key] == true
    end

    love.keyboard.released = {}
    love.keyboard.wasReleased = function(key)
        return love.keyboard.released[key] == true
    end

    -- add custom controls to the layout engine loader
    composer.require("widgets/widgets.lua")
    updateLayout()

	window_w, window_h = love.window.getMode()
    resizeLayout()

    love.window.setTitle("Composer v" .. composer._VERSION)

--[[    print("\n\n")
    for k, v in pairs(_G.package.loaded) do
    	print(k, v)
    end
    print("\n\n")
--]]
end

function love.mousepressed(x, y, button)
	if button == 1 then
		if isShowMenu == false then
			isShowMenu = true
			showpos = {x=x, y=y}
		end
	end
end

function love.mousereleased(x, y, button)
end

function love.update(dt)
	layout:update(dt)
end

function love.draw()
	-- draw white background
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.rectangle("fill", 0, 0, window_w, window_h)

	if isShowMenu then
		love.graphics.translate(showpos.x, showpos.y)
		layout:draw(1,1,showpos.x, showpos.y)
		love.graphics.translate(-showpos.x, -showpos.y)
	end
end

function love.resize(w, h)
	window_w, window_h = w, h
    resizeLayout()
end

function love.keypressed(key, code)
	if key == "g" then
		updateLayout()
		
		window_w, window_h = love.window.getMode()
		resizeLayout()
	end
end