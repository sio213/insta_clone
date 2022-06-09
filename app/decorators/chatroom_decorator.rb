class ChatroomDecorator < Draper::Decorator
  delegate_all

  def message_text
    messages.last&.body&.truncate(30) || 'まだメッセージがありません'
  end
end
