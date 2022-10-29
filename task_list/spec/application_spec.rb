require 'rspec'
require 'stringio'
require 'timeout'

require_relative '../lib/task_list'

describe 'application' do
  PROMPT = '> '

  around :each do |example|
    @input_reader, @input_writer = IO.pipe
    @output_reader, @output_writer = IO.pipe

    application = TaskList.new(@input_reader, @output_writer)
    @application_thread = Thread.new do
      application.run
    end
    @application_thread.abort_on_exception = true

    example.run

    @input_reader.close
    @input_writer.close
    @output_reader.close
    @output_writer.close
  end

  after :each do
    next unless still_running?
    sleep 1
    next unless still_running?
    @application_thread.kill
    raise 'The application is still running.'
  end

  it 'works' do
    Timeout::timeout 1 do
      execute('view by project')

      execute('add project secrets')
      execute('add task secrets Eat more donuts.')
      execute('add task secrets Destroy all humans.')

      execute('view by project')
      read_lines(
        'secrets',
        '  [ ] 1: Eat more donuts.',
        '  [ ] 2: Destroy all humans.',
        ''
      )

      execute('add project training')
      execute('add task training Four Elements of Simple Design')
      execute('add task training SOLID')
      execute('add task training Coupling and Cohesion')
      execute('add task training Primitive Obsession')
      execute('add task training Outside-In TDD')
      execute('add task training Interaction-Driven Design')

      execute('check 1')
      execute('check 3')
      execute('check 5')
      execute('check 6')

      execute("deadline 6 #{Date.today.to_s}")
      execute("deadline 2 #{Date.today.to_s}")
      execute("deadline 4 #{(Date.today + 10).to_s}")
      execute("deadline 3 #{(Date.today + 20).to_s}")

      execute('view by deadline')
      read_lines(
          "#{Date.today.to_s}",
          '  [ ] 2: Destroy all humans.',
          '  [x] 6: Primitive Obsession',
          '',
          "#{(Date.today + 20).to_s}",
          '  [x] 3: Four Elements of Simple Design',
          '',
          "#{(Date.today + 10).to_s}",
          '  [ ] 4: SOLID',
          ''
      )

      execute("delete 8")

      execute('view by project')
      read_lines(
          'secrets',
          '  [x] 1: Eat more donuts.',
          '  [ ] 2: Destroy all humans.',
          '',
          'training',
          '  [x] 3: Four Elements of Simple Design',
          '  [ ] 4: SOLID',
          '  [x] 5: Coupling and Cohesion',
          '  [x] 6: Primitive Obsession',
          '  [ ] 7: Outside-In TDD',
          ''
      )

      execute('view by date')
      read_lines(
        "#{Date.today.to_s}",
          '  [x] 1: Eat more donuts.',
          '  [ ] 2: Destroy all humans.',
          '  [x] 3: Four Elements of Simple Design',
          '  [ ] 4: SOLID',
          '  [x] 5: Coupling and Cohesion',
          '  [x] 6: Primitive Obsession',
          '  [ ] 7: Outside-In TDD',
          ''
      )

      execute('today')
      read_lines(
        '[ ] 2: Destroy all humans.',
        '[x] 6: Primitive Obsession',
        ''
      )

      execute('amend id 7 A1')
      execute('view by project')
      read_lines(
        'secrets',
        '  [x] 1: Eat more donuts.',
        '  [ ] 2: Destroy all humans.',
        '',
        'training',
        '  [x] 3: Four Elements of Simple Design',
        '  [ ] 4: SOLID',
        '  [x] 5: Coupling and Cohesion',
        '  [x] 6: Primitive Obsession',
        '  [ ] A1: Outside-In TDD',
        ''
      )

      execute('add task training Tell dont ask')
      execute('add task training Law of Demeter')
      execute('view by project')
      read_lines(
        'secrets',
        '  [x] 1: Eat more donuts.',
        '  [ ] 2: Destroy all humans.',
        '',
        'training',
        '  [x] 3: Four Elements of Simple Design',
        '  [ ] 4: SOLID',
        '  [x] 5: Coupling and Cohesion',
        '  [x] 6: Primitive Obsession',
        '  [ ] A1: Outside-In TDD',
        '  [ ] A2: Tell dont ask',
        '  [ ] A3: Law of Demeter',
        ''
      )

      execute('quit')
    end
  end

  def execute(command)
    read PROMPT
    write command
  end

  def read(expected_output)
    actual_output = @output_reader.read(expected_output.length)
    expect(actual_output).to eq expected_output
  end

  def read_lines(*expected_output)
    expected_output.each do |line|
      read "#{line}\n"
    end
  end

  def write(input)
    @input_writer.puts input
  end

  def still_running?
    @application_thread && @application_thread.alive?
  end
end
