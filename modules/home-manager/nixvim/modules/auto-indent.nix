{ ... }:

{
  programs.nixvim.extraConfigLua = ''
    -- Auto-detect indentation settings
         local function detect_indent()
           local buf = vim.api.nvim_get_current_buf()
           local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
           
           -- Counters for different indentation patterns
           local tab_count = 0
           local space_counts = {
             [2] = 0,
             [4] = 0,
             [8] = 0
           }
           
           -- Pattern to match indented lines
           local indent_patterns = {
             tab = "^\t+",
             spaces_2 = "^  [^ ]",
             spaces_4 = "^    [^ ]",
             spaces_8 = "^        [^ ]"
           }
           
           -- Analyze first 100 lines (or all lines if fewer)
           local max_lines = math.min(#lines, 100)
           
           for i = 1, max_lines do
             local line = lines[i]
             
             -- Skip empty lines and comments
             if line:match("^%s*$") or line:match("^%s*[#//]") then
               goto continue
             end
             
             -- Check for tab indentation
             if line:match(indent_patterns.tab) then
               tab_count = tab_count + 1
             end
             
             -- Check for space indentation patterns
             if line:match(indent_patterns.spaces_2) then
               space_counts[2] = space_counts[2] + 1
             end
             
             if line:match(indent_patterns.spaces_4) then
               space_counts[4] = space_counts[4] + 1
             end
             
             if line:match(indent_patterns.spaces_8) then
               space_counts[8] = space_counts[8] + 1
             end
             
             ::continue::
           end
           
           -- Determine the most common indentation
           local use_tabs = false
           local indent_size = 4 -- default
           
           -- Find the most common space indentation
           local max_space_count = 0
           local best_space_size = 4
           
           for size, count in pairs(space_counts) do
             if count > max_space_count then
               max_space_count = count
               best_space_size = size
             end
           end
           
           -- Decide between tabs and spaces
           if tab_count > max_space_count then
             use_tabs = true
             indent_size = 4 -- Default tab width
           else
             use_tabs = false
             indent_size = best_space_size
           end
           
           return use_tabs, indent_size
         end

         -- Function to apply the detected settings
         local function apply_indent_settings(use_tabs, indent_size)
           local bo = vim.bo
           
           if use_tabs then
             bo.expandtab = false
             bo.tabstop = indent_size
             bo.shiftwidth = indent_size
             bo.softtabstop = indent_size
           else
             bo.expandtab = true
             bo.tabstop = indent_size
             bo.shiftwidth = indent_size
             bo.softtabstop = indent_size
           end
         end

         -- Main auto-detect function
         function AutoDetectIndent()
           local use_tabs, indent_size = detect_indent()
           apply_indent_settings(use_tabs, indent_size)
         end

         -- Create user command
         vim.api.nvim_create_user_command('DetectIndent', AutoDetectIndent, {
           desc = 'Auto-detect and set indentation for current buffer'
         })

         -- Auto-detect on file open
         vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
           callback = function()
             vim.defer_fn(AutoDetectIndent, 10)
           end,
           desc = 'Auto-detect indentation on file open'
         })

         -- Auto-detect when switching buffers
         vim.api.nvim_create_autocmd('BufEnter', {
           callback = AutoDetectIndent,
           desc = 'Auto-detect indentation on buffer switch'
         })
  '';
}
