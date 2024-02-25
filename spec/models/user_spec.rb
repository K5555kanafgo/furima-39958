require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー情報登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'パスワードが6文字以上で存在すれば登録できる' do
        @user.password = '00000k'
        @user.password_confirmation = '00000k'
        expect(@user).to be_valid
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password = 'ki60ik'
        @user.password_confirmation = 'ki60ik'
        expect(@user).to be_valid
      end

      it 'メールアドレスに＠が存在すれば登録できる。' do
        @user.email = 'test@test.com'
        expect(@user).to be_valid
      end

      it '名字（全角）が全角文字であるならば登録できる' do
        @user.first_name = 'かねだ'
        expect(@user).to be_valid
      end

      it '名前（全角）が全角文字であるならば登録できる' do
        @user.family_name = 'りん'
        expect(@user).to be_valid
      end

      it '名字（カナ）が半角文字であるならば登録できる' do
        @user.read_first = 'カネダ'
        expect(@user).to be_valid
      end

      it '名前（カナ）が半角文字であるならば登録できる' do
        @user.read_family = 'リン'
        expect(@user).to be_valid
      end

      it '誕生日が存在すれば登録できる' do
        @user.birthday = '1998-05-10'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー情報登録できないとき' do
      it 'ニックネームが必須であること。' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが必須であること。' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが必須であること。' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字以上での入力が必須であること' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは、半角英字のみでは登録できないこと' do
        @user.password = 'ssssss'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end

      it 'パスワードは、半角数字のみでは登録できないこと' do
        @user.password = '444444'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end

      it 'パスワードは、全角文字を含むパスワードでは登録できない' do
        @user.password = 'KSKKii'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context 'ユーザー本人情報確認登録できないとき' do
      it 'お名前(全角)は、名字がそれぞれ必須であること。' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前(全角)は、名前がそれぞれ必須であること。' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.read_family = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read family is invalid. Input full-width katakana characters')
      end

      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.read_first = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read first is invalid. Input full-width katakana characters')
      end

      it 'お名前カナ(全角)は、名字がそれぞれ必須であること。' do
        @user.read_family = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family can't be blank")
      end

      it 'お名前カナ(全角)は、名前がそれぞれ必須であること。' do
        @user.read_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first can't be blank")
      end

      it ' 名字カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.read_family = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read family is invalid. Input full-width katakana characters')
      end

      it ' 名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.read_first = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read first is invalid. Input full-width katakana characters')
      end

      it '生年月日が必須であること。' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it '名字（全角）に半角文字が含まれていると登録できない' do
        @user.family_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters")
      end

      it ' 名前（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end

      it '名字（カナ）にカタカナ以外の文字（平仮名）が含まれていると登録できない' do
        @user.read_family = 'にじゅうまんにせん' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid. Input full-width katakana characters")
      end

      it '名前（カナ）にカタカナ以外の文字（平仮名）が含まれていると登録できない' do
        @user.read_first = 'ごひゃくまんにじゅうご'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters")
      end

      it '名字（カナ）にカタカナ以外の文字（漢字）が含まれていると登録できない' do
        @user.read_family = '二十万二千' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid. Input full-width katakana characters")
      end

      it '名前（カナ）にカタカナ以外の文字（漢字）が含まれていると登録できない' do
        @user.read_first = '五百万二十五'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters")
      end

      it '名字（カナ）にカタカナ以外の文字（英数字）が含まれていると登録できない' do
        @user.read_family = 'nijuumann2000' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid. Input full-width katakana characters")
      end

      it '名前（カナ）にカタカナ以外の文字（英数字）が含まれていると登録できない' do
        @user.read_first = 'gohaykuman25'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters")
      end

      it '名字（カナ）にカタカナ以外の文字（記号）が含まれていると登録できない' do
        @user.read_family = '$$##&&' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid. Input full-width katakana characters")
      end

      it '名前（カナ）にカタカナ以外の文字（記号）が含まれていると登録できない' do 
        @user.read_first = '**<<=='
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters")
      end
    end
  end
end