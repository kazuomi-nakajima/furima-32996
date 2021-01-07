require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'email, nickname, first_name, last_name, furigana_first_name, furigana_last_name, birth_date,password, password_confirmationが存在している' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      # 以下 nickname
      it 'nicknameが空' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      # 以上 nickname

      # 以下 email
      it 'emailが空' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが@を含まない' do
        @user.email = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'emailが既に登録されている(重複)' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      # 以上 email

      # 以下 password,password_confirmation
      it 'passwordが空' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが数字のみ' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password パスワードは、半角英字と半角数字を記入してください')
      end
      it 'passwordが半角英字のみ' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password パスワードは、半角英字と半角数字を記入してください')
      end
      it 'passwordに全角が含まれる' do
        @user.password = 'a1ああああ'
        @user.password_confirmation = 'a1ああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password パスワードは、半角英字と半角数字を記入してください')
      end
      it 'passwordに全角特殊文字が含まれる' do
        @user.password = 'a1####'
        @user.password_confirmation = 'a1####'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password パスワードは、半角英字と半角数字を記入してください')
      end
      it 'password_confirmationが空' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しない' do
        @user.password_confirmation = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      # 以上 password,password_confirmation

      # 以下 first_name
      it 'first_nameが空' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "First name can't be blank",
          'First name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      it 'first_nameに半角数字が含まれる' do
        @user.first_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'First name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      it 'first_nameに半角英字が含まれる' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'First name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      it 'first_nameに特殊英字が含まれる' do
        @user.first_name = '#'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'First name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      # 以上 first_name

      # 以下 last_name
      it 'last_nameが空' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "Last name can't be blank",
          'Last name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      it 'lsat_nameに半角数字が含まれる' do
        @user.last_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Last name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      it 'last_nameに半角英字が含まれる' do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Last name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      it 'first_nameに特殊英字が含まれる' do
        @user.last_name = '#'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Last name お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
        )
      end
      # 以上 last_name

      # 以下 furigana_first_name
      it 'furigana_first_nameが空' do
        @user.furigana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "Furigana first name can't be blank",
          'Furigana first name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_first_nameに半角が含まれる' do
        @user.furigana_first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana first name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_first_nameに全角ひらがなが含まれる' do
        @user.furigana_first_name = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana first name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_first_nameに全角漢字が含まれる' do
        @user.furigana_first_name = '亜'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana first name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_first_nameに特殊文字が含まれる' do
        @user.furigana_first_name = '#'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana first name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      # 以上 furigana_first_name

      # 以下 furigana_last_name
      it 'furigana_last_nameが空' do
        @user.furigana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "Furigana last name can't be blank",
          'Furigana last name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_last_nameに半角が含まれる' do
        @user.furigana_last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana last name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_last_nameに全角ひらがなが含まれる' do
        @user.furigana_last_name = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana last name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_last_nameに全角漢字が含まれる' do
        @user.furigana_last_name = '亜'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana last name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      it 'furigana_last_nameに特殊文字が含まれる' do
        @user.furigana_last_name = '#'
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Furigana last name お名前カナ(全角)は、全角カタカナで入力してください'
        )
      end
      # 以上 furigana_last_name

      # 以下 birth_date
      it 'birth_dateが空' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      # 以上 birth_date
    end
  end
end
