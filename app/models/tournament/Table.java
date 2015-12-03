package models.tournament;

import models.team.Team;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Table {
    List<Position> positions;

    public Table() {
        positions = new ArrayList<>();
    }

    public Position getPosition(Team team) {
        return positions
                .stream()
                .filter(position -> position.getTeam().equals(team))
                .findFirst()
                .orElseThrow(IllegalArgumentException::new);
    }

    public void addTeam(Team team) {
        positions.add(new Position(team));
    }

    /**
     * Returns sorted positions
     * @return sorted positions
     */
    public List<Position> getPositions(){
        Collections.sort(positions);
        return positions;
    }
}
