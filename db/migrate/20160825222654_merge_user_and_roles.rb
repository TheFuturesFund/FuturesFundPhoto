class MergeUserAndRoles < ActiveRecord::Migration
  def up
    # Add columns for data to users table

    add_column :users, :role, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :classroom_id, :integer

    # Migrate data into users table

    migrate_roles_to_users_table

    # Add null constraint to users.role

    change_column :users, :role, :integer, null: false, default: 0

    # Add indexes for the new user data

    add_index :users, :role
    add_index :users, :classroom_id

    # Drop the polymorphic relationship: user -> role

    remove_column :users, :role_id
    remove_column :users, :role_type

    # Drop the role tables

    drop_table :students
    drop_table :teachers
    drop_table :directors

    # Rename the student_id column where it appears in albums

    rename_column :albums, :student_id, :user_id
  end

  def down
    # Rebuild dropped tables

    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :classroom_id, :integer

      t.timestamps null: false
    end

    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end

    create_table :directors do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end

    # Add columns for polymorphic relationship: user -> role

    add_column :users, :role_id, :integer
    add_column :users, :role_type, :string

    # Migrate data

    migrate_users_to_roles_tables

    # Add indexes

    add_index :users, :role_id
    add_index :users, :role_type

    # Drop data from users table

    remove_column :users, :role
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :classroom_id

    # Rename the student_id column where it appears in albums

    rename_column :albums, :user_id, :student_id
  end

  private

  # Execute SQL to migrate roles tables into users table

  def migrate_roles_to_users_table
    execute("SELECT * FROM users").each do |row|
      role_enum = ["Student", "Teacher", "Director"].index(row["role_type"])
      table = row["role_type"].underscore.pluralize

      role_row = execute("SELECT * FROM #{table} WHERE id = #{row['role_id']}").first

      execute(
        <<-SQL
          UPDATE users
          SET role=#{role_enum},
              first_name='#{role_row['first_name']}',
              last_name='#{role_row['last_name']}',
              classroom_id=#{role_row['classroom_id'] || 'NULL'}
          WHERE users.id = #{row['id']}
        SQL
      )
    end
  end

  # Execute SQL to rollback users table and create roles tables

  def migrate_users_to_roles_tables
    execute("SELECT * FROM users").each do |user_row|
      role_table = ["students", "teachers", "directors"][user_row["role"].to_i]
      if role_table == "students"
        execute(
          <<-SQL
            INSERT INTO students (first_name, last_name, classroom_id, created_at, updated_at)
            VALUES ('#{user_row['first_name']}', '#{user_row['last_name']}', #{user_row['classroom_id']}, NOW(), NOW())
          SQL
        )
      else
        execute(
          <<-SQL
            INSERT INTO #{role_table} (first_name, last_name, created_at, updated_at)
            VALUES ('#{user_row['first_name']}', '#{user_row['last_name']}', NOW(), NOW())
          SQL
        )
      end
    end
  end
end
