require 'hay/task/template/task'
require 'hay-batch/task/decorator'

module Hay
  class Batch
    module Task
      class Template 
        Hay::Task::Templates.register(Hay::Batch::Task::Decorator, Hay::Task::Template::Task)
      end
    end
  end
end
