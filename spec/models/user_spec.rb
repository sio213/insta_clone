require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'ユーザー名は必須であること' do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名を入力してください')
    end

    it 'ユーザー名は一意であること' do
      user = create(:user)
      same_name_user = build(:user, username: user.username)
      same_name_user.valid?
      expect(same_name_user.errors.full_messages).to include('ユーザー名はすでに存在します')
    end

    it 'メールアドレスは必須であること' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors.full_messages).to include('メールアドレスを入力してください')
    end

    it 'メールアドレスは一意であること' do
      user = create(:user)
      same_email_user = build(:user, email: user.email)
      same_email_user.valid?
      expect(same_email_user.errors.full_messages).to include('メールアドレスはすでに存在します')
    end
  end

  describe 'インスタンスメソッド' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:post_by_user_a) { create(:post, user: user_a) }
    let(:post_by_user_b) { create(:post, user: user_b) }

    describe 'own?' do
      context '自分のオブジェクトの場合' do
        it 'trueを返す' do
          expect(user_a.own?(post_by_user_a)).to be true
        end
      end

      context '自分のオブジェクトではない場合' do
        it 'falseを返す' do
          expect(user_a.own?(post_by_user_b)).to be false
        end
      end
    end

    describe 'like' do
      it 'いいねできること' do
        expect { user_a.like(post_by_user_b) }.to change { Like.count }.by(1)
      end
    end

    describe 'unlike' do
      it 'いいねを解除できること' do
        user_a.like(post_by_user_b)
        expect { user_a.unlike(post_by_user_b) }.to change { Like.count }.by(-1)
      end
    end

    describe 'follow' do
      it 'フォローできること' do
        expect { user_a.follow(user_b) }.to change { Relationship.count }.by(1)
      end
    end

    describe 'following?' do
      context 'フォローしている場合' do
        it 'trueを返す' do
          user_a.follow(user_b)
          expect(user_a.following?(user_b)).to be true
        end
      end

      context 'フォローしていない場合' do
        it 'falseを返す' do
          expect(user_a.following?(user_b)).to be false
        end
      end
    end
  end
end
