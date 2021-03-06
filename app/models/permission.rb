class Permission < ActiveRecord::Base
  has_many :permission_roles, dependent: :destroy
  has_many :roles, through: :permission_roles

  validates :subject_class, :action, presence: true
  validates :subject_class, uniqueness: { scope: :action }


  def to_s
    %(#{action}#{subject_class})
  end
end
