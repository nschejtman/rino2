package models.media;

import com.avaje.ebean.Model;
import play.data.validation.Constraints;

import javax.persistence.Entity;
import java.util.Date;

@Entity
public class TeamOfTheDay extends Model implements Comparable<TeamOfTheDay> {

    @Constraints.Required(message = "Por favor indique un arquero")
    String goalkeeper;
    @Constraints.Required(message = "Por favor indique un defensor izquierdo")
    String leftBack;
    @Constraints.Required(message = "Por favor indique un defensor derecho")
    String rightBack;
    @Constraints.Required(message = "Por favor indique un mediocampo izquierdo")
    String leftMidfielder;
    @Constraints.Required(message = "Por favor indique un mediocampo derecho")
    String rightMidfielder;
    @Constraints.Required(message = "Por favor indique un delantero")
    String striker;
    @Constraints.Required(message = "Hubo un error procesando la fecha")
    Date date;

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getGoalkeeper() {
        return goalkeeper;
    }

    public void setGoalkeeper(String goalkeeper) {
        this.goalkeeper = goalkeeper;
    }

    public String getLeftBack() {
        return leftBack;
    }

    public void setLeftBack(String leftBack) {
        this.leftBack = leftBack;
    }

    public String getRightBack() {
        return rightBack;
    }

    public void setRightBack(String rightBack) {
        this.rightBack = rightBack;
    }

    public String getLeftMidfielder() {
        return leftMidfielder;
    }

    public void setLeftMidfielder(String leftMidfielder) {
        this.leftMidfielder = leftMidfielder;
    }

    public String getRightMidfielder() {
        return rightMidfielder;
    }

    public void setRightMidfielder(String rightMidfielder) {
        this.rightMidfielder = rightMidfielder;
    }

    public String getStriker() {
        return striker;
    }

    public void setStriker(String striker) {
        this.striker = striker;
    }

    @Override
    public int compareTo(TeamOfTheDay o) {
        return o.date.compareTo(date); //Compare in reverse order of reverse sorting
    }
}
