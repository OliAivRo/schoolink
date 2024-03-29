class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard

    # Group grades by course
    @grades_by_course = current_user.student.grades.group_by(&:course)

    # Calculate averages of each course
    @averages_by_course = {}
    @grades_by_course.each do |course, grades|
      total_grades = grades.length
      total_points = grades.reduce(0) { |sum, grade| sum + grade.grade }
      average_grade = (total_points / total_grades.to_f).round(1)
      formatted_average_grade = sprintf("%.1f", average_grade)
      @averages_by_course[course] = average_grade
    end

    # Calculate averages of course entire class
    @courses = current_user.student.courses
    @grades_by_courses = {}

    @courses.each do |course|
      grades = Grade.where(course: course)
      course_average = grades.average(:grade).round(1)
      formatted_course_grade = sprintf("%.1f", course_average)
      @grades_by_courses[course] = course_average
    end

    # Colors for courses
    colors = {
    "french" => "#FFADAD",
    "english" => "#FFD6A5",
    "german" => "#FDFFB6",
    "maths" => "#9BF6FF",
    "physics" => "#A0C4FF",
    "biology" => "#d0f4de",
    "chemistry" => "#ffccd5",
    "it" => "#C9E4DE",
    "sport" => "#FAEDCB",
    "geography" => "#a5ffd6",
    "history" => "#8093f1",
    "economy" => "#bfbee9",
    "music" => "#eac4d5",
    "philosophy" => "#affdd6",
    "civic_education" => "#fbf8cc"
    }

    # Create array for piechart
    @grades_for_charts = @averages_by_course.map do |course, avg_student|
      {
        section: course.name,
        avg_student: sprintf("%.1f", avg_student),
        avg_class: sprintf("%.1f", @grades_by_courses[course]),
        color: colors[course.name.downcase.gsub(' ', '-')]
      }
    end

  end

  def teacher_dashboard
    @sections = current_user.sections
    @courses = Course.includes(:section).where(teacher_id: current_user.id)
    @notifications = [
      "#{rand(1..100)}% of homeworks returned",
      "Student project due Friday",
      "Presentations tomorrow, prepare accordingly",
     " Discuss behavior problem after class",
      "Progress reports ready for distribution",
      "Tutoring room 203.",
      "Display artwork in hallway",
      "Council elections",
      "Mentoring program seeking volunteers",
      "Distribute project guidelines",
     " Dress code reminder: No hats in class",
      "Achievement celebration assembly",
    ]
    @todos = [
      { title: "Emergency drill this morning", done: true },
      { title: "Tech maintenance this afternoon", done: false },
      { title: "Congrats Science Olympiad team!", done: true },
      { title: "Parking lot construction ongoing", done: false },
      { title: "Teacher of the Year nominations due", done: false }
    ]
  end
end
