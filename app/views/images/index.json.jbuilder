json.array! @images do |image|
  json.description image.description
  json.media_id image.media_id
end
