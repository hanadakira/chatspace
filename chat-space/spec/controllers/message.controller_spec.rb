require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET #index' do
    before do
      login_user user
      get :index, params:{ group_id: group.id }
    end

    context 'ログインしている場合' do
      it "@group" do
        groups = user.groups
        expect(assigns(:group)).to eq group
      end

      it "@groups" do
        groups = user.groups.order('id DESC')
        expect(assigns(:groups)).to eq groups
      end

      it "@messages" do
        messages = create_list(:message, 3,group_id: group.id, user_id: user.id)
        expect(assigns(:messages)).to match(messages.sort{ |a, b| b.created_at <=> a.created_at})
      end

      it "indexのビューが表示されるか" do
        expect(response).to render_template :index
      end
    end
    context 'ログインしていない場合' do
      it "ログインページに飛ぶか" do
        redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
     before do
       login_user user
     end
    context "ログインしている場合" do
      it "メッセージは保存できたか" do
         expect{ post :create, params: { group_id: group.id, message: attributes_for(:message) } }.to change(Message, :count).by(1)
      end

      it "MessagesControllerのindexのビューに遷移できているか" do
         post :create, params: { group_id: group.id, message: attributes_for(:message) }
         expect(response).to redirect_to group_messages_path
      end
       it "保存できなかった" do
        expect{ post :create, params: { group_id: group.id, message: attributes_for(:message, body: "", image: "" ) } }.not_to change(Message, :count)
       end
       it "保存できない場合indexに遷移できているか" do
         post :create, params: { group_id: group.id, message: attributes_for(:message, body: "", image: "" ) }
         expect(response).to render_template :index
       end
    end
  end
  describe 'POST #create' do
    context "ログインしていない場合" do
      it " 意図したビューに遷移できているか" do
        expect{ post :create, params: { group_id: group.id, message: attributes_for(:message) } }.to change(Message, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
