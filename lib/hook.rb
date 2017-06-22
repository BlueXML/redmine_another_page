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

class Hook < Redmine::Hook::ViewListener
	#Add the content of another/_body_bottom.html.erb to the page_layout of My Page
	render_on :view_layouts_base_body_bottom, :partial => 'another/body_bottom'

	def view_layouts_base_html_head(context = { })
    	stylesheet_link_tag 'another.css', :plugin => 'redmine_another_page'
    end
end