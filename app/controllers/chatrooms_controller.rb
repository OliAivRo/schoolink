class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :check_access, only: [:show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
    @chatroom.messages.where.not(user_id: current_user.id).update_all(read: true)
  end

  def index
    @contacts_with_unread_messages = []

    if current_user.type == "Teacher"
      current_user.chatrooms.includes(:parent, :messages).each do |chatroom|
        unread_messages_count = chatroom.messages.where.not(user: current_user).where(read: false).count
        @contacts_with_unread_messages << {
          chatroom: chatroom,
          contact: chatroom.parent,
          unread_messages_count: unread_messages_count
        }
      end
    elsif current_user.type == "Parent"
      current_user.chatrooms.includes(:teacher, :messages).each do |chatroom|
        unread_messages_count = chatroom.messages.where.not(user: current_user).where(read: false).count
        @contacts_with_unread_messages << {
          chatroom: chatroom,
          contact: chatroom.teacher,
          unread_messages_count: unread_messages_count
        }
      end
    end
  end


  def find_or_create
    teacher_id = params[:teacher_id]
    parent_id = params[:parent_id] || current_user.id

    chatroom = Chatroom.find_or_create_by(teacher_id: teacher_id, parent_id: parent_id)
    redirect_to chatroom
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def check_access
    unless current_user == @chatroom.parent || current_user == @chatroom.teacher
      redirect_to chatrooms_path, alert: "Vous n'avez pas l'accès à cette chatroom."
    end
  end
end
