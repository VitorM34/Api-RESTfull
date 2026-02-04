class AddKindToContact < ActiveRecord::Migration[8.0]
  def change
    # Permitir null temporariamente e não criar a foreign key aqui,
    # para evitar erro ao aplicar a migration em uma tabela com registros existentes
    # e sem a tabela `kinds` criada ainda.
    add_reference :contacts, :kind, null: true, foreign_key: false
  end
end
