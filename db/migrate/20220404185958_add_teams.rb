class AddTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :tag, null: false
      t.bigint :chat_id, null: false
    end
    # TODO: индекс не добавляется в таблицу (Sqlite)
    add_index(:teams, [:chat_id], unique: true, name: 'teams_chat_id_unique')
  end
end
