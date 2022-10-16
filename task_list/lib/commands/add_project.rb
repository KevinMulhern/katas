module Commands
  class AddProject

    def initialize(projects:, name:)
      @projects = projects
      @name = name
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      projects[name] = []
    end

    private

    attr_reader :projects, :name
  end
end
