class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  has_one :address
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address

  validates :kind, presence: true
  validates :name, presence: true
  validates :email, presence: true

  def as_json(options = {})
    hash = super(options)
    hash.delete("birthdate")
    hash[:birthdate] = self.birthdate.nil? ? nil : I18n.l(self.birthdate)
    hash
  end

  # def birthdate_formatted
  #   self.birthdate.strftime("%d/%m/%Y") unless self.birthdate.nil?
  # end

  # def to_br
  #   {
  #     name: self.name,
  #     email: self.email,
  #     birthdate: self.birthdate_formatted,
  #     kind: self.kind.description
  #   }
  # end
end
