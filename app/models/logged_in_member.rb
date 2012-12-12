class LoggedInMember

  def self.current
    Thread.current[:member]
  end
  def self.current=(member)
    Thread.current[:member] = member
  end

end
