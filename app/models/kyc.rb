class Kyc < ApplicationRecord
  belongs_to :user
  mount_uploader :identity_photo, KycUploader
  mount_uploader :address_photo, KycUploader

  attr_accessor :terms_accept

  validates_presence_of :identity_photo, :address_photo
  validates :terms_accept, acceptance: true
  validates :firstname, :lastname, :wallet, :country, :address_line_1, :state, :postal_code, :presence => true
  validates :wallet, :uniqueness => { :case_sensitive => false }
  validates_each :wallet do |record, attr, value|
    record.errors.add(attr, 'has wrong ETH address') if !(value.size==42 && value =~/^0x/)
  end
end