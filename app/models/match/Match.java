package models.match;

import com.avaje.ebean.Model;
import models.team.Team;
import play.data.validation.Constraints;
import play.data.validation.ValidationError;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class Match extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    @ManyToOne
    @Constraints.Required(message = "No se puede crear partido sin equipo A")
    Team teamA;

    @ManyToOne
    @Constraints.Required(message = "No se puede crear partido sin equipo B")
    Team teamB;

    int scoreA;
    int scoreB;

    @Constraints.Required(message = "No se puede crear partido sin fecha y hora")
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

    public List<ValidationError> validate() {
        final ArrayList<ValidationError> errors = new ArrayList<>();
        if (teamA.equals(teamB)){
            errors.add(new ValidationError("teamA", "No se puede crear partido con ambos equipos iguales"));
        }
        return errors.isEmpty() ? null : errors;
    }
}
