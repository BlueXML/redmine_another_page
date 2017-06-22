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

class LayoutTemplatesController < ApplicationController
	before_filter :require_login
	before_filter :require_admin, :only => [:create, :destroy]

	BLOCKS = MyController::BLOCKS

	DEFAULT_LAYOUT = MyController::DEFAULT_LAYOUT

	#To create a MyPage template
	def create
		if params[:title].blank? then #If title incorrect, flash error
	      flash[:error] = l(:error_title)
	    else #else create the template with params
	      @template = LayoutTemplate.new
	      @template[:title] = params[:title]
	      @template[:my_page_layout] = User.current.pref[:my_page_layout]
	      if @template.save then
	      	flash[:notice] = l(:notice_save_template)
	      else
      		flash[:error] = l(:error_save_template)
	      end
	    end
	    render :nothing => true
	end

	#To load a MyPage template in user's preferences
	def load
		@template = LayoutTemplate.find(params[:layout_template_id])
		if @template != nil then
			@user = User.current
			@user.pref[:my_page_layout] = @template[:my_page_layout]
			if !@user.pref.save then
	      		flash[:error] = l(:error_save_user_pref)
	      	end
		else
      		flash[:error] = l(:error_load_template)
      	end
	    render :nothing => true
	end

	#To destroy a MyPage Template
	def destroy
	    @template =  LayoutTemplate.find(params[:layout_template_id])
		if @template != nil then
	    	@template.destroy
	    else
      		flash[:error] = l(:error_delete_template)
	    end

	    render :nothing => true
	end
end