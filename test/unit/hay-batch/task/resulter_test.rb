require File.expand_path('../../../test_helper', __FILE__)

require 'hay-batch/task/resulter'

class Hay::Batch::Task::ResulterTest < Test::Unit::TestCase
  setup do
    @mock_batch_flow = mock
    @mock_flow = mock
    @mock_router = mock

    @mock_tasks = 5.times.map { mock }

    @mock_tasks.each {|t|
      @mock_router.expects(:push).with(t)
    }

    @resulter = Hay::Batch::Task::Resulter.new(@mock_batch_flow, @mock_router)
  end

  test 'submit' do
    mock_data = mock

    mock_merged_data = mock
    mock_data.expects(:merge).with("batch" => 0).returns(mock_merged_data)

    @mock_batch_flow.expects(:between).returns(@mock_flow)

    mock_hydrator = mock
    mock_hydrator.expects(:hydrate_with).with(mock_merged_data).returns(@mock_tasks)

    Hay::Task::Template::Hydrator.expects(:new).returns(mock_hydrator)

    @resulter.submit(mock_data)
  end

  test 'done' do
    @mock_batch_flow.expects(:after).returns(@mock_flow)

    mock_payload = mock

    mock_merged_payload = mock
    mock_payload.expects(:merge).with("batches" => 0).returns(mock_merged_payload)

    mock_hydrator = mock
    mock_hydrator.expects(:hydrate_with).with(mock_merged_payload).returns(@mock_tasks)

    Hay::Task::Template::Hydrator.expects(:new).returns(mock_hydrator)


    @resulter.done(mock_payload)
  end
end
