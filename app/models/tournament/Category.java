package models.tournament;

import com.avaje.ebean.Model;
import com.fasterxml.jackson.annotation.JsonIgnore;
import play.data.validation.Constraints;
import play.data.validation.ValidationError;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Category extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    @Constraints.Required
    String name;

    @JsonIgnore
    public List<Tournament> getTournaments() {
        return tournaments;
    }

    public void setTournaments(List<Tournament> tournaments) {
        this.tournaments = tournaments;
    }

    @OneToMany
//    @Constraints.Required TODO check why this is not working
    List<Tournament> tournaments;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<ValidationError> validate() {
        List<ValidationError> errors = new ArrayList<>();
        if (tournaments == null) errors.add(new ValidationError("tournaments", "Tournament list cannot be null"));
        return errors.isEmpty() ? null : errors;
    }
}
