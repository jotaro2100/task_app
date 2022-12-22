class Schedule < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :date_check

  def date_check
    unless start_date <= end_date
      errors.add(:end_date, 'は開始日より前の日付で登録できません')
    end
  end
end
