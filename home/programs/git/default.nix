{ pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "vim";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool = "vim_mergetool";
    };
    mergetool."vim_mergetool" = {
      # this command requires the vim-mergetool plugin
      cmd = "vim -f -c \"MergetoolStart\" \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"";
      prompt = false;
    };
    pull.rebase = false;
    push.autoSetupRemote = true;
  };
in
{
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt # git files encryption
    hub # github command-line client
    tig # diff and commit view
  ];

  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    userEmail = "aeronth@berkeley.edu";
    userName = "Aeron Tynes Hammack";
  } // (pkgs.sxm.git or { });
}
