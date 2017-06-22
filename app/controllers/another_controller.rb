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

class AnotherController < ApplicationController
	before_filter :require_login
	before_filter :require_admin

	BLOCKS = MyController::BLOCKS

  DEFAULT_LAYOUT = MyController::DEFAULT_LAYOUT

  	#Display user's MyPage configuration
	def index
		@user_id = params[:user_id]
		if @user_id != '-1' && @user_id != nil then
			@user = User.find(@user_id)
			@blocks = @user.pref[:my_page_layout] || DEFAULT_LAYOUT.dup
		    @block_options = []
		    BLOCKS.each do |k, v|
		      unless @blocks.values.flatten.include?(k)
		        @block_options << [l("my.blocks.#{v}", :default => [v, v.to_s.humanize]), k.dasherize]
		      end
		    end
		end
	end

	# Add a block to user's page
    # The block is added on top of the page
    # params[:block] : id of the block to add
    def add_block
      user_id = params[:user_id]
      block = params[:block].to_s.underscore
      if block.present? && BLOCKS.key?(block)
        @user = User.find(user_id)
        layout = @user.pref[:my_page_layout] || {}
        # remove if already present in a group
        %w(top left right).each {|f| (layout[f] ||= []).delete block }
        # add it on top
        layout['top'].unshift block
        @user.pref[:my_page_layout] = layout
        @user.pref.save
      end
      redirect_to another_path(user_id: user_id)
    end

    # Remove a block to user's page
    # params[:block] : id of the block to remove
    def remove_block
      user_id = params[:user_id]
      block = params[:block].to_s.underscore
      @user = User.find(user_id)
      # remove block in all groups
      layout = @user.pref[:my_page_layout] || {}
      %w(top left right).each {|f| (layout[f] ||= []).delete block }
      @user.pref[:my_page_layout] = layout
      @user.pref.save
      redirect_to another_path(user_id: user_id)
    end

    # Change blocks order on user's page
    # params[:group] : group to order (top, left or right)
    # params[:list-(top|left|right)] : array of block ids of the group
    def order_blocks
      user_id = params[:user_id]
      group = params[:group]
      @user = User.find(user_id)
      if group.is_a?(String)
        group_items = (params["blocks"] || []).collect(&:underscore)
        group_items.each {|s| s.sub!(/^block_/, '')}
        if group_items and group_items.is_a? Array
          layout = @user.pref[:my_page_layout] || {}
          # remove group blocks if they are presents in other groups
          %w(top left right).each {|f|
            layout[f] = (layout[f] || []) - group_items
          }
          layout[group] = group_items
          @user.pref[:my_page_layout] = layout
          @user.pref.save
        end
      end
      render :nothing => true
    end

    def load_template
      @template = LayoutTemplate.find(params[:layout_template_id])
      if @template != nil then
        @user = User.find(params[:user_id])
        @user.pref[:my_page_layout] = @template[:my_page_layout]
        if !@user.pref.save then
          flash[:error] = l(:error_save_user_pref)
        end
      else
        flash[:error] = l(:error_load_template)
      end
      render :nothing => true
    end

    def load_template_multiuser
      @template = LayoutTemplate.find(params[:layout_template_id])
      if @template != nil then
        @users = []
        params[:users_ids].each do |u|
          @users.push(User.find(u))
        end
        if(@users.length > 0) then
          @users.each do |u|
            u.pref[:my_page_layout] = @template[:my_page_layout]
            if !u.pref.save then
              flash[:error] = l(:error_save_user_pref)
            end
          end
        else
          flash[:error] = l(:error_multiple_users_select)
        end
      else
        flash[:error] = l(:error_load_template)
      end
      render :nothing => true
    end
end