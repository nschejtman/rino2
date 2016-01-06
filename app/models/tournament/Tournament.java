package models.tournament;

import com.avaje.ebean.Model;
import com.fasterxml.jackson.annotation.JsonIgnore;
import models.match.Match;
import models.team.Team;
import play.data.validation.Constraints;

import javax.persistence.*;
import java.util.List;

@Entity
public class Tournament extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    @Constraints.Required(message = "No se puede crear torneo sin nombre")
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
    @Constraints.Required(message = "No se puede crear torneo sin categoría")
    Category category;

    @ManyToMany
    List<Team> teams;

    @OneToMany(cascade = CascadeType.ALL)
    List<MatchDay> matchDays;

    @JsonIgnore
    public Table getTable() {
        final Table table = new Table();
        teams.forEach(table::addTeam);
        for (MatchDay matchDay : matchDays) {
            final List<Match> matchList = matchDay.matchList;
            for (Match match : matchList) {
                final Team teamA = match.getTeamA();
                final Team teamB = match.getTeamB();
                final int scoreA = match.getScoreA();
                final int scoreB = match.getScoreB();
                final Position positionA = table.getPosition(teamA);
                final Position positionB = table.getPosition(teamB);
                if (scoreA > scoreB) {
                    positionA.incW(1);
                    positionB.incL(1);
                } else if (scoreA < scoreB) {
                    positionA.incL(1);
                    positionB.incW(1);
                } else {
                    positionA.incD(1);
                    positionB.incD(1);
                }
                positionA.incGfGa(scoreA, scoreB);
                positionB.incGfGa(scoreB, scoreA);
            }
        }
        return table;
    }


}
