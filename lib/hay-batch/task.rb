require 'hay-batch/task/decorator'
require 'hay-batch/task/resolver'
require 'hay-batch/task/hydrator'
require 'hay-batch/task/template'

require 'hay/task/hydrators'
require 'hay/tasks'

module Hay
  class Batch
    module Task
      def self.included(base)
        Hay::Tasks.register(base)
        Hay::Task::Hydrators.register(base, Hay::Batch::Task::Hydrator)
      end

      def task_name
        self.class.task_name
      end

      def to_hay
        Hay::Batch::Task::Decorator.new(self)
      end
    end
  end
end
