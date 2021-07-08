source ~/.bashrc

sed -i '114,$d' ~/.bashrc # Cleanup all of the variables initalized before

echo "--------------------------------------------"
echo "|           Edge Microserver Setup         |"
echo "--------------------------------------------"
printf "                                        \n"
echo " Everytime this script is run your previous"
echo " API keys will be cleared from the .bashrc"
printf " and replaced with the new entrys\n\n" 

echo "-------------------------------------------"
printf " Input your keys and host url\n"
printf " to be stored in environment variables\n\n"

printf  "   Enter Thingworx API Key: "
read -s tx_key
printf "\n\n"
echo export THINGWORX_KEY=$tx_key >> ~/.bashrc

printf "    Enter Thingworx Host: "
read -s tx_host
printf "\n\n"
echo export THINGWORX_HOST=$tx_host >> ~/.bashrc

printf "   Enter Onshape Access Key: "
read -s onshape_access_key
printf "\n\n"
echo export ONSHAPE_ACCESS_KEY=$onshape_access_key >> ~/.bashrc

printf "   Enter Onshape Secret Key: "
read -s onshape_secret_key
printf "\n\n"
echo export ONSHAPE_SECRET_KEY=$onshape_secret_key >> ~/.bashrc

printf "   Enter Octoprint API Key: "
read -s octopi_key
echo export OCTOPI_KEY=$octopi_key >> ~/.bashrc

printf "\n\n"
echo "-------------------------------------------"
printf "\n"
printf "      All API keys have been stored!\n\n"

printf "    Close the terminal and open a new\n"
printf "   in order for changes to take effect\n\n" 

echo "-------------------------------------------"

source ~/.bashrc

sed -i '28,$d' ~/.profile

echo "if [ -n \"\$BASH_VERSION\" ] && [ -f \$HOME/.bashrc ]; then" >> ~/.profile
echo   "source \$HOME/.bashrc" >> ~/.profile
echo "fi" >> ~/.profile


#sed -i '114,$d' ~/.bashrc 
