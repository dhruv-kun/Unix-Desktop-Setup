
if [[ $(whoami) == "root" ]];
    then echo "Root user detected. Permission Denied."
    exit
fi


#####################################################################################
#                                  Upgrade and Update                               #
#####################################################################################

echo "Do you want to update and upgrade the distro[Y\n]: "
response="Y"
read response

if [[ $response == "Y" ]]; then
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
fi

#####################################################################################
#                                  Simple Utilities                                 #
#####################################################################################

echo "Installing simple utilities"
sudo apt-get install -y vim \
    terminator \
    synapse \
    vlc \
    deluge \
    zsh \
    git \
    pass \
    curl \
    build-essential \
    caffeine \
    mysql-server \
    gparted \
    htop


# #####################################################################################
# #                                  Chrome                                           #
# #####################################################################################

echo "Installing Google Chrome"
if [ -z $(which google-chrome) ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome is already installed"
fi

# #####################################################################################
# #                                  Powerline Fonts                                  #
# #####################################################################################

echo "Installing Powerline Fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

#####################################################################################
#                                  Sublime Setup                                    #
#####################################################################################

echo "Installing Sublime Text 3"
if [ -z $(which subl) ]; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

    sudo apt-get install apt-transport-https

    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    sudo apt-get update
    sudo apt-get install sublime-text
else
    echo "Sublime Text is already installed"
fi

#####################################################################################
#                                  Zsh Setup                                        #
#####################################################################################

echo "Changing default shell to ZSH"
if [[ $SHELL != *"zsh"* ]]; then
    chsh -s $(which zsh)
else
    echo "Default shell is ZSH"
fi

# #####################################################################################
# #                                  Icon Theme (Flat Remix)                          #
# #####################################################################################

echo "Installing Flat Remix Icon theme"
sudo add-apt-repository -y ppa:daniruiz/flat-remix
sudo apt-get -y update
sudo apt-get install -y flat-remix-gnome

# #####################################################################################
# #                                  Install Snap                                     #
# #####################################################################################

echo "Installing snap"
if [ -z $(which snap) ]; then
    sudo apt -y update
    sudo apt install -y snapd
else
    echo "Snap already exists"
fi

# #####################################################################################
# #                                  VSCode                                           #
# #####################################################################################

echo "Installing Visual Studio Code"
if [ -z $(which code) ]; then
    sudo snap install code --classic
else
    echo "VSCode already exists"
fi

# #####################################################################################
# #                                  Python                                           #
# #####################################################################################

echo "Installing python and python tools"
sudo apt-get install -y python3-pip python3-dev python3-virtualenv python3-setuptools
