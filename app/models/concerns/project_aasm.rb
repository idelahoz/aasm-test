# app/models/concerns/project_aasm.rb
module ProjectAasm
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: 'status' do
      state :idea, initial: true
      state :planning
      state :development
      state :completed
      state :archived

      event :start_planning do
        transitions from: :idea, to: :planning
      end

      event :start_development do
        transitions from: :planning, to: :development
      end

      event :complete do
        transitions from: :development, to: :completed
      end

      event :archive do
        transitions from: [:completed, :development], to: :archived
      end

      event :reopen do
        transitions from: :archived, to: :planning
      end
    end
  end
end
