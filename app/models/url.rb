class Url < ActiveRecord::Base
  has_many :visits

  validates :full_url, presence: true
  validates :slug, uniqueness: true
  validates :full_url, url: true

  before_save :generate_slug
  before_save :grab_title

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(4)
  end

  def grab_title
    self.title = TitleGrabber.find_title(full_url)
  end
end
