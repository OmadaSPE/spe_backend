json.array! @images do |image|
  json.id image.id
  json.description image.description
  json.media_id image.media_id
end
