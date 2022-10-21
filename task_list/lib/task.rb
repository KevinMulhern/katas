class Task
  attr_reader :id, :description, :deadline

  def initialize(id, description, done, deadline = nil)
    @id = id
    @description = description
    @done = done
    @deadline = deadline
  end

  def mark_done
    @done = true
  end

  def mark_undone
    @done = false
  end

  def done?
    @done
  end

  def add_deadline(deadline)
    @deadline = deadline
  end
end
