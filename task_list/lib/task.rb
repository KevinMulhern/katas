require 'date'

class Task
  attr_reader :id, :description, :deadline
  attr_accessor :done

  def initialize(id, description, done)
    @id = id
    @description = description
    @done = done
    @deadline = Date.today
  end

  def done?
    done
  end

  def set_deadline(date)
    @deadline = Date.parse(date)
  end

  def to_s
    printf("  [%c] %d: %s\n", (done? ? 'x' : ' '), id, description)
  end
end
