require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品登録' do
    context '出品登録できる時' do
      it 'name, description, image, price, category_id, state_id, burden_id, prefecture_id, delivery_period_id, userが存在している' do
        expect(@item).to be_valid
      end
      it 'imageがjpgでも登録できる' do
        @item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
        expect(@item).to be_valid
      end
      it 'imageがjpegでも登録できる' do
        @item.image.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.jpeg')
        expect(@item).to be_valid
      end
    end

    context '出品登録できない時' do
      # name
      it 'nameが空' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      # /name

      # description
      it 'descriptionが空' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      # /description

      # image
      it 'imageが空' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image ファイルを添付してください')
      end
      it 'imageがjpeg/jpg/png以外だと登録できない' do
        @item.image.attach(io: File.open('public/images/test_image.pdf'), filename: 'test_image.pdf')
        @item.valid?
        expect(@item.errors.full_messages).to include('Image にはjpeg・png・jpgのファイルで添付してください')
      end
      # /image

      # price
      it 'priceが空' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceに全角文字列の場合登録できない' do
        @item.price = 'あ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceに半角文字列の場合登録できない' do
        @item.price = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが300以下の場合登録できない' do
        @item.price = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが10,000,000以上の場合登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      # /price

      # category_id
      it 'category_idが空' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end
      it 'category_idが1のまま' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      # /category_id

      # state_id
      it 'state_idが空' do
        @item.state_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('State is not a number')
      end
      it 'state_idが1のまま' do
        @item.state_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('State must be other than 1')
      end
      # /state_id

      # burden_id
      it 'burden_idが空' do
        @item.burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Burden is not a number')
      end
      it 'burden_idが1のまま' do
        @item.burden_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Burden must be other than 1')
      end
      # /burden_id

      # prefecture_id
      it 'prefecture_idが空' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture is not a number')
      end
      it 'prefecture_idが1のまま' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      # /prefecture_id

      # delivery_period_id
      it 'delivery_period_idが空' do
        @item.delivery_period_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery period is not a number')
      end
      it 'prefecture_idが1のまま' do
        @item.delivery_period_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery period must be other than 1')
      end
      # /delivery_period_id
    end
  end
end
