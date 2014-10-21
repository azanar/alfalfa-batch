require 'delegate'

require 'hay-batch/task/flow'
require 'hay-batch/task/resulter'

module Hay
  class Batch
    module Task
      class Decorator < SimpleDelegator 
        def initialize(obj)
          super
        end

        attr_writer :flow

        def flow
          @flow ||= Hay::Batch::Task::Flow.new
        end

        def dehydrate
          {
            "name" => task_name,
            "task" => super,
            "flow" => flow.dehydrate
          }
        end

        def process(dispatcher)
          resulter = Hay::Batch::Task::Resulter.new(flow, dispatcher)
          super(resulter)
        end
      end
    end
  end
end
