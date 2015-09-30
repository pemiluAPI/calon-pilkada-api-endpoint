class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.references :province
      t.references :region
      t.string :id_participant # => ID PESERTA
      t.string :endorsement_type # => JENIS DUKUNGAN
      t.text :endorsement # => DUKUNGAN
      t.string :vote_type # => JENIS SUARA/KURSI
      t.string :acceptance_status # => STATUS PENERIMAAN
      t.string :document_completeness # => KELENGKAPAN DOKUMEN
      t.string :research_result # => HASIL PENELITIAN
      t.string :acceptance_document_repair # => PENERIMAAN DOKUMEN PERBAIKAN
      t.string :amount_support # => JUMLAH DUKUNGAN AWAL
      t.string :amount_support_repair # => JUMLAH DUKUNGAN SAAT PERBAIKAN
      t.string :amount_support_determination # => JUMLAH DUKUNGAN PENETAPAN
      t.string :eligibility_support # => PEMENUHAN SYARAT DUKUNGAN 
      t.string :eligibility_support_repair	# => PEMENUHAN SYARAT DUKUNGAN SAAT PERBAIKAN
      t.string :pertahana # => PERTAHANA
      t.string :dynasty # => DINASTI
      t.string :amount_women # => JUMLAH PEREMPUAN
      t.string :incumbent # => INCUMBENT
      t.string :resource # => SUMBER
      t.timestamps
    end
    add_index :candidates, :province_id
    add_index :candidates, :region_id
    add_index :candidates, :endorsement_type
    add_index :candidates, :vote_type
  end
end
