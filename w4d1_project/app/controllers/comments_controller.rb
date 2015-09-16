class CommentsController < ApplicationController
  def index
    commented_object = find_commentable
    if commented_object
      render json: commented_object.comments
    else
      render json: "No object to find comments for", status: :unprocessable_entity
    end
  end

  def create
    commented_object = find_commentable
    comment = Comment.new(comment_params(commented_object))
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  private
  def comment_params(object)
    args = params.require(:comment).permit(:body)
    args[:commentable_id] = object.id
    args[:commentable_type] = object.class.to_s
    args
  end
end
