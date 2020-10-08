#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'workspace.rb'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  options_list
  choice = get_user_choice

  execute_choice(workspace, choice)
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

def options_list
  print "Choose from the following:\n"
  puts "list users\nlist channels\nselect user\nselect channel\ndetails\nquit"
end

def get_user_choice
  user_choice = gets.chomp
  options = ["list users", "list channels", "quit", "select user", "select channel", "details"]

  until options.include?(user_choice)
    puts "Invalid option. Please type: list users, list channels, select user, select channel, details or quit"
    user_choice = gets.chomp
  end

  return user_choice
end

def execute_choice(workspace, choice)
  given_user = nil
  given_channel = nil
  until choice == "quit"
    if choice == "list users"
      tp workspace.users, "user name", "real_name", "slack_id"
      puts "\n"
    elsif choice == "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
    elsif choice == "select user"
      print "Please enter user name or user Slack ID: "
      user_info = gets.chomp
      given_user = workspace.select_user(user_info)
    elsif choice == "select channel"
      print "Please select channel name or channel Slack ID: "
      channel_info = gets.chomp
      given_channel = workspace.select_channel(channel_info)
    elsif choice == "details"
      if given_user != nil
        tp given_user.details
      elsif given_channel != nil
        tp given_channel.details
      else
        puts "No user or channel selected"
      end
    end

    puts "***\n"
    options_list
    choice = get_user_choice
  end
end

main if __FILE__ == $PROGRAM_NAME