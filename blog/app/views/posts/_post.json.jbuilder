json.extract! post, :id, :title, :genre, :description, :pages, :created_at, :updated_at
json.url post_url(post, format: :json)
