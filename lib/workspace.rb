require_relative 'channel.rb'
require_relative 'user.rb'

module SlackCLI
  class Workspace

    attr_reader :users, :channels

    def Initialize
      @users = User.list_all
      @channels= Channel.list_all
    end

    def users_list
      return @users
    end

    def channels_list
      return @channels
    end

    def select_user(user_info)
      name_search = @users.find{|user| user.username == user_info}
      id_search = @users.find{|user| user.slack_id == user_info}

      if name_search.nil?
        @selected_user = id_search
      elsif id_search.nil?
        @selected_user = name_search
      else
      puts "Invalid User name or ID"
      end
      return @selected_user
    end

    def select_channel(channel_info)
      name_search = @channels.find{|channel| channel.name == channel_info}
      id_search = @channels.find{|channel| channel.slack_id == channel_info}

      if name_search.nil?
        @selected_channel = id_search
      elsif id_search.nil?
        @selected_channel = name_search
      else
        puts "Invalid Channel name or ID"
      end
      return @selected_channel
    end

  end
end