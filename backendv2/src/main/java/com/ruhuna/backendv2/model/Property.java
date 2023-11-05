package com.ruhuna.backendv2.model;

import javax.persistence.*;

@Entity
@Table(name = "property")
public class Property {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private long id;

    @Column(name = "property_name")
    private String propertyName;

    @Column(name = "property_location")
    private String propertyLocation;

    public Property() {

    }

    public Property(long id, String propertyName, String propertyLocation) {
        this.id = id;
        this.propertyName = propertyName;
        this.propertyLocation = propertyLocation;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPropertyName() {
        return propertyName;
    }

    public void setPropertyName(String propertyName) {
        this.propertyName = propertyName;
    }

    public String getPropertyLocation() {
        return propertyLocation;
    }

    public void setPropertyLocation(String propertyLocation) {
        this.propertyLocation = propertyLocation;
    }
}
