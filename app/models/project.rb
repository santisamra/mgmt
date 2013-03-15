class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  # Validations

  validates_presence_of :organization
  validates_presence_of :name

  # Associations

  has_many :issues
  accepts_nested_attributes_for :issues, allow_destroy: true

end
