nvm use --lts # Make sure npm is working

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status is-login
    if test -z $DISPLAY; and test $XDG_VTNR = 1
        exec startx
    end
end
