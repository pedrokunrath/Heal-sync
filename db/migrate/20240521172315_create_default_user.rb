class CreateDefaultUser < ActiveRecord::Migration[7.1]
  def change
    # <User id: 1, email: "murilo_marcal@outlook.com", created_at: "2024-05-20 23:11:59.034088000 +0000", updated_at: "2024-05-20 23:11:59.034088000 +0000", admin: false>
    User.create(
      email: "murilo_marcal@outlook.com",
      password: "YogoAdmin!@#",
      password_confirmation: "YogoAdmin!@#"
    )

  end
end
