package thuc.ute.entity;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Users")
@Data
@NoArgsConstructor
@AllArgsConstructor

@NamedQuery(
        name = "User.findAll",
        query = "SELECT u FROM User u"
)
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(
            name = "email",
            columnDefinition = "NVARCHAR(255)",
            unique = true,
            nullable = false
    )
    private String email;

    @Column(
            name = "username",
            columnDefinition = "NVARCHAR(100)",
            unique = true,
            nullable = false
    )
    private String username;

    @Column(
            name = "fullname",
            columnDefinition = "NVARCHAR(255)",
            nullable = false
    )
    private String fullname;

    @Column(
            name = "password",
            columnDefinition = "NVARCHAR(255)",
            nullable = false
    )
    private String password;

    @Column(
            name = "avatar",
            columnDefinition = "NVARCHAR(500)"
    )
    private String avatar;

    @Column(name = "roleid")
    private int roleid;

    @Column(
            name = "phone",
            columnDefinition = "NVARCHAR(20)",
            unique = true
    )
    private String phone;

    @Column(name = "createdDate")
    private LocalDate createdDate;

    @Column(name = "active")
    private boolean active;

    @Column(
            name = "otp",
            columnDefinition = "NVARCHAR(10)"
    )
    private String otp;

    @Column(name = "otpExpiry")
    private LocalDateTime otpExpiry;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", fullname='" + fullname + '\'' +
                ", avatar='" + avatar + '\'' +
                ", roleid=" + roleid +
                ", phone='" + phone + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}