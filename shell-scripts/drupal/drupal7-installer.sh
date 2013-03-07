#!/bin/bash
# Script that handles
# - User & database creation (dropping the previous one if it exists)
# - Download and install drupal in directory: ./$SITE_NAME
# - Give permission to the directory: sites/default/files

# password generator function
# usage: SOME_PASS=$(genpasswd)
genpasswd() {
    local l=16  # password length 
    echo $(tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs)
} 

create_template_conf(){
cat > $1 << _EOF_
MYSQL_ADMIN=root
MYSQL_PASS=root

SITE_TITLE="Site name here"
SITE_NAME="site_name
PROFILE="minimal"
WEBMASTER_MAIL="webmaster@site_name.com"
ADMIN_PASS="admin"

DBNAME=\$SITE_NAME
DBUSER=\$SITE_NAME
DBPASS=\$(genpasswd)
_EOF_
echo "== Done =="
echo "The configuration template has been written to: $1"
}

recreate() {
    OK=0

    # Installation and configuration process
    mysql -u root -e "drop database if exists $DBNAME; create database $DBNAME default character set utf8; grant all privileges on $DBNAME.* to $DBUSER@localhost identified by '$DBPASS'" --user=$MYSQL_ADMIN --password=$MYSQL_PASS &&
    drush dl drupal --drupal-project-rename=$SITE_NAME &&
    cd $SITE_NAME &&
    drush -y si $PROFILE --db-url=mysql://$DBUSER:$DBPASS@localhost/$DBNAME --account-pass=$ADMIN_PASS --account-mail=$WEBMASTER_MAIL --site-name="$SITE_TITLE" --locale=es --clean-url &&
    mkdir sites/all/modules/contrib &&
    chmod 777 sites/default/files -R && OK=1

    echo

    if [[ OK==1 ]]; then
        echo "== Done =="
        echo "Site name: $SITE_NAME, Title: $SITE_TITLE"
        echo "Site administration => User: admin, Password: $ADMIN_PASS"
        echo "Profile: $PROFILE"
        echo "Database => DB Name: $DBNAME, User: $DBUSER, Password: $DBPASS"
    else
        echo "== Error =="
        echo "An error has been ocurred in the script."
    fi
}

create(){
    if [[ -d $SITE_NAME ]]; then
        echo "== Error =="
        echo "The site already exists. Use recreate."
        return
    fi
    # TODO: check whether the db exists or not.
    recreate
}

delete(){
    OK=0
    rm $SITE_NAME -fr
    # mysql -u root -e "revoke all privileges from $DBUSER; drop user $DBUSER; drop database if exists $DBNAME" --user=$MYSQL_ADMIN --password=$MYSQL_PASS && OK=1
    mysql -u root -e "drop user $DBUSER; drop database if exists $DBNAME" --user=$MYSQL_ADMIN --password=$MYSQL_PASS && OK=1

    if [[ OK==1 ]]; then
        echo "== Done =="
        echo "The disposable site has been deleted."
    else
        echo "== Error =="
        echo "An error has been ocurred in the script."
    fi
}

help() {
    echo "Usage: $0 { create, c | recreate, r | delete, d | template, t } site_configurations.conf"
    echo
    echo "  Options: "
    echo "    create, c   : creates a new drupal site using the site_configurations.conf file"
    echo "    recreate, r : recreates an existing drupal site using the site_configurations.conf file"
    echo "    delete, d   : deletes an existing drupal site using the site_configurations.conf file"
    echo "    template, t : creates a site_configurations.conf file that can be used as template for new sites"
    echo
}

check_and_warn(){
    if [ -f $1 ]; then
        echo "error: the file $1 already exists, remove/rename manually"
        exit
    fi
}

check_and_load(){
    if [ ! -f $1 ]; then
        echo "error: the file $1 does not exists"
        exit
    fi

    source $1
}

if [ $# != 2 ]; then
    echo "error: missing parameter!"
    help
    exit
fi

case $1 in
    create|c)
        check_and_load $2
        echo "-> Creating disposable Drupal"
        create
        ;;
    recreate|r)
        check_and_load $2
        echo "-> Recreating disposable Drupal"
        recreate
        ;;
    delete|d)
        check_and_load $2
        echo "-> Deleting disposable Drupal"
        delete
        ;;
    template|t)
        check_and_warn $2
        echo "-> Creating template configuration file"
        create_template_conf $2 
        ;;
    *)
        help
esac
