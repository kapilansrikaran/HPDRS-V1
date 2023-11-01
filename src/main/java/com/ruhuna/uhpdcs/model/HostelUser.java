package com.ruhuna.uhpdcs.model;

@Entity
@Table(name = "hostel_users")
public class HostelUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long hostel_user_id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Hostel hostel;

    // Getters and setters

    public Long getHostel_user_id() {
        return hostel_user_id;
    }

    public void setHostel_user_id(Long hostel_user_id) {
        this.hostel_user_id = hostel_user_id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Hostel getHostel() {
        return hostel;
    }

    public void setHostel(Hostel hostel) {
        this.hostel = hostel;
    }
}