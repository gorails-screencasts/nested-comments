class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  def destroy
    update(user: nil, body: nil)
  end

  def deleted?
    user.nil?
  end

  # Alternatively, we could move all the children to point to our parent instead

  #def child_comments
    #Comment.where(parent: self)
  #end

  #before_destroy :handle_children

  #def handle_children
    #child_comments.update_all(parent_id: parent_id)
  #end
end
