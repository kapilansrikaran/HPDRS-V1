package com.ruhuna.uhpdcs.model;

public class UserContactNo {
    @Entity
    @Table(name = "user_contact_no")
    public class UserContactNo {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long userContactNoId;

        private String contactNo;

        // Define the relationship with User
        private Long userId;

        // Constructors, getters, and setters

        public UserContactNo(Long userContactNoId, String contactNo, Long userId) {
            this.userContactNoId = userContactNoId;
            this.contactNo = contactNo;
            this.userId = userId;
        }

        public Long getUserContactNoId() {
            return userContactNoId;
        }

        public void setUserContactNoId(Long userContactNoId) {
            this.userContactNoId = userContactNoId;
        }

        public String getContactNo() {
            return contactNo;
        }

        public void setContactNo(String contactNo) {
            this.contactNo = contactNo;
        }

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }
    }
}
