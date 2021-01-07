class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :items
  # has_many :oeders

  validates :email, uniqueness: true, presence: true, uniqueness: { case_sensitive: true } # 一意性かつ入力必須
  validates_presence_of :nickname, :birth_date

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)\w{6,100}\z/.freeze # 英数字1文字以上かつ、6-100文字(入力は大文字、小文字、数字)
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze # 全角ひらがな、カタカナ、漢字
  VALID_FURIGANA_NAME_REGEX = /\A[ァ-ヶー－]+\z/.freeze # 全角カタカナ

  validates :password, presence: true, format: {
    with: VALID_PASSWORD_REGEX,
    message: 'パスワードは、半角英字と半角数字を記入してください'
  }
  validates :first_name, presence: true, format: {
    with: VALID_NAME_REGEX,
    message: 'お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
  }
  validates :last_name, presence: true, format: {
    with: VALID_NAME_REGEX,
    message: 'お名前(全角)は、全角ひらがな、カタカナ、漢字で入力してください'
  }
  validates :furigana_first_name, presence: true, format: {
    with: VALID_FURIGANA_NAME_REGEX,
    message: 'お名前カナ(全角)は、全角カタカナで入力してください'
  }
  validates :furigana_last_name, presence: true, format: {
    with: VALID_FURIGANA_NAME_REGEX,
    message: 'お名前カナ(全角)は、全角カタカナで入力してください'
  }
end