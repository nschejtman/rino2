package models.tournament;

import com.avaje.ebean.Model;
import models.match.Match;

import javax.persistence.*;
import java.util.List;

@Entity
public class MatchDay extends Model implements Comparable<MatchDay> {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    int number;

    @OneToMany
    List<Match> matchList;

    @Override
    public int compareTo(MatchDay o) {
        if (number > o.number) return 1;
        else if (number == o.number) return 0;
        else return 0;
    }
}
