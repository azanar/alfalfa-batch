require File.expand_path('../../test_helper', __FILE__)

require 'hay-batch/task'
require 'hay-batch/task/resulter'

class Hay::Batch::TaskTest < Test::Unit::TestCase
  setup do
    @mock_task = Class.new do
      def self.task_name
        "mock_task"
      end

      def task_name
        self.class.task_name
      end

      def dehydrate
        {foo: :bar}
      end

      include Hay::Batch::Task

      def process(arg)
      end

    end

    @mock_flow = mock

    
    @t = @mock_task.new.to_hay
    @t.flow = @mock_flow
  end

  test 'process' do
    mock_dispatcher = mock
    mock_resulter = mock

    Hay::Batch::Task::Resulter.expects(:new).with(@mock_flow,mock_dispatcher).returns(mock_resulter)

    @t.process(mock_dispatcher)
  end

  test 'dehydrate' do
    mock_flow_dehydrate = mock

    @mock_flow.expects(:dehydrate).returns(mock_flow_dehydrate)

    dehydrated = @t.dehydrate

    assert_equal dehydrated["name"], "mock_task"
    assert_equal dehydrated["task"], {foo: :bar}
    assert_equal dehydrated["flow"], mock_flow_dehydrate
  end

  test 'no flow arg creates an empty flow' do
    t = @mock_task.new.to_hay
    
    f = t.flow
    
    assert_kind_of Hay::Batch::Task::Flow, f
  end
end
