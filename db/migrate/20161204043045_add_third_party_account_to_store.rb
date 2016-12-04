class AddThirdPartyAccountToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :dian_ping_account, :string, default: ""
    add_column :stores, :mei_tuan_account, :string, default: ""
  end
end
