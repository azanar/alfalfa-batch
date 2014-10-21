require 'hay/task/template/hydrator'

module Hay
  class Batch
    module Task
      class Resulter
        def initialize(flow, dispatcher)
          @dispatcher = dispatcher
          @flow = flow
          @batches = 0
        end

        def inject(task)
          @dispatcher.push(task)
        end

        def submit(data)
          tasks = between_hydrator.hydrate_with(data.merge("batch" => @batches))
          tasks.each do |task|
            @dispatcher.push(task)
          end
          @batches += 1
        end

        def done(data)
          tasks = after_hydrator.hydrate_with(data.merge("batches" => @batches))
          tasks.each do |task|
            @dispatcher.push(task)
          end
        end

        private

        def between_hydrator
          @between_hydrator ||= Hay::Task::Template::Hydrator.new(@flow.between)
        end

        def after_hydrator
          @after_hydrator ||= Hay::Task::Template::Hydrator.new(@flow.after)
        end
      end
    end
  end
end
