package models.team;

import com.avaje.ebean.Model;
import play.data.validation.Constraints;
import play.data.validation.ValidationError;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Team extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    @Constraints.Required
    String name;

    @ManyToMany
    List<Player> players;

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

    public List<Player> getPlayers() {
        return players;
    }

    public void setPlayers(List<Player> players) {
        this.players = players;
    }

    public List<ValidationError> validate() {
        List<ValidationError> errors = new ArrayList<>();
        if (players == null) errors.add(new ValidationError("players", "Player list cannot be null"));
        return errors.isEmpty() ? null : errors;
    }
}
