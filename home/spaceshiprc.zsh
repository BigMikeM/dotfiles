# Add a custom vi-mode section to the prompt
# See: https://github.com/spaceship-prompt/spaceship-vi-mode
spaceship add --before char vi_mode
spaceship_vi_mode_enable

# Display time
SPACESHIP_TIME_SHOW=true

# Until the bug is closed, I'm turning off async
SPACESHIP_PROMPT_ASYNC=false

# I don't like the extra space every time
SPACESHIP_PROMPT_ADD_NEWLINE=false

# Display username always
# SPACESHIP_USER_SHOW=always

# Do not truncate path in repos
SPACESHIP_DIR_TRUNC_REPO=true

