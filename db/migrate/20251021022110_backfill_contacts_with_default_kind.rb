class BackfillContactsWithDefaultKind < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def up
    # cria o kind default se não existir
    default_id = nil
    say_with_time "creating default kind" do
      execute("INSERT INTO kinds (description, created_at, updated_at) VALUES ('default', now(), now())")
      # pega o id do default
      default_id = select_value("SELECT id FROM kinds WHERE description = 'default' LIMIT 1")
    end

    say_with_time "backfilling contacts" do
      execute("UPDATE contacts SET kind_id = #{default_id} WHERE kind_id IS NULL")
    end
  end

  def down
    say_with_time "removing default kind associations" do
      execute("UPDATE contacts SET kind_id = NULL WHERE kind_id IS NOT NULL")
      execute("DELETE FROM kinds WHERE description = 'default'")
    end
  end
end
