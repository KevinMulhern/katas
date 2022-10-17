require_relative 'Project'

class ProjectList
  include Enumerable

  def initialize(projects = [])
    @projects = projects
  end

  def each(&block)
    @projects.each(&block)
  end

  def add(name)
    @projects << Project.new(name)
  end

  def all
    @projects
  end

  def find(name)
    @projects.find { |project| project.name == name }
  end

  # def []=(key, value)
  #   @projects[key]= value
  # end

  # def [](key)
  #   @projects[key]
  # end

  def find_task(id)
    @projects.flat_map(&:tasks).find { |task| task.id == id }
  end


end
