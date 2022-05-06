# Certificate information
Show certificate info for start date, end date and serial

# Usage
    $ show_cert_info.sh <site.com>


# Run script from repo
    $ curl -s https://raw.githubusercontent.com/ura718/certinfo/main/show_cert_info.sh | bash -s <site.com>


# Setup alias in .bashrc for easy use
    $ vi .bashrc

    alias certinfo='curl -s https://raw.githubusercontent.com/ura718/certinfo/main/show_cert_info.sh | bash -s $1'
    

    After alias is setup run command
    $ certinfo <site.com>

