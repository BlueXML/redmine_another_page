# RedMine Another Page
## A RedMine plugin

This plugins aim to help administrators to harmonize the interface of every users.
With this plugin, the page 'My Page' of every users becomes manageable for admins.
Also, it provides the possibility to save templates of current layout to be used by every users.


## Features :

This plugin provides the following features :
* Possibility to manage 'My Page' content for users by administrators
* Possibility to save templates of layout configuration for 'My Page' by administrators
* Possibility to load those layouts by every users

Languages availables :
* EN
* FR

## Use :

To modify other users pages :
	Administration -> Manage other users pages -> select User
To create Template :
	My Page -> personalize this page -> Export to template
To load Template :
	My Page -> personalize this page -> Load Template -> select Template
To delete Template :
	My Page -> personalize this page -> Delete Template -> select Template

## Installation :

	$cd /path/to/redmine/directory/plugins
	$git clone https://github.com/BlueXML/redmine_another_page.git
	$bundle exec rake redmine:plugins:migrate RAILS_ENV=production

## Compatibility :
Tested for RedMine 3.3.* (Manually)

## License :
This plugin is licensed under the GNU/GPL license v3.




