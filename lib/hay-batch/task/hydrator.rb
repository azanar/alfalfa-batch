require 'hay-batch/task/flow'

module Hay
  class Batch
    module Task
      class Hydrator
        def initialize(hash)
          @hash = hash
        end

        def hydrate
          task = Hay::Tasks.for(@hash['name']).new(@hash['task']).to_hay
          task.flow = Hay::Batch::Task::Flow.new(@hash['flow'])
          task
        end
      end
    end
  end
end
