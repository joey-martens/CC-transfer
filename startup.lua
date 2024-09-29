-- Define the directory name for downloads
local downloadDir = "MESYS"

-- Create the download directory if it doesn't exist in the root directory
local fullPath = shell.resolve(downloadDir)
if not fs.exists(fullPath) then
  fs.makeDir(fullPath)
end

-- Define a table of files to download with their names and URLs
local filesToDownload = {
  {name = "create_route.lua", url = "https://raw.githubusercontent.com/haveguninmypants/CC-ME/main/create_route.lua"},
  {name = "edit_delete_route.lua", url = "https://raw.githubusercontent.com/haveguninmypants/CC-ME/main/edit_delete_route.lua"},
  {name = "execute_routes.lua", url = "https://raw.githubusercontent.com/haveguninmypants/CC-ME/main/execute_routes.lua"},
  {name = "menu.lua", url = "https://raw.githubusercontent.com/haveguninmypants/CC-ME/main/menu.lua"},
}

-- Function to download a file using wget
function downloadFile(fileName, fileURL)
  local fullFilePath = fs.combine(fullPath, fileName)
  shell.run("wget", fileURL, fullFilePath)
end

-- Main program
for _, fileInfo in ipairs(filesToDownload) do
  local fileName = fileInfo.name
  local fileURL = fileInfo.url

  print("Downloading " .. fileName)
  downloadFile(fileName, fileURL)
  print("Downloaded " .. fileName)
end

-- Execute the menu.lua script from the MESYS directory
local menuScriptPath = fs.combine(fullPath, "menu.lua")
if fs.exists(menuScriptPath) then
  print("Executing menu.lua script...")
  shell.run(menuScriptPath)
else
  print("Error: menu.lua script not found.")
end
