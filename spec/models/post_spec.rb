# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  images     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    it '本文は必須であること' do
      post = build(:post, body: nil)
      post.valid?
      expect(post.errors.full_messages).to include('内容を入力してください')
    end

    describe '本文は1~1000文字の範囲であること' do
      context '0文字の場合'  do
        let(:chars) { '' }

        it 'エラーが出ること' do
          post = build(:post, body: chars)
          post.valid?
          expect(post.errors.full_messages).to include('内容を入力してください')
        end
      end

      context '1文字の場合' do
        let(:chars) { 'a' * 1 }

        it '有効であること' do
          post = build(:post, body: chars)
          expect(post.valid?).to eq true
        end
      end

      context '1000文字の場合' do
        let(:chars) { 'a' * 1000 }

        it '有効であること' do
          post = build(:post, body: chars)
          expect(post.valid?).to eq true
        end
      end

      context '1001文字の場合' do
        let(:chars) { 'a' * 1001 }

        it 'エラーが出ること' do
          post = build(:post, body: chars)
          post.valid?
          expect(post.errors.full_messages).to include('内容は1000文字以内で入力してください')
        end
      end
    end

    it '画像は必須であること' do
      post = build(:post, images: nil)
      post.valid?
      expect(post.errors.full_messages).to include('画像を入力してください')
    end

    it 'ユーザーは必須であること' do
      post = build(:post, user_id: nil)
      post.valid?
      expect(post.errors.full_messages).to include('ユーザーを入力してください')
    end
  end

  describe 'スコープ' do
    describe 'body_contain' do
      let!(:post) { create(:post, body: 'hello world!') }

      context 'キーワードが前方一致の場合' do
        let(:word) { 'hello' }
        subject { Post.body_contain(word) }
        it { is_expected.to include(post) }
      end

      context 'キーワードが単語中に含まれる場合' do
        let(:word) { 'wo' }
        subject { Post.body_contain(word) }
        it { is_expected.to include(post) }
      end

      context 'キーワードが後方一致の場合' do
        let(:word) { 'world' }
        subject { Post.body_contain(word) }
        it { is_expected.to include(post) }
      end

      context 'キーワードの一部が一致しない場合' do
        let(:word) { 'konnichiwa' }
        subject { Post.body_contain(word) }
        it { is_expected.not_to include(post) }
      end
    end
  end
end
