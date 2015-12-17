package models.match;

import com.avaje.ebean.Model;
import models.team.Team;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Match extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    @ManyToOne
    Team teamA;

    @ManyToOne
    Team teamB;

    int scoreA;
    int scoreB;

    Date date;
    Date dataCompletionDate;

    public Date getDataCompletionDate() {
        return dataCompletionDate;
    }

    public void setDataCompletionDate(Date dataCompletionDate) {
        this.dataCompletionDate = dataCompletionDate;
    }

    public Team getTeamA() {
        return teamA;
    }

    public void setTeamA(Team teamA) {
        this.teamA = teamA;
    }

    public Team getTeamB() {
        return teamB;
    }

    public void setTeamB(Team teamB) {
        this.teamB = teamB;
    }

    public int getScoreA() {
        return scoreA;
    }

    public void setScoreA(int scoreA) {
        this.scoreA = scoreA;
    }

    public int getScoreB() {
        return scoreB;
    }

    public void setScoreB(int scoreB) {
        this.scoreB = scoreB;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
