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

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<Team> getTeams() {
        return teams;
    }

    public void setTeams(List<Team> teams) {
        this.teams = teams;
    }

    public List<MatchDay> getMatchDays() {
        return matchDays;
    }

    public void setMatchDays(List<MatchDay> matchDays) {
        this.matchDays = matchDays;
    }

    @ManyToOne
    Category category;

    @ManyToMany
    List<Team> teams;

    @OneToMany(cascade = CascadeType.ALL)
    List<MatchDay> matchDays;


}
