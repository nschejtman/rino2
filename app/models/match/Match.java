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

}
