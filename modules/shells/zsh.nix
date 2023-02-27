{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;

    plugins = [ ];

    oh-my-zsh = {
      enable = true;
      plugins = [ ];
    };

    initExtra = ''
      # Spaceship Theme
      source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      autoload -U promptinit; promptinit

      # Eye candy
      pfetch
    '';
  };
}
