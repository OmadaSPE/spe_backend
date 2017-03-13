require 'csv'

namespace :task do
    desc "Bulk Update tag names"
    task fuzzily: :environment do
        Tag.bulk_update_fuzzy_tag_name
    end

    desc "Import Objs from csv"
    task import_objs: :environment do
        object_import_map = {
            "irn": :irn,
            "ColPhysicalDescription": :description,
            "ColMainTitle": :title,
            "taxonomy": :taxonomy
        }
        CSV.foreach("/Users/oskarb/Documents/uni/spe/spe_backend/lib/tasks/objects_database.csv", headers: true, encoding:'iso-8859-1:utf-8') do |row|
            obj = {irn: nil, description: nil, title: nil, taxonomy: nil}
            row.to_hash.keys.each do |k|
                obj[object_import_map[k.to_sym]] = row[k] if object_import_map.keys.include? k.to_sym
            end
            Emuobject.create!(obj)
        end
    end

    desc "Import Images from csv"
    task import_imgs: :environment do
        image_import_map = {
            irn: "irn",
            MulTitle: "title",
            NotNotes: "notes",
            subjects: "subjects",
            MulMimeFormat: 'mimeformat',
            MulMimeType: 'mimetype',
            MulDescription: 'description',
            AdmDateInserted: 'inserted_at',
            SumDepartment: 'department'
        }
        CSV.foreach("/Users/oskarb/Documents/uni/spe/spe_backend/lib/tasks/images_database.csv", headers: true, encoding:'iso-8859-1:utf-8') do |row|
            obj = {}
            row.to_hash.keys.each do |k|
                obj[image_import_map[k.to_sym]] = row[k] if image_import_map.keys.include? k.to_sym
            end
            Image.create!(obj)
        end
    end

    desc "Import Relationships from csv"
    task import_rel: :environment do
        CSV.foreach("/Users/oskarb/Documents/uni/spe/spe_backend/lib/tasks/OBJECTS_IMAGES_keys.csv", headers: true, encoding:'iso-8859-1:utf-8') do |row|
            img = Image.where(irn: row['multimedia irn']).first
            obj = Emuobject.where(irn: row['object irn']).first
            img.emuobjects << obj if img && obj
        end
    end

    desc "Import Relationships from csv"
    task test_data: :environment do
        puts Image.where(mimeformat: 'tiff').count
    end

end
