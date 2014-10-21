require 'hay'

module Hay
  class Batch
    def initialize(params = {})
      @batch = params["batch"]
    end

    def dehydrate
      {"batch" => batch}
    end

    attr_reader :batch
  end
end

