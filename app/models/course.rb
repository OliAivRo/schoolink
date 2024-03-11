class Course < ApplicationRecord
  belongs_to :section
  belongs_to :teacher

  validates :name, presence: true

  def icon
    case self.name.downcase
    when "french"
      "fas fa-comments"
    when "english"
      "fas fa-comment-dots"
    when "german"
      "fas fa-comments"
    when "maths"
      "fas fa-square-root-alt"
    when "physics"
      "fas fa-atom"
    when "biology"
      "fas fa-dna"
    when "chemistry"
      "fas fa-vials"
    when "it"
      "fas fa-laptop-code"
    when "sport"
      "fas fa-football-ball"
    when "geography"
      "fas fa-globe-americas"
    when "history"
      "fas fa-landmark"
    when "economy"
      "fas fa-chart-line"
    when "music"
      "fas fa-music"
    when "philosophy"
      "fas fa-brain"
    when "civic education"
      "fas fa-balance-scale"
    else
      "fas fa-book-open"
    end
  end
end
