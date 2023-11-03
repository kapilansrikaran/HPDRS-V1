package com.ruhuna.uhpdcs.repository;
// Spring Data JPA repositories for database access.

import com.ruhuna.uhpdcs.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    // Custom query method to find a role by its name
    Role findByRoleId(int roleId); // allows you to find a Role entity by its roleName
}