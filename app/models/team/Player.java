package models.team;

import com.avaje.ebean.Model;
import play.data.validation.Constraints;

import javax.persistence.*;

@Entity
public class Player extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    @Constraints.Required(message = "No se puede crear jugador sin nombre")
    String firstName;
    @Constraints.Required(message = "No se puede crear jugador sin apellido")
    String lastName;
    String email;
    String phone;
    @Column(unique = true)
    Integer dni;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
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

    public Integer getDni() {
        return dni;
    }

    public void setDni(Integer dni) {
        this.dni = dni;
    }
}