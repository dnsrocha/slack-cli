require_relative 'channel.rb'
require_relative 'user.rb'

class Workspace

  attr_reader :users, :channels

  def Initialize
    @users = User.load_all
    @channels= []
  end

  def select_user(user)
    raise NotImplementedError
  end

  def select_channel(channel)
    raise NotImplementedError

  end


end