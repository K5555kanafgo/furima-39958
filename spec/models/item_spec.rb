require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報機能' do
    context '商品情報機能が登録できる' do
      it '全ての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end

      it 'タイトルが登録できる' do
        @item.title = "商品"
        expect(@item).to be_valid
      end

      it '説明が登録できる' do
        @item.explanation = "商品の説明"
        expect(@item).to be_valid
      end

      it '商品のカテゴリーが登録できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end

      it '商品の状態が登録できる' do
        @item.situation_id = 2
        expect(@item).to be_valid
      end

      it '配送料の負担が登録できる' do
        @item.load_id = 3
        expect(@item).to be_valid
      end

      it '都道府県が登録できる' do
        @item.prefecture_id = 3
        expect(@item).to be_valid
      end

      it '商品の日数が登録できる' do
        @item.number_of_day_id = 3
        expect(@item).to be_valid
      end

      it '価格が登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end

    end

    context '商品情報機能が登録できない' do
      it '画像が必須であること。' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      
      it '商品のタイトルが必須であること。' do
        @item.title = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '商品の説明が必須であること。' do
        @item.explanation = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it '商品のカテゴリーが必須であること。' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が必須であること。' do
        @item.situation_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Situation can't be blank")
      end

      it '配送料の負担が必須であること。' do
        @item.load_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Load can't be blank")
      end

      it '都道府県が必須であること。' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '商品の日数が必須であること。' do
        @item.number_of_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Number of day can't be blank")
      end

      it '価格が必須であること。' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

    context '商品情報機能が登録できない(詳細)' do
      it '価格が全角数字だと登録できない' do
        @item.price = "５０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number.")
      end

      it '価格が￥300未満だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end

      it '価格が￥9,999,999以上だと登録できない' do
        @item.price = 100000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end

      end
    end
  end









end