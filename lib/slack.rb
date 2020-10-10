#!/usr/bin/env ruby
require 'table_print'
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  options_list
  choice = get_user_choice
  execute_choice(workspace, choice)

  puts "Thank you for using the Ada Slack CLI"
end

def options_list
  print "Choose from the following:\n"
  puts "list users\nlist channels\nselect user\nselect channel\ndetails\nsend message\nquit"
end

def get_user_choice
  user_choice = gets.chomp
  options = ["list users", "list channels", "quit", "select user", "select channel", "details", "send message"]

  until options.include?(user_choice)
    puts "Invalid option. Please type: list users, list channels, select user, select channel, details, send message or quit"
    user_choice = gets.chomp
  end

  return user_choice
end

def execute_choice(workspace, choice)
  given_data = nil
  until choice == "quit"
    if choice == "list users"
      tp workspace.users_list, "username", "real_name", "slack_id"
      puts "\n"
    elsif choice == "list channels"
      tp workspace.channels_list, "name", "topic", "member_count", "slack_id"
    elsif choice == "select user"
      print "Please enter username or Slack ID: "
      user_info = gets.chomp
      given_data = workspace.select_user(user_info)
      if given_data.nil?
        puts "User not found"
      end
    elsif choice == "select channel"
      print "Please select channel name or Slack ID: "
      channel_info = gets.chomp
      given_data = workspace.select_channel(channel_info)
      if given_data.nil?
        puts "Channel not found."
      end
    elsif choice == "details"
      if given_data != nil
        puts given_data.details
      elsif given_data != nil
        puts given_data.details
      else
        puts "There is no user or channel that matches your search"
      end
    elsif choice == "send message"
      if given_data.nil?
        puts "Cannot send message. Please choose a recipient first."
      else
        puts "Please type your message:"
        user_msg = gets.chomp
        given_data.send_message(user_msg)
        puts "Success!"
      end
    end

    puts "*****\n\n"
    options_list
    choice = get_user_choice
  end
end

main if __FILE__ == $PROGRAM_NAME