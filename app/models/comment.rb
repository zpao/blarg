class Comment < ActiveRecord::Base
  attr_accessor :is_human
  belongs_to :article
  validates_presence_of :name
  validates_presence_of :body
  validates_format_of :is_human, :with => /^#{BLARG_CONFIG['comments']['is_human_answer']}$/i
  validates_format_of :email, :with => /^[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Za-z]{2}|com|org|edu|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)$/
  validates_format_of :url, :with => /^$|^https?:\/\/.+/, :on => :create, :message => "is invalid"
  
  before_save :generate_html
  before_validation :check_author
  
  def generate_html
    # apply Markdown && Rubypants
    self.body_html = RubyPants.new(RedCloth.new(self.body).to_html).to_html
  end
  
  # save admin 3 seconds if already logged in.
  def check_author
    return unless self.is_author

    self.name     = BLARG_CONFIG['admin']['name']
    self.email    = BLARG_CONFIG['admin']['email']
    self.url      = BLARG_CONFIG['blog']['url']
    self.is_human = BLARG_CONFIG['comments']['is_human_answer']
  end
end
