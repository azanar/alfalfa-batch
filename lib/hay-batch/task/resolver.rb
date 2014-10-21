require 'hay-batch/task/decorator'
require 'hay/task/resolvers'

module Hay
  module Task
    module Resolver
      class Task
        def initialize(task)
          @task = task
        end

        def build
          @task
        end
        Hay::Task::Resolvers.register(Hay::Batch::Task::Decorator, self)
      end
    end
  end
end

