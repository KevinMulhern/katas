require 'date'

class Task
  attr_reader :id, :description, :deadline, :created_at

  def initialize(id:, description:, done:, deadline: nil, created_at: Date.today)
    @id = id
    @description = description
    @done = done
    @deadline = deadline
    @created_at = created_at
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
