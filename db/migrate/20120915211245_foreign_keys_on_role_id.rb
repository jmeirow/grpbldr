class ForeignKeysOnRoleId < ActiveRecord::Migration
  def change

    execute <<-SQL
      ALTER TABLE assignments
        ADD CONSTRAINT fk_assignment_roles
        FOREIGN KEY (role_id)
        REFERENCES roles(id);
      ALTER TABLE role_group_associations
        ADD CONSTRAINT fk_role_group_associations_roles
        FOREIGN KEY (role_id)
        REFERENCES roles(id);
    SQL
  end
end
