require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do 
    context "ユーザー情報登録できないとき" do
      it 'ニックネームが必須であること。' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
  
      it 'メールアドレスが必須であること。' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
  
      it 'メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
  
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = "testmail"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
  
      it 'パスワードが必須であること。' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
  
      it 'パスワードが6文字以上での入力が必須であること' do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
  
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = "444444", "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
  
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context "ユーザー本人情報確認登録できないとき" do
      it 'お名前(全角)は、名字と名前がそれぞれ必須であること。' do
        @user.first_name = ""
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "Family name can't be blank")
      end

      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.read_family = "ﾔﾏ" 
        @user.read_first = "ﾘｮｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters",
          "Read family is invalid. Input full-width katakana characters")
      end

      it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。' do
        @user.read_first = ""
        @user.read_family = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first can't be blank", "Read family can't be blank")
      end

      it ' お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.read_family = "12345"
        @user.read_first = "12345"
        @user.valid?

        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters",
          "Read family is invalid. Input full-width katakana characters")
      end

      it '生年月日が必須であること。' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end













  end
end