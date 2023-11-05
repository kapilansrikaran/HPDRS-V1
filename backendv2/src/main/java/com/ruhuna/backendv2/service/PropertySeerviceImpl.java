package com.ruhuna.backendv2.service;

import com.ruhuna.backendv2.model.Property;
import com.ruhuna.backendv2.repository.PropertyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PropertySeerviceImpl implements PropertyService{

    @Autowired
    private PropertyRepository propertyRepository;

    @Override
    public List<Property> getAllPropertys(){ return propertyRepository.findAll();}

    @Override
    public void saveProperty(Property property) {this.propertyRepository.save(property); }

    @Override
    public Property getPropertyById(long id) {
        Optional<Property> optional = propertyRepository.findById(id);
        Property property = null;
        if (optional.isPresent()) {
            property = optional.get();
        } else {
            throw new RuntimeException(" Property not found for id :: " + id);
        }
        return property;
    }

    @Override
    public void deletePropertyById(long id){this.propertyRepository.deleteById(id);}

    @Override
    public Page<Property> findPaginated(int pageNo, int pageSize, String sortField, String sortDirection) {
        Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name()) ? Sort.by(sortField).ascending() :
                Sort.by(sortField).descending();

        Pageable pageable = PageRequest.of(pageNo - 1, pageSize, sort);
        return this.propertyRepository.findAll(pageable);
    }




}
