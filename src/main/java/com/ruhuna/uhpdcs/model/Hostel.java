package com.ruhuna.uhpdcs.model;

import jakarta.persistence.*;

@Entity
@Table(name = "hostels")
public class Hostel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long hostel_id;

    @Column(name = "hostel_name")
    private String name;

    @Enumerated(EnumType.STRING)
    private HostelType hostel_type;

    @Column(name = "hostel_capacity")
    private int capacity;

    // Getters and setters


    public Long getHostel_id() {
        return hostel_id;
    }

    public void setHostel_id(Long hostel_id) {
        this.hostel_id = hostel_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public HostelType getHostel_type() {
        return hostel_type;
    }

    public void setHostel_type(HostelType hostel_type) {
        this.hostel_type = hostel_type;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
}
