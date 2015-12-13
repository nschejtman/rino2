package models.tournament;

import com.avaje.ebean.Model;
import com.fasterxml.jackson.annotation.JsonIgnore;
import models.match.Match;

import javax.persistence.*;
import java.util.List;

@Entity
public class MatchDay extends Model implements Comparable<MatchDay> {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    int number;

    @OneToMany(cascade = CascadeType.ALL)
    List<Match> matchList;

    @Override
    public int compareTo(MatchDay o) {
        if (number > o.number) return 1;
        else if (number == o.number) return 0;
        else return 0;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @JsonIgnore
    public List<Match> getMatchList() {
        return matchList;
    }

    public void setMatchList(List<Match> matchList) {
        this.matchList = matchList;
    }
}
