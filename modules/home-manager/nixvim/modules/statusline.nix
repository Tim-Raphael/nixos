{ pkgs, ... }:

let
  lsp-progress = pkgs.vimUtils.buildVimPlugin {
    pname = "lsp-progress";
    version = "1.0.15";
    src = pkgs.fetchFromGitHub {
      owner = "linrongbin16";
      repo = "lsp-progress.nvim";
      rev = "main";
      sha256 = "sha256-OeYmPR703QpL/eZCVIxOvnHKOsjDfNqm71XxQp1A+jA=";
    };
    # Disable checks that require git during the build process.
    # The plugin's test suite attempts to execute git commands which aren't
    # available in the Nix build sandbox, causing the build to fail.
    doCheck = false;
  };
in
{
  programs.nixvim = {
    opts = {
      # Always show the statusline (2 = always visible).
      laststatus = 2;
      # Disable default mode indicator, since it's included in the statusline.
      showmode = false;
    };

    extraPlugins = [ lsp-progress ];

    # Initialize lsp-progress and configure the statusline.
    extraConfigLua = ''
      -- TDOO: Currently just using the spinner, check how easy it to implement
      -- on my own.
      require('lsp-progress').setup({
        series_format = function(_title, _message, percentage, _done)
          return "" 
        end,

        client_format = function(client_name, spinner, series_messages)
          return #series_messages > 0
            and spinner
            -- and (spinner .. " [" .. client_name .. "] ".. table.concat(series_messages, ""))  
          or nil
        end,

        format = function(client_messages)
          if #client_messages > 0 then
            return table.concat(client_messages, "")
          end
          return " "
        end
      })

      -- Cache for LSP progress to avoid expensive lookups on every statusline redraw.
      _G.lsp_progress_cache = ""

      local function update_lsp_progress()
        _G.lsp_progress_cache = require('lsp-progress').progress()
      end

      _G.get_lsp_progress = function()
        return _G.lsp_progress_cache
      end

      -- Initialize the cache
      update_lsp_progress()

      _G.mode_map = {
        ['n'] = 'NOR',
        ['no'] = 'N-O',
        ['nov'] = 'N-O',
        ['noV'] = 'N-O',
        ['no\22'] = 'N-O',
        ['niI'] = 'NOR',
        ['niR'] = 'NOR',
        ['niV'] = 'NOR',
        ['nt'] = 'NOR',
        ['ntT'] = 'NOR',
        ['v'] = 'VIS',
        ['vs'] = 'VIS',
        ['V'] = 'V-L',
        ['Vs'] = 'V-L',
        ['\22'] = 'V-B',
        ['\22s'] = 'V-B',
        ['s'] = 'SEL',
        ['S'] = 'S-L',
        ['\19'] = 'S-B',
        ['i'] = 'INS',
        ['ic'] = 'INS',
        ['ix'] = 'INS',
        ['R'] = 'REP',
        ['Rc'] = 'REP',
        ['Rx'] = 'REP',
        ['Rv'] = 'V-R',
        ['Rvc'] = 'V-R',
        ['Rvx'] = 'V-R',
        ['c'] = 'CMD',
        ['cv'] = 'EX',
        ['ce'] = 'EX',
        ['r'] = 'PRM',
        ['rm'] = 'MOR',
        ['r?'] = 'CNF',
        ['!'] = 'SHL',
        ['t'] = 'TRM',
      }

      _G.get_mode_display = function()
        local mode_code = vim.api.nvim_get_mode().mode
        return _G.mode_map[mode_code] or mode_code
      end

      local statusline_builder = {
        ' %{v:lua.get_mode_display()} ',     -- Current mode 
        '%{v:lua.get_lsp_progress()} ',       -- LSP progress indicator (cached)
        '%f ',                                -- Relative file path
        '%m ',                                -- Modified flag [+]
        '%r',                                 -- Readonly flag [RO]
        '%=',                                 -- Right-align the rest
        '%l:%c ',                             -- Line:column position
        '%p%% ',                              -- Percentage through file
      }

      vim.opt.statusline = table.concat(statusline_builder, "")
    '';

    # Set up autocommand to refresh statusline when LSP progress updates.
    # This ensures the statusline redraws whenever LSP status changes.
    autoCmd = [
      {
        event = [ "User" ];
        pattern = "LspProgressStatusUpdated";
        callback = {
          __raw = ''
            function() 
              _G.lsp_progress_cache = require('lsp-progress').progress()
              vim.cmd('redrawstatus')
            end'';
        };
      }
    ];
  };
}
