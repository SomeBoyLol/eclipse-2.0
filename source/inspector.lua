inspector = {}

local co = coroutine.create(function() end)

function inspector.run()
    co = coroutine.create(function()
        local logFile = io.open("log.lua", "w")
        
        for name, value in pairs(_G) do
            if not(string.find(tostring(value), "builtin")) then
                if type(value) == "table" then
                    logFile:write(table.show(value, name) .. "\n")
                else
                    logFile:write(tostring(name).." = "..tostring(value) .. "\n")
                end
            end
    
            coroutine.yield()
        end
    
        logFile:close()
    end)
end

function inspector:update(dt)
    coroutine.resume(co)
end