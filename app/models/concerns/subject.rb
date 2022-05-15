module Subject
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :subject, dependent: :destroy
    after_create_commit :create_activity
  end

  # NOTE: 実装必須メソッドは、オーバーライドされなかった場合NotImplementedErrorでエラーが出るようにする
  private

  def create_activity
    raise NotImplementedError
  end
end
