require 'rails_helper'

RSpec.describe OrderProcessing, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_processing = FactoryBot.build(:order_processing, user_id: @user.id, item_id: @item.id)
    sleep(0.001)
  end

  describe '購入手続き' do
    context '購入できる時' do
      it 'token, postal_code, prefecture_id, municipal, address, building_name, phone_number,user,itemが存在している' do
        expect(@order_processing).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @order_processing.building_name = ''
        expect(@order_processing).to be_valid
      end
      it 'phone_numberの桁が10桁でも登録できる' do
        @order_processing.phone_number = '0901234567'
        expect(@order_processing).to be_valid
      end
    end
    context '購入できない時' do
      # token
      it 'トークンが空' do
        @order_processing.token = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Token can't be blank")
      end
      # /token

      # postal_code
      it '郵便番号が空' do
        @order_processing.postal_code = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Postal code can't be blank",
                                                                  'Postal code is invalid. Include hyphen(-)')
      end
      it '郵便番号に-がない' do
        @order_processing.postal_code = '0000000'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '郵便番号が[3桁 - 4桁] ではない' do
        @order_processing.postal_code = '00-00000'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      # /postal_code

      # prefecture_id
      it '都道府県が空' do
        @order_processing.prefecture_id = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
      end
      it '都道府県が1' do
        @order_processing.prefecture_id = '1'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Prefecture must be other than 1')
      end
      # /prefecture_id

      # municipal
      it '市区町村が空' do
        @order_processing.municipal = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Municipal can't be blank")
      end
      # /municipal

      # address
      it '番地が空' do
        @order_processing.address = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Address can't be blank")
      end
      # /address

      # phone_number
      it 'phone_numberが空' do
        @order_processing.phone_number = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it 'phone_numberが全角数字' do
        @order_processing.phone_number = '０１２３４５６７８９'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが全角ひらがな' do
        @order_processing.phone_number = 'あいうえおかきくけこ'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが半角英字' do
        @order_processing.phone_number = 'a'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberに-が入っている' do
        @order_processing.phone_number = '090-1234-5678'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberの桁が10桁未満' do
        @order_processing.phone_number = '123456789'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberの桁が12桁以上' do
        @order_processing.phone_number = '123456789012'
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include('Phone number is invalid')
      end
      # /phone_number

      # user
      it 'ユーザーがnil' do
        @order_processing.user_id = nil
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("User can't be blank")
      end
      it 'ユーザーが空' do
        @order_processing.user_id = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("User can't be blank")
      end
      # /user

      # item
      it '商品がnil' do
        @order_processing.item_id = nil
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Item can't be blank")
      end
      it '商品が空' do
        @order_processing.item_id = ''
        @order_processing.valid?
        expect(@order_processing.errors.full_messages).to include("Item can't be blank")
      end
      # /item
    end
  end
end
