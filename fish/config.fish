nvm use --lts > /dev/null # Make sure npm is working

switch (uname)
    case Linux
        if status is-interactive
            # Commands to run in interactive sessions can go here
        end

        if status is-login
            if test -z $DISPLAY; and test $XDG_VTNR = 1
                exec startx
            end
        end
    case Darwin
        /opt/homebrew/bin/brew shellenv | source
end
