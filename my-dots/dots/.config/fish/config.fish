function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    
end


  # direnv integration
  if command -v direnv > /dev/null
      eval (direnv hook fish)
  end

  # NorskTutor aliases (optional)
  alias norsk='cd /home/rnadagoud/Projects/NorskTutor'
  alias norsk-run='cd /home/rnadagoud/Projects/NorskTutor && python src/main.py'
  alias norsk-test='cd /home/rnadagoud/Projects/NorskTutor && pytest tests/ -v'
  alias norsk-format='cd /home/rnadagoud/Projects/NorskTutor && black src/ tests/ && isort src/ tests/'
  
