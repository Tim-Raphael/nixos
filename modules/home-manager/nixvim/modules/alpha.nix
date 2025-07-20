{ pkgs, ... }:

let
  alpha = pkgs.vimUtils.buildVimPlugin {
    pname = "alpha";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "main";
      sha256 = "sha256-sNi5qarejYqM4/J7lBZI3gjVLxer5FBPq8K6qjqcMjA=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ alpha ];

    extraConfigLuaPost = ''
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'

      dashboard.section.header.val = {
        [[                                   __                ]],
        [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      dashboard.section.buttons.val = {
          dashboard.button("ctrl+e", "> Explore", ":FernToggle<CR>"),
          dashboard.button("spce+s", "> Search", ":Telescope live_grep<CR>"),
          dashboard.button("spce+o", "> Open file", ":Telescope git_files<CR>"),
          dashboard.button("spce+f", "> Find file", ":Telescope find_files<CR>"),
          dashboard.button("spce+g", "> Status", ":Telescope git_status<CR>"),
          dashboard.button("spce+b", "> Branches", ":Telescope git_branches<CR>"),
          dashboard.button("spce+c", "> Commits", ":Telescope git_commits<CR>"),
          dashboard.button("ctrl+p", "> Projects", ":Telescope project<CR>"),
          dashboard.button("ctrl+c", "> Quit", ":qa<CR>"),
      }

      dashboard.section.footer = {
        { type = "text", val = "Placeholder Quote" },
      }

      dashboard.config.opts.noautocmd = true
      vim.cmd[[autocmd User AlphaReady echo 'ready']]
      alpha.setup(dashboard.config)
    '';
  };
}
