package com.ruhuna.uhpdcs.model;

@Entity
@Table(name = "hostel_property_damage_complaints")
public class HostelPropertyDamageComplaint {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long complain_id;

    @Column(name = "complaint_ticket_id")
    private String ticketId;

    @Column(name = "complaint_description")
    private String description;

    @Column(name = "creation_date")
    private Timestamp creationDate;

    @Column(name = "last_updated")
    private Timestamp lastUpdated;

    @Lob
    private byte[] attachment;

    @ManyToOne
    private User user;

    @ManyToOne
    private HostelProperty property;

    @ManyToOne
    private Hostel hostel;

    @Enumerated(EnumType.STRING)
    private ComplaintStatus complain_current_status;

    @ManyToOne
    private HostelUser hostelUser;

    // Constructor
    public HostelPropertyDamageComplaint(String complaintTicketId, String complaintDescription, Timestamp creationDate, Timestamp lastUpdated, byte[] attachment, Long userId, Long propertyId, Long hostelId, ComplaintStatus complainCurrentStatus, Long hostelUserId) {
        this.complaintTicketId = complaintTicketId;
        this.complaintDescription = complaintDescription;
        this.creationDate = creationDate;
        this.lastUpdated = lastUpdated;
        this.attachment = attachment;
        this.userId = userId;
        this.propertyId = propertyId;
        this.hostelId = hostelId;
        this.complainCurrentStatus = complainCurrentStatus;
        this.hostelUserId = hostelUserId;
    }



    // Getters and setters


    public Long getComplain_id() {
        return complain_id;
    }

    public void setComplain_id(Long complain_id) {
        this.complain_id = complain_id;
    }

    public String getTicketId() {
        return ticketId;
    }

    public void setTicketId(String ticketId) {
        this.ticketId = ticketId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public byte[] getAttachment() {
        return attachment;
    }

    public void setAttachment(byte[] attachment) {
        this.attachment = attachment;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public HostelProperty getProperty() {
        return property;
    }

    public void setProperty(HostelProperty property) {
        this.property = property;
    }

    public Hostel getHostel() {
        return hostel;
    }

    public void setHostel(Hostel hostel) {
        this.hostel = hostel;
    }

    public ComplaintStatus getComplain_current_status() {
        return complain_current_status;
    }

    public void setComplain_current_status(ComplaintStatus complain_current_status) {
        this.complain_current_status = complain_current_status;
    }

    public HostelUser getHostelUser() {
        return hostelUser;
    }

    public void setHostelUser(HostelUser hostelUser) {
        this.hostelUser = hostelUser;
    }
}
