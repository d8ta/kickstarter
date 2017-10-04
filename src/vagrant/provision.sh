# ===== Passed Variables ===== #
# $1 = DOMAINS
# $2 = TLD
# $3 = PROJECT

PROJECT=$3

# Split domain string into DOMAINS array
IFS=' ' read -a DOMAINS <<< "$1"

# Add environment variable
echo "SetEnv ENVIRONMENT 'develop'" | sudo tee -a /etc/apache2/apache2.conf

# Set correct document root
printf "#### Set document root ####\n"
mkdir -p /var/www/htdocs
sudo sed -i 's/public/htdocs/' /etc/apache2/sites-available/000-default.conf

# Remove scotchbox site
if [[ -a  /etc/apache2/sites-available/scotchbox.local.conf ]]; then
	printf "#### Remove scotchbox.local site ####\n"
	rm /etc/apache2/sites-available/scotchbox.local.conf
	a2dissite scotchbox.local
fi

#===== Loop through all sites =====#
for ((i=0; i < ${#DOMAINS[@]}; i++)); do

    # Current Domain
    DOMAIN=${DOMAINS[$i]}
    ROOT="/var/www/$DOMAIN/htdocs"

	printf "###########################################";
	printf "Create new virtual host for $DOMAIN";
	printf "###########################################";

    # Make directory
    mkdir -p $ROOT

    # New virtual host
	cat > /etc/apache2/sites-available/$DOMAIN.conf <<- EOM
	<VirtualHost *:80>
	    DocumentRoot $ROOT
	    ServerName "$DOMAIN.$2"
	    ServerAlias $DOMAIN.*.*.*.*.xip.io
	</VirtualHost>
	EOM

	# Add new configuration
	sudo a2ensite $DOMAIN.conf
done

#===== setup projects =====#
if [[ $PROJECT != '' ]]; then
	rm -rf /var/www/htdocs

	printf "### SETUP '$PROJECT' PROJECT ###";

	case $PROJECT in
		"laravel")
		    composer create-project laravel/laravel /var/www/htdocs
		    sudo sed -i 's/htdocs/htdocs\/public/' /etc/apache2/sites-available/000-default.conf
		;;
		"codeigniter")
		    composer create-project codeigniter/framework /var/www/htdocs
		;;
		"wordpress")
			mkdir -p /var/www/htdocs
			cp /var/www/src/vagrant/wordpress/composer.json /var/www/htdocs/composer.json
			cd /var/www/htdocs
			composer install
		;;
	esac
fi

# finaly restart apache server
sudo service apache2 restart