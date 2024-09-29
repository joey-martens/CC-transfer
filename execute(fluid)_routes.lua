-- Function to read and execute registered routes
function executeRoutes()
  local routingTable = {}

  -- Read the routing table from a file
  if fs.exists("routing_table") then
    local file = fs.open("routing_table", "r")
    local contents = file.readAll()
    routingTable = textutils.unserialize(contents)
    file.close()
  end

  -- Loop through the routing table and execute routes
  for _, route in pairs(routingTable) do
    print("Transferring fluids from " .. route.source .. " to " .. route.destination)
    local p1 = peripheral.wrap(route.source)
    local p2 = peripheral.wrap(route.destination)

    transferFluids(p1, p2, route.amount)
  end
end

-- Function to transfer fluids between two tanks without feedback
function transferFluids(fromTank, toTank, amount)
  fromTank.pushFluid(peripheral.getName(toTank),amount)
end

-- Main loop
while true do
  -- Main program
  executeRoutes()
end
