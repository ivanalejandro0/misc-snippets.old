#!/bin/bash

drush dl admin_menu module_filter pathauto views panels wysiwyg webform --destination=sites/all/modules/contrib/
drush -y en panels_mini panels_node panels page_manager views_content ctools_custom_content
drush -y en admin_menu admin_menu_toolbar module_filter pathauto views views_ui views_content wysiwyg
 
# Display Suite
drush dl ds --destination=sites/all/modules/contrib/
drush -y en ds*
 
drush dl features ftools diff strongarm --destination=sites/all/modules/contrib/
drush -y en features ftools diff strongarm
 
# para el profile: minimal
drush -y en field_ui image
 
# Limpio la cache
drush cc all
