{ ... }:
{
  programs.nixvim = {
    opts = {
      laststatus = 2;
      showmode = false;
    };

    extraConfigLua = ''
      -- LSP Progress Tracker
      -- Caches LSP progress state and spinner for statusline display
      -- Uses LspProgress autocmd events to detect when LSP clients are working
      _G.lsp_progress = {
        spinner_index = 1,
        spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        is_active = false,
        timer = nil,
      }

      -- Updates the spinner animation frame and redraws the statusline
      -- Only called when the timer is active (LSP is working)
      local function update_spinner()
        _G.lsp_progress.spinner_index = 
          (_G.lsp_progress.spinner_index % #_G.lsp_progress.spinner_frames) + 1
        vim.cmd('redrawstatus')
      end

      -- Starts the spinner animation timer if not already running
      local function start_spinner()
        if not _G.lsp_progress.timer then
          _G.lsp_progress.timer = vim.fn.timer_start(
            80,
            update_spinner,
            { ['repeat'] = -1 }
          )
        end
      end

      -- Stops the spinner animation timer and clears it
      local function stop_spinner()
        if _G.lsp_progress.timer then
          vim.fn.timer_stop(_G.lsp_progress.timer)
          _G.lsp_progress.timer = nil
        end
      end

      -- Returns the current LSP progress indicator for the statusline
      -- Shows a spinner when any LSP client is actively working
      _G.get_lsp_progress = function()
        if _G.lsp_progress.is_active then
          local frame = _G.lsp_progress.spinner_frames[_G.lsp_progress.spinner_index]
          return frame 
        end
        return " "
      end

      -- Updates the LSP active state by checking all attached clients
      -- Called from the LspProgress autocmd to cache the state
      -- Starts or stops the spinner timer based on whether LSP is active
      _G.update_lsp_status = function()
        local has_active = false
        
        -- Check all LSP clients attached to the current buffer
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          -- Iterate through client progress messages
          for progress in client.progress do
            local value = progress.value
            -- If any progress is not "end", LSP is still working
            if value and value.kind ~= "end" then
              has_active = true
              break
            end
          end
          if has_active then break end
        end
        
        local was_active = _G.lsp_progress.is_active
        _G.lsp_progress.is_active = has_active
        
        -- Start timer when becoming active, stop when becoming inactive
        if has_active and not was_active then
          start_spinner()
        elseif not has_active and was_active then
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
        '%f ',
        '%m ',
        '%r',
        '%=',
        '%l:%c ',
        '%p%% ',
      }

      vim.opt.statusline = table.concat(statusline_components, "")
    '';

    # Autocmd to update LSP progress cache when LSP status changes
    autoCmd = [
      {
        event = [ "LspProgress" ];
        callback = {
          __raw = ''
            function()
              _G.update_lsp_status()
              vim.cmd('redrawstatus')
            end
          '';
        };
      }
    ];
  };
}
