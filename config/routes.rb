#Copyright (C) 2017  Alexandre BOUDINE
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Plugin's routes
RedmineApp::Application.routes.draw do
	get 'another', to: 'another#index'
	match 'another/add_block', :controller => 'another', :action => 'add_block', :via => :post
	match 'another/remove_block', :controller => 'another', :action => 'remove_block', :via => :post
	match 'another/order_blocks', :controller => 'another', :action => 'order_blocks', :via => :post
	match 'another/load_template', :controller => 'another', :action => 'load_template', :via => :post
	match 'another/load_template_multiuser', :controller => 'another', :action => 'load_template_multiuser', :via => :post


	match '/layout_template/create', :controller => 'layout_templates', :action => 'create', :via => :post
	match '/layout_template/load', :controller => 'layout_templates', :action => 'load', :via => :post
	match '/layout_template/destroy', :controller => 'layout_templates', :action => 'destroy', :via => :post
end
