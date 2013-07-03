module IsNamed
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    validates :name, presence: true
  end
end
