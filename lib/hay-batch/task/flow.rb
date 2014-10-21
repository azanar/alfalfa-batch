require 'hay/task/flow'

module Hay
  class Batch
    module Task
      class Flow
        def initialize(params = {})
          @between = Hay::Task::Flow.new(params["between"] || [])
          @after = Hay::Task::Flow.new(params["after"] || [])
        end

        def dehydrate
          {
            "between" => @between.dehydrate,
            "after" => @after.dehydrate
          }
        end

        attr_reader :between
        attr_reader :after
      end
    end
  end
end
