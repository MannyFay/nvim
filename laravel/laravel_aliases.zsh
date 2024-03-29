# ~/.config/dotfiles/laravel/laravel_aliases.zsh


#-----------------------------------------------------------------------------
#  Laravel ZSH Aliases
#-----------------------------------------------------------------------------


#-----------------------------------------------------------
#- Sail

# Use 'sail' instead of './vendor/bin/sail':
alias sail='./vendor/bin/sail'

# Start Sail in detached mode:
alias sud='./vendor/bin/sail up -d'

# Start Sail:
alias su='./vendor/bin/sail up'

# Stop Sail:
alias sd='./vendor/bin/sail down'

# Show artisan commands:
alias salc='./vendor/bin/sail artisan'

# Start Composer update:
alias scu='./vendor/bin/sail composer update'

# Publish vendor directory:
alias svp='./vendor/bin/sail vendor:publish --force'


alias smfs='sail migrate:fresh --seed'
# Refresh database with project seeders.

alias scda='sail composer dump-autoload'

alias scu='sail composer update'





alias l,lc='php artisan'
# List commands.


alias l,seeddb='php artisan db:seed'
# Seed database with records.


alias l,st='php artisan tinker'
# Start Tinker CLI.


# laravel clockwork browser plugin anschauen!
# table plus sql oberfläche!
