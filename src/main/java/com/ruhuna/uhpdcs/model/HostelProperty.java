package com.ruhuna.uhpdcs.model;

@Entity
@Table(name = "hostel_properties")
public class HostelProperty {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long property_id;

    @Column(name = "property_name")
    private String name;

    @Enumerated(EnumType.STRING)
    private PropertyType property_type;

    @Column(name = "property_location")
    private String location;

    @Lob
    @Column(name = "property_qr_code")
    private byte[] qrCode;

    @ManyToOne
    private Room room;

    @ManyToOne
    private Hostel hostel;

    // Constructor
    public HostelProperty(String propertyName, PropertyType propertyType, String propertyLocation, byte[] propertyQrCode, Long hostelId, Long roomId) {
        this.propertyName = propertyName;
        this.propertyType = propertyType;
        this.propertyLocation = propertyLocation;
        this.propertyQrCode = propertyQrCode;
        this.hostelId = hostelId;
        this.roomId = roomId;
    }


    // Getters and setters

    public Long getProperty_id() {
        return property_id;
    }

    public void setProperty_id(Long property_id) {
        this.property_id = property_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public PropertyType getProperty_type() {
        return property_type;
    }

    public void setProperty_type(PropertyType property_type) {
        this.property_type = property_type;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public byte[] getQrCode() {
        return qrCode;
    }

    public void setQrCode(byte[] qrCode) {
        this.qrCode = qrCode;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Hostel getHostel() {
        return hostel;
    }

    public void setHostel(Hostel hostel) {
        this.hostel = hostel;
    }
}
