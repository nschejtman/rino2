import com.avaje.ebean.Ebean;
import models.match.Match;
import models.team.Team;
import models.tournament.Category;
import models.tournament.MatchDay;
import models.tournament.Tournament;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Date;

//TODO revise db tests
public class MatchDayTests {

    @Test
    public void TestQuery(){
        final Category c = new Category();
        c.setName("A");
        c.save();

        final Tournament t = new Tournament();
        t.setCategory(c);
        t.setActive(true);
        t.setName("A 2015");
        t.setMatchDays(new ArrayList<>());
        t.setTeams(new ArrayList<>());
        t.save();

        final Team team = new Team();
        team.setName("team");
        team.setPlayers(new ArrayList<>());
        team.save();

        final Team team2 = new Team();
        team2.setName("team2");
        team2.setPlayers(new ArrayList<>());
        team2.save();

        final MatchDay matchDay = new MatchDay();
        matchDay.setNumber(1);
        matchDay.setMatchList(new ArrayList<>());
        matchDay.save();

        t.getMatchDays().add(matchDay);
        t.update();

        final Match match = new Match();
        match.setDate(new Date(System.currentTimeMillis()));
        match.setScoreA(1);
        match.setScoreB(1);
        match.setTeamA(team);
        match.setTeamB(team2);
        match.save();

        matchDay.getMatchList().add(match);
        matchDay.update();
    }
}
