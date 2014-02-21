class Permission
  def initialize(user)
    allow :users, [:new, :create]
    allow :sessions, [:new, :create, :destroy]
    allow :password_resets, [:new, :create, :edit, :update]
#    allow :posts, [:index, :show]
    if user
      allow :sessions, [:index]
      allow :users, [:edit, :update]
      allow :posts, [:index, :new, :create, :edit, :update]
      allow_all if user.admin?
    end
  end
  
  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
end
