class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  # Validations

  validates_presence_of :organization
  validates_presence_of :name

  # Associations

  has_many :issues
  accepts_nested_attributes_for :issues, allow_destroy: true

  # Class Methods

  def self.by_full_name(organization, name)
    Project.where(organization: organization, name: name).first
  end

end
