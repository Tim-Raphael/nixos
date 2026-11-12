{ ... }:
{
  programs.nixvim = {
    opts = {
      laststatus = 2;
      showmode = false;
    };

    extraConfigLua = ''
      -- Abbreviate file path for statusline display
      -- Hides everything before the git root directory
      -- Shows the git root and filename folder in full
      -- Abbreviates all directories in between to a single letter
      function _G.get_abbreviated_path()
        -- Wrap in pcall to prevent errors from breaking statusline
        local success, result = pcall(function()
          local filepath = vim.fn.expand("%:p")
          
          if filepath == "" then
            return "[No Name]"
          end
          
          -- Find git root by traversing upward with safety limit
          local git_root_path = nil
          local current_path = filepath
          local max_iterations = 50  -- Prevent infinite loops
          local iterations = 0
          
          while current_path ~= "/" and current_path ~= "" and iterations < max_iterations do
            iterations = iterations + 1
            
            local git_dir = current_path .. "/.git"
            if vim.fn.isdirectory(git_dir) == 1 then
              git_root_path = current_path
              break
            end
            
            local parent = vim.fn.fnamemodify(current_path, ":h")
            
            -- Break if we're not making progress (stuck at same path)
            if parent == current_path then
              break
            end
            
            current_path = parent
          end
          
          -- If not in a git repository, fall back to just the filename
          if not git_root_path then
            return vim.fn.expand("%:t")
          end
          
          -- Get the relative path from git root
          local relative_path = string.sub(filepath, #git_root_path + 2) -- +2 to skip the trailing slash
          
          -- Get git root directory name
          local git_root_name = vim.fn.fnamemodify(git_root_path, ":t")
          
          -- Split relative path into components
          local parts = {}
          for part in string.gmatch(relative_path, "[^/]+") do
            table.insert(parts, part)
          end
          
          if #parts == 0 then
            return git_root_name
          end
          
          -- Build abbreviated path
          local result = { "./" .. git_root_name }
          
          for i, part in ipairs(parts) do
            if i > #parts - 2 then
              -- Show only the last component (filename) in full
              table.insert(result, part)
            else
              -- Abbreviate all directories to first character
              table.insert(result, string.sub(part, 1, 1))
            end
          end
          
          return table.concat(result, "/")
        end)
        
        -- If any error occurred, return a safe fallback
        if not success then
          return vim.fn.expand("%:t")  -- Just show filename
        end
        
        return result
      end
      _G.lsp_progress = {
        spinner_index = 1,
        spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        is_active = false,
        timer = nil,
        active_tokens = {},
      }

      local function update_spinner()
        -- Servers can exit without sending a final progress notification.
        _G.update_lsp_status()
        _G.lsp_progress.spinner_index =
          (_G.lsp_progress.spinner_index % #_G.lsp_progress.spinner_frames) + 1
        vim.cmd("redrawstatus")
      end

      local function start_spinner()
        if not _G.lsp_progress.timer then
          _G.lsp_progress.timer = vim.fn.timer_start(
            80,
            update_spinner,
            { ["repeat"] = -1 }
          )
        end
      end

      local function stop_spinner()
        if _G.lsp_progress.timer then
          vim.fn.timer_stop(_G.lsp_progress.timer)
          _G.lsp_progress.timer = nil
        end
      end

      _G.get_lsp_progress = function()
        if _G.lsp_progress.is_active then
          local frame = _G.lsp_progress.spinner_frames[_G.lsp_progress.spinner_index]
          return frame
        end
        return " "
      end

      _G.update_lsp_status = function(data)
        -- Event payloads survive buffer switches and other progress consumers.
        if data then
          local client_id = data.client_id
          local token = data.params.token
          local value = data.params.value

          if token ~= nil and type(value) == "table" then
            local tokens = _G.lsp_progress.active_tokens[client_id]
            if value.kind == "begin" then
              if not tokens then
                tokens = {}
                _G.lsp_progress.active_tokens[client_id] = tokens
              end
              tokens[token] = true
            elseif value.kind == "end" and tokens then
              tokens[token] = nil
            end
          end
        end

        for client_id, tokens in pairs(_G.lsp_progress.active_tokens) do
          local client = vim.lsp.get_client_by_id(client_id)
          if not client or client:is_stopped() or vim.tbl_isempty(tokens) then
            _G.lsp_progress.active_tokens[client_id] = nil
          end
        end

        local has_active = not vim.tbl_isempty(_G.lsp_progress.active_tokens)
        _G.lsp_progress.is_active = has_active

        if has_active then
          start_spinner()
        else
          stop_spinner()
        end
      end

      -- Mode Display Mapping
      -- Maps Neovim's internal mode codes to 3-character abbreviations
      _G.mode_map = {
        ['n']      = 'NOR',
        ['no']     = 'N-O',
        ['nov']    = 'N-O',
        ['noV']    = 'N-O',
        ['no\22']  = 'N-O',
        ['niI']    = 'NOR',
        ['niR']    = 'NOR',
        ['niV']    = 'NOR',
        ['nt']     = 'NOR',
        ['ntT']    = 'NOR',
        ['v']      = 'VIS',
        ['vs']     = 'VIS',
        ['V']      = 'V-L',
        ['Vs']     = 'V-L',
        ['\22']    = 'V-B',
        ['\22s']   = 'V-B',
        ['s']      = 'SEL',
        ['S']      = 'S-L',
        ['\19']    = 'S-B',
        ['i']      = 'INS',
        ['ic']     = 'INS',
        ['ix']     = 'INS',
        ['R']      = 'REP',
        ['Rc']     = 'REP',
        ['Rx']     = 'REP',
        ['Rv']     = 'V-R',
        ['Rvc']    = 'V-R',
        ['Rvx']    = 'V-R',
        ['c']      = 'CMD',
        ['cv']     = 'EX',
        ['ce']     = 'EX',
        ['r']      = 'PRM',
        ['rm']     = 'MOR',
        ['r?']     = 'CNF',
        ['!']      = 'SHL',
        ['t']      = 'TRM',
      }

      _G.get_mode_display = function()
        local mode_code = vim.api.nvim_get_mode().mode
        return _G.mode_map[mode_code] or mode_code
      end

      -- Statusline Configuration
      -- Left-aligned: mode, LSP progress, filepath, modified/readonly flags
      -- Right-aligned: cursor position, file percentage
      local statusline_components = {
        ' %{v:lua.get_mode_display()} ',
        '%{v:lua.get_lsp_progress()} ',
        '%{v:lua.get_abbreviated_path()} ',
        '%m ',
        '%r',
        '%=',
        '%l:%c ',
        '%p%% ',
      }

      vim.opt.statusline = table.concat(statusline_components, "")
    '';

    autoCmd = [
      {
        event = [ "LspProgress" ];
        callback.__raw = ''
          function(args)
            _G.update_lsp_status(args.data)
            vim.cmd('redrawstatus')
          end
        '';
      }
      {
        event = [ "LspDetach" ];
        callback.__raw = ''
          function(args)
            local client_id = args.data.client_id
            -- LspDetach runs before attached_buffers is updated.
            vim.schedule(function()
              local client = vim.lsp.get_client_by_id(client_id)
              if not client or client:is_stopped() or vim.tbl_isempty(client.attached_buffers) then
                _G.lsp_progress.active_tokens[client_id] = nil
              end
              _G.update_lsp_status()
              vim.cmd('redrawstatus')
            end)
          end
        '';
      }
    ];
  };
}
