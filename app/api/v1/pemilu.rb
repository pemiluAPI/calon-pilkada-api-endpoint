module PaslonHelpers
  def build_paslon(participant)
    unless participant.blank?
      {
        kind: participant.kind,
        nama: participant.name,
        jk: participant.gender,
        pob: participant.pob,
        dob: participant.dob,
        alamat: participant.address,
        pekerjaan: participant.work,
        status: participant.status
      }
    else
      {}
    end
  end
end

module RegionHelpers
  def build_region(region)
    region.nil? ? {} : {
      id: region.id,
      nama: region.name
    }
  end
end

module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :candidates do
      helpers PaslonHelpers
      helpers RegionHelpers

      desc "Return all Candidates PemiluKada 2015"
      get do
        candidates = Array.new

        # Prepare conditions based on params
        valid_params = {
          peserta: 'id_participant',
          dukungan: 'endorsement_type',
          suara: 'vote_type',
          incumbent: 'incumbent',
          daerah: 'region_id',
          provinsi: 'province_id',
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Candidate.includes(:province, :region, :participants)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |candidate|
            candidates << {
              id: candidate.id,
              provinsi: {
                id: candidate.province_id,
                nama: candidate.province.blank? ? "" : candidate.province.name
              },
              daerah: build_region(candidate.region),
              id_peserta: candidate.id_participant,
              paslon: [
                build_paslon(candidate.participants.where(kind: "CALON").first),
                build_paslon(candidate.participants.where(kind: "WAKIL").first)
              ],
              jenis_dukungan: candidate.endorsement_type,
              dukungan: candidate.endorsement,
              pilihan_suara: candidate.vote_type,
              status_penerimaan: candidate.acceptance_status,
              kelengkapan_dokumen: candidate.document_completeness,
              hasil_penelitian: candidate.research_result,
              penerimaan_dokumen_perbaikan: candidate.acceptance_document_repair,
              jumlah_dukungan_awal: candidate.amount_support,
              jumlah_dukungan_perbaikan: candidate.amount_support_repair,
              jumlah_dukungan_penetapan: candidate.amount_support_determination,
              pemenuhan_syarat_dukungan: candidate.eligibility_support,
              pemenuhan_syarat_dukungan_perbaikan: candidate.eligibility_support_repair,
              pertahana: candidate.pertahana,
              dinasti: candidate.dynasty,
              perempuan: candidate.amount_women,
              incumbent: candidate.incumbent,
              sumber: candidate.resource
            }
        end

        {
          results: {
            count: candidates.count,
            total: Candidate.where(conditions).count,
            candidates: candidates
          }
        }
      end
    end

    resource :vision_missions do
      helpers PaslonHelpers

      desc "Return all vision_missions"
      get do
        vision_missions = Array.new

        # Prepare conditions based on params
        valid_params = {
          peserta: 'candidates.id_participant'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        VisionMission.joins(:candidate => :participants)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .uniq
          .each do |vision_mission|
          vision_missions << {
            id: vision_mission.id,
            candidate_id: vision_mission.candidate.id_participant,
            paslon: [
              build_paslon(vision_mission.candidate.participants.where(kind: "CALON").first),
              build_paslon(vision_mission.candidate.participants.where(kind: "WAKIL").first)
            ],
            visi: vision_mission.vision,
            misi: vision_mission.mission,
            sumber: vision_mission.resource
          }
        end

        {
          results: {
            count: vision_missions.count,
            total: VisionMission.joins(:candidate => :participants).where(conditions).uniq.count,
            vision_missions: vision_missions
          }
        }
      end
    end

    resource :pictures do
      desc "Return all Picture of Paslon"
      get do
        pictures = Array.new

        # Prepare conditions based on params
        valid_params = {
          peserta: 'id_participant',
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Picture.where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |picture|
            pictures << {
              id: picture.id,
              id_peserta: picture.id_participant,
              url: picture.url
            }
        end

        {
          results: {
            count: pictures.count,
            total: Picture.where(conditions).count,
            pictures: pictures
          }
        }
      end
    end

    resource :provinces do
      desc "Return all provinces"
      get do
        provinces = Array.new

        Province.all.each do |province|
          provinces << {
            id: province.id,
            nama: province.name
          }
        end

        {
          results: {
            count: provinces.count,
            total: Province.count,
            provinces: provinces
          }
        }
      end
    end

    resource :regions do
      desc "Return all regions"
      get do
        regions = Array.new

        # Prepare conditions based on params
        valid_params = {
          provinsi: 'province_id',
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Region.includes(:province)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |region|
            regions << {
              id: region.id,
              provinsi: {
                id: region.province_id,
                nama: region.province.blank? ? "BLANK" : region.province.name
              },
              kind: region.kind,
              nama: region.name
            }
        end

        {
          results: {
            count: regions.count,
            total: Region.count,
            regions: regions
          }
        }
      end
    end
  end
end