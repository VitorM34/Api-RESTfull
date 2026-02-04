class AddNotNullAndFkToContactsKind < ActiveRecord::Migration[8.0]
  def change
    # garante que todos os contatos tenham kind_id antes de aplicar NOT NULL
    change_column_null :contacts, :kind_id, false
    add_foreign_key :contacts, :kinds
  end
end
