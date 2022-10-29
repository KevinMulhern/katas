require 'shellwords'
require_relative 'amend/id'

module Commands
  class Amend

    def initialize(output:, projects:, params:)
      @output = output
      @projects = projects
      @params = Shellwords.split(params)
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      if amend_id?
        Id.execute(
          projects: projects,
          old_id: old_id,
          new_id: new_id,
          output: output
        )
      end
    end

    private

    attr_reader :output, :projects, :params

    def amend_id?
      params.first == 'id'
    end

    def old_id
      params[1]
    end

    def new_id
      params.last
    end

  end
end
