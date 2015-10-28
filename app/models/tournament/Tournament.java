package models.tournament;

import com.avaje.ebean.Model;
import models.team.Team;

import javax.persistence.*;
import java.util.List;

@Entity
public class Tournament extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    String name;
    boolean active;

    @ManyToOne
    Category category;

    @ManyToMany
    List<Team> teams;

    @OneToMany
    List<MatchDay> matchDays;


}
