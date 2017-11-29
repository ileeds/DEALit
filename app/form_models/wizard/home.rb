module Wizard
  module Home
    STEPS = %w(step1 step2 step3 step4).freeze

    class Base
      include ActiveModel::Model
      attr_accessor :home

      delegate *::Home.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :home

      def initialize(home_attributes)
        @home = ::Home.new(home_attributes)
      end
    end

    class Step1 < Base
      validates :address, presence: true
      validates :description, length: { minimum: 10, maximum: 1400 }, presence: true
      validates :price, presence: true, numericality: true
      validates :size, presence: true
    end

    class Step2 < Step1
      validates :start_date, presence: true
      validates :end_date, presence: true
      validate :dates_cannot_be_in_the_past, :start_date_before_end_date

      def dates_cannot_be_in_the_past
        today = Date.today
        if start_date < today
          errors.add(:start_date, "can't be in the past")
        end
        if end_date < today
          errors.add(:end_date, "can't be in the past")
        end
      end

      def start_date_before_end_date
        if end_date < start_date
          errors.add(:end_date, "cannot be before Start date")
        end
      end
    end

    class Step3 < Step2
      validates :available_rooms, numericality: true, allow_nil: true
      validates :total_bathrooms, numericality: true, allow_nil: true
      validates :private_bathrooms, numericality: true, allow_nil: true
      validates :is_furnished, inclusion: { in: [ true, false ] }
    end

    class Step4 < Step3
      
    end
  end
end
