class Workspace

  attr_reader :users, :channels

  def Initialize
    @users = []
    @channels= []
  end

  def select_user(user)
    raise NotImplementedError
  end
end