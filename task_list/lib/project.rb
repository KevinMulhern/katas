class Project
  attr_reader :name, :tasks

  def initialize(name, tasks = [])
    @name = name
    @tasks = tasks
  end
end
