class Task
  attr_reader :id, :description

  def initialize(id, description, done)
    @id = id
    @description = description
    @done = done
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
end
