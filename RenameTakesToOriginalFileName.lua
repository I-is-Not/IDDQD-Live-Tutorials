-- Renames a group of selected takes to the original audio file name
local NumberOfSelectedItems = reaper.CountSelectedMediaItems(0) -- counts the number of selected items in the current project
if NumberOfSelectedItems == 0 then
  reaper.ShowConsoleMsg("There are no selected items in the current project!\n\nIn order to rename items, select one or more items first!")
--reaper.ShowConsoleMsg("There are "..NumberOfSelectedItems.." selected items in the current project") -- prints a message
--reaper.MB(NumberOfSelectedItems,"Number of Selected Items in Current Project",0) -- prints a message, then waits for a button to be clicked
else
  for SelectedItemIndex = 0 , NumberOfSelectedItems-1 do  -- creates a loop to rename each selected item, one at a time
    local SelectedMediaItem = reaper.GetSelectedMediaItem(0,SelectedItemIndex) --assigns the nth selected media item to the new local variable SelectedMediaItem
    local ActiveTakeInItem = reaper.GetActiveTake(SelectedMediaItem) --assigns the active take of SelectedMediaItem to the new local variable ActiveTakeInItem
    local PCMSource = reaper.GetMediaItemTake_Source(ActiveTakeInItem) --returns a pcm_source output
    local FullFileNamePath = reaper.GetMediaSourceFileName(PCMSource) --needs a pcm_source input, returns a string of the full file name path
    local SourceBaseName = string.gsub(FullFileNamePath,".*[/\\]","") --replaces the file path up to the last \ or / by the null string
    local SourceBaseNameNoExtension = string.gsub(SourceBaseName,"%.[^.]*$","") --replaces . ("%.") followed by non-dots ([^.]*) until the end ($) by the empty string ("")
    reaper.GetSetMediaItemTakeInfo_String(ActiveTakeInItem,"P_NAME",SourceBaseNameNoExtension,true) -- sets the name of the active take to be SourceBaseNameNoExtension
  end
end
