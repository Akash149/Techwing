
package com.tech.blog.entities;

public class Contact {
    private String name;
    private String email;
    private String phone;
    private String query;

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Contact(String name, String email, String phone, String query) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.query = query;
    }
    
}
