class Article < ActiveRecord::Base
  
  validates_presence_of :permalink
  
  before_save :generate_html
  
  acts_as_taggable
  
  # alias_method :old_tag_names, :tag_names
  # def tag_names
  #   self.tag_names.join " "
  # end
  
  def self.find_published(limit = nil)
    self.find(:all, :limit => limit, :order => "published_at DESC", :conditions => {:published => true})
  end
  
  def self.find_published_and_sort(limit = nil)
    articles = self.find_published(limit)
    final_results = {}
    articles.collect do |article|
      y = article.published_at.strftime("%G").to_i
      m = article.published_at.strftime("%m").to_i
      final_results[y] ||= {}
      final_results[y][m] ||= []
      final_results[y][m] << article
    end
    final_results
  end
  
  def pretty_published_at
    published_at.strftime("%B %d, %G")
  end
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  def generate_html
    # apply Markdown && Rubypants
    self.blurb_html = RubyPants.new(RedCloth.new(self.blurb).to_html).to_html
    self.body_html  = RubyPants.new(RedCloth.new(self.body).to_html).to_html
  end
end
