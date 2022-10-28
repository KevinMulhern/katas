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

  def find_task(id)
    @projects.flat_map(&:tasks).find { |task| task.id == id }
  end

  def tasks_with_deadline(date)
    @projects.flat_map(&:tasks).select { |task| task.deadline == date }
  end

  def deadlines
    @projects.flat_map(&:tasks).map(&:deadline).compact.uniq
  end

  def delete_task(task)
    @projects.each do |project|
      project.tasks.delete(task)
    end
  end
end
