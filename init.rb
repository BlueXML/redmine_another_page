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

require 'redmine'
require_dependency 'hook' #Apply views modifications

Redmine::Plugin.register :redmine_another_page do
  name 'Another Page management plugin'
  author 'Alexandre BOUDINE'
  description 'Allow admins to modify the "My Page" of other users, and create / load templates for this page for all users'
  version '0.1.1'

  menu :admin_menu, :manage_other_users_pages, {controller: 'another', action: 'index'}, :caption => :label_manage_other
end

