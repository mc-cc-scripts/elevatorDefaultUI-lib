---@class ui
local ui = {
    colors = {
        background = colors.yellow,
        text = colors.black,
        currentFloorBg = colors.red,
        queuedFloorBg = colors.orange,
        floorBg = colors.white
    },
    
    ---@param self table
    ---@param floors table
    draw = function (self, floors)
        self.monitor = peripheral.find("monitor")
        if not self.monitor then return end
        --- helper function
        ---@param num integer
        ---@return string
        local function numToStr(num)
            local str = "" .. num
            if #str == 1 then
                str = " " .. str .. " "
            elseif #str == 2 then
                str = " " .. str
            end
            return str
        end

        local width, height = self.monitor.getSize()
        local oldterm = term.redirect(self.monitor)
        local window = window.create(term.current(), 1,1,width, height)
        term.redirect(oldterm)

        window.setBackgroundColor(self.colors.background)
        window.clear()
        window.setCursorPos(1,1)
        window.setCursorPos(1,1)
        window.setTextColor(self.colors.text)
        local currentFloor = 1
        
        for i = 1, #floors do
            if floors[i].isCurrent then
                currentFloor = floors[i].number
                break
            end
        end
        
        local floor = numToStr(currentFloor)
        local numSpaces = math.floor(width / 2)
        numSpaces = numSpaces - math.floor(#floor / 2)
        local spaces = ""
        for i = 1, numSpaces do
            spaces = spaces .. " "
        end

        window.write(spaces .. floor .. spaces)
        window.setTextColor(self.colors.text)

        self.floorButtons = {}
        local tmpY = 2
        for i = 1, #floors do
            local tmpI = i
            local tmpX = 1
            if i % 2 == 0 then
                tmpI = tmpI - 1
                tmpX = tmpX + 4
            end

            self.floorButtons[i] = {
                x = tmpX,
                y = tmpY,
                width = 3,
                number = floors[i].number
            }
            
            window.setCursorPos(tmpX, tmpY)
            if floors[i].isCurrent then
                window.setBackgroundColor(self.colors.currentFloorBg)
            elseif floors[i].isQueued then
                window.setBackgroundColor(self.colors.queuedFloorBg)
            else
                window.setBackgroundColor(self.colors.floorBg)
            end

            window.setCursorPos(tmpX,tmpY)
            window.write(numToStr(floors[i].number))
            
            if i % 2 == 0 then tmpY = tmpY + 1 end
        end
    end,
    
    ---@param self table
    ---@param side string
    ---@param x integer
    ---@param y integer
    ---@return integer | nil
    click = function (self, side, x, y)
        for i = 1, #self.floorButtons do
            if y == self.floorButtons[i].y
               and x  >= self.floorButtons[i].x
               and x <= self.floorButtons[i].x + self.floorButtons[i].width then
                return self.floorButtons[i].number
            end
        end

        return nil
    end
}

return ui