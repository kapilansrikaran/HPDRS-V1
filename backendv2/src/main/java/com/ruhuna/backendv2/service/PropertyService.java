package com.ruhuna.backendv2.service;

import com.ruhuna.backendv2.model.Property;
import com.ruhuna.backendv2.repository.PropertyRepository;
import org.springframework.data.domain.Page;

import java.util.List;

public interface PropertyService {
    List<Property> getAllPropertys();
    void saveProperty(Property property);

    Property getPropertyById(long id);

    void deletePropertyById(long id);

    Page<Property> findPaginated(int pagNo, int pageSize, String sortField, String sortDirection);



}
