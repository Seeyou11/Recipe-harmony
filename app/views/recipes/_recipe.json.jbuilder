json.extract! recipe, :id, :title, :description, :preparation_steps, :user_id, :category_id, :allow_comments, :show_likes_count, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
