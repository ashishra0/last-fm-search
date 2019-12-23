require 'rails_helper'

RSpec.describe SearchHistoryStoreJob, type: :job do
  include ActiveJob::TestHelper

  describe 'perform job' do
    let(:user) { FactoryBot.create(:user) }

    subject(:job) { described_class.perform_later(user.id, 'dire straits') }

    it "queues the job" do
      expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it "matches with enqueued job" do
      expect { described_class.perform_later }.to have_enqueued_job(described_class)
    end

    it "is in default queue" do
      expect(described_class.new.queue_name).to eq('default')
    end

    it "executes perform" do
      perform_enqueued_jobs { job }
      expect(SearchHistory.count).to eq 1
    end
  end
end
