require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  describe 'ユーザー登録' do
    context '入力情報が正しい場合' do
      it 'ユーザー登録ができること' do
        visit new_user_registration_path
        fill_in 'ユーザー名', with: 'test user'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button 'Sign up'

        expect(current_path).to eq posts_path
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end

    context '入力情報に誤りがある場合' do
      it 'ユーザー登録に失敗すること' do
        visit new_user_registration_path
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: ''
        click_button 'Sign up'

        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end
  end

  describe 'フォロー' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    before do
      sign_in(user)
    end

    it 'フォローができること' do
      visit posts_path
      expect {
        within "#follow-area-#{other_user.id}" do
          click_link 'フォロー'
          expect(page).to have_content 'フォロー解除'
        end
      }.to change(user.following_users, :count).by(1)
    end

    it 'フォローを外せること' do
      user.follow(other_user)
      visit posts_path
      expect {
        within "#follow-area-#{other_user.id}" do
          click_link 'フォロー解除'
          expect(page).to have_content 'フォロー'
        end
      }.to change(user.following_users, :count).by(-1)
    end
  end
end
