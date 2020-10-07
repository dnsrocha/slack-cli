#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'

require_relative 'workspace.rb'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  options_list
  choice = get_user_input

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

def options_list
  print "Choose from the following:\n"
  puts "list users\nlist channels\nquit"
end

def get_user_input
  user_choice = gets.chomp
  options = ["list users", "list channels", "quit"]

  unless options.include?(user_choice)
    puts "Invalid option. Please type: list users, list channels, or quit"
    user_choice = gets.chomp
  end
  return user_choice
end

def execute_choice(workspace, choice)
  #if choice is list users, show a list of all users in slack workspace (username, real name, slack id)
  # if choice is list channels, show a list of all channel in slack workspace (channels name, topic, member county, slack id)
  # if choice is quit, program will exit
  # program has to run unless choice is quit



end

main if __FILE__ == $PROGRAM_NAME