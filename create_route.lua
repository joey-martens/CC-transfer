
-- Function to create a route and save it to a file
function createRoute(source, destination, item, amount)
  local routingTable = {}

  -- Check if the routing table file already exists
  if fs.exists("/routing_table") then
    local file = fs.open("/routing_table", "r")
    local contents = file.readAll()
    routingTable = textutils.unserialize(contents)
    file.close()
  end

  table.insert(routingTable, {
    source = source,
    destination = destination,
    item = item,
    amount = amount
  })

  -- Save the updated routing table to a file
  local file = fs.open("/routing_table", "w")
  file.write(textutils.serialize(routingTable))
  file.close()
end

-- Function to select a source and destination inventory
-- Function to select a source and destination inventory
function selectInventory2()
  term.clear()
  term.setCursorPos(1, 1)
  local peripherals = peripheral.getNames()

  -- Remove duplicates using a set data structure
  local uniquePeripherals = {}
  for _, peripheralName in ipairs(peripherals) do
    uniquePeripherals[peripheralName] = true
  end

  peripherals = {}
  for peripheralName, _ in pairs(uniquePeripherals) do
    table.insert(peripherals, peripheralName)
  end

  table.sort(peripherals)  -- Sort the unique peripherals alphabetically
  local currentPage = 1
  local pageSize = 7
  local totalPages = math.ceil(#peripherals / pageSize)

  while true do
    term.clear()
    term.setCursorPos(1, 1)
    print("Select Source Inventory (Page " .. currentPage .. " of " .. totalPages .. "):")

    local startIndex = (currentPage - 1) * pageSize + 1
    local endIndex = math.min(currentPage * pageSize, #peripherals)

    for i = startIndex, endIndex do
      local option = peripherals[i]
      print(i .. ". " .. option)
    end

    print("Enter the number of your choice (N for Next, P for Previous):")
    local choice = read()

    if tonumber(choice) then
      local numericChoice = tonumber(choice)
      if numericChoice >= 1 and numericChoice <= #peripherals then
        return peripherals[numericChoice]
      end
    elseif choice:lower() == "n" and currentPage < totalPages then
      currentPage = currentPage + 1
    elseif choice:lower() == "p" and currentPage > 1 then
      currentPage = currentPage - 1
    end
  end
end

function selectInventory()
  term.clear()
  term.setCursorPos(1, 1)
  local peripherals = peripheral.getNames()

  -- Remove duplicates using a set data structure
  local uniquePeripherals = {}
  for _, peripheralName in ipairs(peripherals) do
    uniquePeripherals[peripheralName] = true
  end

  peripherals = {}
  for peripheralName, _ in pairs(uniquePeripherals) do
    table.insert(peripherals, peripheralName)
  end

  table.sort(peripherals)  -- Sort the unique peripherals alphabetically
  local currentPage = 1
  local pageSize = 7
  local totalPages = math.ceil(#peripherals / pageSize)

  while true do
    term.clear()
    term.setCursorPos(1, 1)
    print("Select Destination Inventory (Page " .. currentPage .. " of " .. totalPages .. "):")

    local startIndex = (currentPage - 1) * pageSize + 1
    local endIndex = math.min(currentPage * pageSize, #peripherals)

    for i = startIndex, endIndex do
      local option = peripherals[i]
      print(i .. ". " .. option)
    end

    print("Enter the number of your choice (N for Next, P for Previous):")
    local choice = read()

    if tonumber(choice) then
      local numericChoice = tonumber(choice)
      if numericChoice >= 1 and numericChoice <= #peripherals then
        return peripherals[numericChoice]
      end
    elseif choice:lower() == "n" and currentPage < totalPages then
      currentPage = currentPage + 1
    elseif choice:lower() == "p" and currentPage > 1 then
      currentPage = currentPage - 1
    end
  end
end


-- Main program
local source, destination

-- Select source and destination inventories
source = selectInventory2()
destination = selectInventory()

term.clear()
term.setCursorPos(1, 1)
print("Enter the item you want to transfer:")
local item = read()
print("Enter the amount you want to transfer:")
local amount = tonumber(read())

createRoute(source, destination, item, amount)
