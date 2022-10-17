class ProjectList
  include Enumerable

  def initialize(projects = {})
    @projects = projects
  end

  def each(&block)
    @projects.each(&block)
  end

  def add(name)
    @projects[name] = []
  end

  def all
    @projects
  end

  def find(project)
    @projects[project]
  end

  def []=(key, value)
    @projects[key]= value
  end

  def [](key)
    @projects[key]
  end

  def find_task(id)
    @projects.collect do |_, tasks|
      tasks.find { |task| task.id == id }
    end.reject(&:nil?).first
  end


end
