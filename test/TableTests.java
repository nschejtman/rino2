import models.team.Team;
import models.tournament.Position;
import models.tournament.Table;
import org.junit.Assert;
import org.junit.Test;

public class TableTests {

    @Test
    public void testSimpleTeamAdd(){
        final Table table = new Table();
        final Team team = new Team();
        table.addTeam(team);
        Assert.assertEquals(table.getPosition(team).getTeam(), team);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testTeamNotFound(){
        final Table table = new Table();
        table.getPosition(new Team());
    }

    @Test
    public void testPostionList(){
        final Table table = new Table();
        for (int i = 0; i < 10; i++) {
            final Team team = new Team();
            team.setName("Team " + i);
            table.addTeam(team);
            final Position position = table.getPosition(team);
            position.incW(10 - i);
        }
        Assert.assertEquals("Team 0", table.getPositions().get(0).getTeam().getName());
        Assert.assertEquals(30, table.getPositions().get(0).getPts());
    }
}
