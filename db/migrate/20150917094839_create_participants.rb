class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references :candidate
      t.string :kind # => JENIS PESERTA : CALON / WAKIL CALON
      t.string :name
      t.string :gender
      t.string :pob # => PLACE OF BIRTH
      t.string :dob # => DATE OF BIRTH
      t.text   :address 
      t.string :work
      t.string :status
      t.timestamps
    end
    add_index :participants, :candidate_id
  end
end
