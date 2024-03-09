require 'rails_helper'

RSpec.describe BuyerItemPurchase, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @buyer_item_purchase = FactoryBot.build(:buyer_item_purchase, user_id: @user.id, item_id: @item.id)
  end
  describe "配送情報の保存" do

    context "配送先情報に内容が問題ない場合" do
      it '全ての値が正しく入力され、保存ができること' do
        expect(@buyer_item_purchase).to be_valid
      end

      it '建物名が空でも保存できること' do
        @buyer_item_purchase.building_name = ""
        expect(@buyer_item_purchase).to be_valid
      end
    end

    context "配送先情報に内容が問題がある場合" do
      it '郵便番号が空だと保存ができないこと' do
        @buyer_item_purchase.post_code = ""
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Post code can't be blank")
      end

      it '都道府県が空だと保存ができないこと' do
        @buyer_item_purchase.prefecture_id = 0
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと保存ができないこと' do
        @buyer_item_purchase.town_name = ""
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Town name can't be blank")
      end

      it '番地が空だと保存ができないこと' do
        @buyer_item_purchase.number = ""
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Number can't be blank")
      end

      it '電話番号が空だと保存ができないこと' do
        @buyer_item_purchase.telephone_number = ""
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Telephone number can't be blank")
      end

      it 'ユーザーが紐づいていないと保存ができないこと' do
        @buyer_item_purchase.user_id = nil
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("User can't be blank")
      end

      it '商品出品名が紐づいていないと保存ができないこと' do
        @buyer_item_purchase.item_id = nil
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Item can't be blank")
      end

      it 'トークンが空だと保存ができないこと' do
        @buyer_item_purchase.token = nil
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
    
    context "配送先情報に内容が問題がある場合(詳細)" do
      it '郵便番号がハイフンを含んだ正しい形式でないと保存できないこと' do
        @buyer_item_purchase.post_code = "090123456789"
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '郵便番号が全角だと保存できないこと' do
        @buyer_item_purchase.post_code = "０９０-１２３４-６７８９"
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '電話番号が10桁以上11桁以内の半角数値のみでない保存ができないこと' do
        @buyer_item_purchase.telephone_number = "0901234567８９"
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Telephone number invalid. Input only number")
      end

      it '電話番号が9桁以下だと保存ができないこと' do
        @buyer_item_purchase.telephone_number = "090123456"
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Telephone number invalid. Input only number")
      end

      it '電話番号が全角数値だと保存ができないこと' do
        @buyer_item_purchase.telephone_number = "０９０１２３４５６７８"
        @buyer_item_purchase.valid?
        expect(@buyer_item_purchase.errors.full_messages).to include("Telephone number invalid. Input only number")
      end
    end
  end
end