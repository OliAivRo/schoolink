class CommunicationsController < ApplicationController
  before_action :set_recipients, only: [:new, :create]

  def index
    @sent_communications = current_user.sent_communications.includes(:receiver)
    @received_communications = current_user.received_communications.includes(:sender)
  end

  def new
    @communication = Communication.new
  end

  def create
    @communication = current_user.sent_communications.build(communication_params)
    if @communication.save
      redirect_to communications_path, notice: 'Your message was successfully sent.'
    else
      render :new
    end
  end

  private

  def set_recipients
    @recipients = if current_user.type == "Teacher"
                    # Trouver les ID des sections enseignées par cet enseignant
                    section_ids = current_user.courses.pluck(:section_id).uniq
                    # Trouver les parents des élèves dans ces sections
                    User.where(type: 'Parent', section_id: section_ids)
                  elsif current_user.type == "Parent"
                    # Récupérer les sections des enfants du parent
                    section_ids = current_user.students.pluck(:section_id).uniq
                    # Trouver les enseignants associés à ces sections
                    @recipients = User.joins(courses: :section).where(courses: { section_id: section_ids }, type: 'Teacher').distinct
                  end
  end

  def communication_params
    params.require(:communication).permit(:receiver_id, :body)
  end
end
