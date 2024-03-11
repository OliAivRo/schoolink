module CoursesHelper
  def course_icon(course_name)
    case course_name.downcase
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
