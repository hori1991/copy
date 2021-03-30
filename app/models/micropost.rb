class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, length: { maximum: 120 }
  scope :recent_count, ->(count) { order(created_at: :desc).limit(count) }
  scope :recent, -> { order(id: :desc) }
  scope :current_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  scope :last_month, -> { where(created_at: Time.now.prev_month.beginning_of_month..Time.now.prev_month.end_of_month) }
  acts_as_taggable
end
