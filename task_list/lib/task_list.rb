require_relative 'task'

class TaskList
  QUIT = 'quit'

  def initialize(input, output)
    @input = input
    @output = output

    @tasks = {}
  end

  def run
    while true
      @output.print('> ')
      @output.flush

      command = @input.readline.strip
      break if command == QUIT

      execute(command)
    end
  end

private

  def execute(command_line)
    command, rest = command_line.split(/ /, 2)
    case command
    when 'show'
      show
    when 'add'
      add rest
    when 'check'
      check rest
    when 'uncheck'
      uncheck rest
    when 'help'
      help
    when 'deadline'
      deadline rest
    when 'today'
      today
    else
      error command
    end
  end

  def show
    @tasks.each do |project_name, project_tasks|
      @output.puts project_name
      project_tasks.each do |task|
        @output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
      end
      @output.puts
    end
  end

  def add(command_line)
    subcommand, rest = command_line.split(/ /, 2)
    if subcommand == 'project'
      add_project rest
    elsif subcommand == 'task'
      project, description = rest.split(/ /, 2)
      add_task project, description
    end
  end

  def add_project(name)
    @tasks[name] = []
  end

  def add_task(project, description)
    project_tasks = @tasks[project]
    if project_tasks.nil?
      @output.printf("Could not find a project with the name \"%s\".\n", project)
      return
    end
    project_tasks << Task.new(next_id, description, false)
  end

  def check(id_string)
    set_done(id_string, true)
  end

  def uncheck(id_string)
    set_done(id_string, false)
  end

  def set_done(id_string, done)
    id = id_string.to_i
    task = find_task(id)

    task.done = done
  end

  def help
    @output.puts('Commands:')
    @output.puts('  show')
    @output.puts('  add project <project name>')
    @output.puts('  add task <project name> <task description>')
    @output.puts('  check <task ID>')
    @output.puts('  uncheck <task ID>')
    @output.puts()
  end

  def deadline(command_line)
    id_string, deadline = command_line.split(/ /, 2)
    id = id_string.to_i
    task = find_task(id)

    task.set_deadline(deadline)
  end

  def today
    tasks = find_tasks_by(:deadline, Date.today)
    p tasks.size
    if tasks.empty?
      @output.puts 'No tasks due today.'
    else
      @output.puts 'Tasks due today:'
      tasks.each do |task|
        @output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
      end
    end
  end

  def find_task(id)
    task = find_tasks_by(:id, id).first

    if task.nil?
      @output.printf("Could not find a task with an ID of %d.\n", id)
      return
    else
      task
    end
  end

  def find_tasks_by(field, value)
    tasks = @tasks.collect do |project_name, project_tasks|
      project_tasks.find { |t| t.public_send(field.to_sym) == value }
    end.reject(&:nil?)


    if tasks.empty?
      @output.printf("Could not find any tasks with a %s of \"%s\".\n", field, value)
      return
    else
      tasks
    end
  end

  def error(command)
    @output.printf("I don't know what the command \"%s\" is.\n", command)
  end

  def next_id
    @last_id ||= 0
    @last_id += 1
    @last_id
  end
end

if __FILE__ == $0
  TaskList.new($stdin, $stdout).run
end


<%= title("All Paths") %>

<div class="bg-gray-100">
<div class="odin-container">
  <h1 class="page-heading-title">All Paths</h1>

  <%= render CardComponent.new do |card| %>
    <% card.header(classes: "flex justify-between items-center flex-col sm:flex-row space-y-4 sm:space-y-0 ") do %>
      <div class="flex w-full items-center justify-between">
        <div class="flex flex-col space-y-5 sm:space-x-6 sm:space-y-0 sm:flex-row justify-between items-center">
          <%= image_tag PATH_BADGES.fetch(@default_path.title), alt: "#{@default_path.title} badge", class: 'w-24 h-24' %>
          <div class="flex items-center flex-col sm:block">
            <h3 class="text-1xl mb-1 text-gold-600">PREREQUISITE PATH</h3>
            <h2 class="text-3xl font-semibold">Foundations</h2>
          </div>
        </div>

        <% if user_signed_in? %>
           <%= render Paths::SelectButtonComponent.new(current_user: current_user, path: @default_path, classes: "px-16 py-3")%>
        <% else %>
          <%= button_to path_url(@default_path), method: :get, class: 'top-btn top-btn-secondary px-20 py-3 text-lg'  do %>
            Preview
          <% end %>
        <% end %>
      </div>
    <% end %>

    <% card.body do %>
      <p class="text-gray-700 leading-normal text-base"><%= @default_path.description %></p>
    <% end %>

     <% card.footer do |card| %>

      <% end %>


  <% end %>

  <div class="relative mb-10 mt-10">
    <div class="absolute inset-0 flex items-center" aria-hidden="true">
      <div class="w-full border-t border-gray-300"></div>
    </div>
    <div class="relative flex justify-center">
      <span class="px-3 bg-gray-100 text-2xl font-semibold text-gray-900"> Then choose a learning path: </span>
    </div>
  </div>

  <div class="flex gap-x-10 gap-y-6 flex-col md:flex-row">
    <% @paths.each do |path| %>

      <%= render CardComponent.new do |card| %>
        <% card.header(classes: "flex flex-col justify-between items-center") do %>
          <div>
            <%= image_tag PATH_BADGES.fetch(path.title), alt: "#{path.title} badge", class: 'w-28 h-28' %>
          </div>

          <div class="w-full flex justify-between pt-6">
            <p class="text-lg text-gold-600">PATH</p>
            <p class="text-lg text-gray-500"><%= path.courses.size %> Courses</p>
          </div>
        <% end %>

        <% card.body do %>
          <div class="md:h-52">
            <h2 class="text-2xl font-semibold pb-4"><%= path.title %></h2>
            <p class="text-gray-700 leading-normal text-base"><%= path.description %></p>
          </div>
        <% end %>

        <% card.footer do %>
          <div class="flex space-x-6 justify-center items-center">

            <%= button_to path_url(path), method: :get, class: 'top-btn top-btn-secondary px-20 text-lg py-3'  do %>
              Preview
            <% end %>
            <%= render Paths::SelectButtonComponent.new(current_user: current_user, path: path, classes: 'px-16 md:px-10 py-3 w-full')%>
          </div>
        <% end %>
      <% end %>
    <% end%>
  </div>
</div>
</div>


# paths/select_button_component
module Paths
  class SelectButtonComponent < ViewComponent::Base
    def initialize(current_user:, path:, classes: "")
      @current_user = current_user
      @path = path
      @classes = classes
    end

    def render?
      current_user.present?
    end

    def selected_path?
      current_user.path == path
    end

    private

    attr_reader :current_user, :path, :classes
  end
end



<% if selected_path? %>
  <%= button_to path_url(path), method: :get, class: "top-btn top-btn-primary #{classes}" do %>
    Resume
  <% end %>
<% else %>
  <%= button_to users_paths_path(path_id: path.id), class: "top-btn top-btn-primary #{classes}" do %>
    Select
  <% end %>
<% end %>

PATH_BADGES = {
  'Foundations' => 'badge-foundations.svg',
  'Full Stack Ruby on Rails' => 'badge-ruby-on-rails.svg',
  'Full Stack JavaScript' => 'badge-javascript.svg',
}
