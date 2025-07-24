{ lib, pkgs, ... }:

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
    extraPlugins = lib.mkAfter [ alpha ];

    extraConfigLua = ''
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'

      dashboard.section.header.val = {
        [[                                 __                ]],
        [[    ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[   / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[  /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      dashboard.section.buttons.val = {
          dashboard.button("<C-n>", "> File Explorer", ":Oil<CR>"),
          dashboard.button("<leader>g", "> Grep", ":Telescope live_grep<CR>"),
          dashboard.button("<leader>f", "> Find", ":Telescope find_files<CR>"),
          dashboard.button("<leader>S", "> Status", ":Telescope git_status<CR>"),
          dashboard.button("<leader>B", "> Branches", ":Telescope git_branches<CR>"),
          dashboard.button("<leader>C", "> Commits", ":Telescope git_commits<CR>"),
          dashboard.button("<leader>p", "> Projects", ":Telescope project<CR>"),
      }

      dashboard.section.footer = {
        { type = "text", val = "Placeholder Quote" },
      }

      dashboard.config.opts.noautocmd = true
      vim.cmd[[autocmd User AlphaReady echo 'all set']]
      alpha.setup(dashboard.config)
    '';
  };
}
