package models.match;

import com.avaje.ebean.Model;
import models.team.Player;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@Entity
public class PlayerMatchStats extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    @ManyToOne
    Player player;

    @Min(1)
    @Max(10)
    int score;

    @Min(0)
    int goals;

    @Min(0)
    @Max(2)
    int yellows;

    @Min(0)
    @Max(1)
    int reds;

    boolean manOfTheMatch;
}
