require 'rails_helper'

describe "message" do
  describe '#create' do
    context '保存できる' do
      it "全てある場合" do
        message = build(:message)
        expect(message).to be_valid
      end
      it "画像だけがある" do
        message = build(:message, body: nil)
        expect(message).to be_valid
      end
      it "メッセージだけがある" do
        message = build(:message, image: nil)
        expect(message).to be_valid
      end
    end
    context '保存できない' do
      it "メッセージも画像もないと保存できない" do
        message = build(:message, image: "",body: "")
        message.valid?
        expect(message.errors[:body_image_present]).to include("を入力してください")
      end
      it "group_idがないと保存できない" do
        # binding.pry
        message = build(:message, group: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end
      it "user_idがないと保存できない" do
        message = build(:message, user: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end
