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
  puts "list users\nlist channels\nquit"
end

def get_user_choice
  user_choice = gets.chomp
  options = ["list users", "list channels", "quit"]

  until options.include?(user_choice)
    puts "Invalid option. Please type: list users, list channels, or quit"
    user_choice = gets.chomp
  end

  return user_choice
end

def execute_choice(workspace, choice)
  until choice == "quit"
    if choice == "list users"
      tp workspace.users "username", "real_name", "slack_id"
      puts "\n"
    elsif choice == "list channels"
      tp workspace.channels "name", "topic", "member_count", "slack_id"
    end
  end
end

main if __FILE__ == $PROGRAM_NAME