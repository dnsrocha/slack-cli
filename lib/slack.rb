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

def valid_msg(recipient)
  puts "Please type your message:"
  user_msg = gets.chomp
  recipient.send_message(user_msg)
  return "Success!"
end

def execute_choice(workspace, choice)
  given_user = nil
  given_channel = nil
  until choice == "quit"
    if choice == "list users"
      tp workspace.users_list, "username", "real_name", "slack_id"
      puts "\n"
    elsif choice == "list channels"
      tp workspace.channels_list, "name", "topic", "member_count", "slack_id"
    elsif choice == "select user"
      workspace.users_list
      print "Please enter username or Slack ID: "
      user_info = gets.chomp
      given_user = workspace.select_user(user_info)
    elsif choice == "select channel"
      workspace.channels_list
      print "Please select channel name or Slack ID: "
      channel_info = gets.chomp
      given_channel = workspace.select_channel(channel_info)
    elsif choice == "details"
      if given_user != nil
        puts given_user
      elsif given_channel != nil
        puts given_channel
      else
        puts "There is no user or channel that matches your search"
      end
    elsif choice == "send message"
      if given_user.nil? && given_channel.nil?
        puts "Cannot send message. Please choose a recipient first."
      elsif given_user != nil
        valid_msg(given_user)
      elsif given_channel != nil
        valid_msg(given_channel)
      end
    end

    puts "***\n"
    options_list
    choice = get_user_choice
  end
end

main if __FILE__ == $PROGRAM_NAME