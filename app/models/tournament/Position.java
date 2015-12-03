package models.tournament;

import models.team.Team;

public class Position implements Comparable<Position> {
    Team team;
    int w;
    int l;
    int d;
    int gf;
    int ga;

    public Position(Team team) {
        this.team = team;
        w = l = d = gf = ga = 0;
    }

    public void incW(int qty) {
        w += qty;
    }

    public void incD(int qty) {
        d += qty;
    }

    public void incL(int qty) {
        l += qty;
    }

    public void incGf(int qty) {
        gf += qty;
    }

    public void incGa(int qty) {
        ga += qty;
    }

    public void incGfGa(int gf, int ga) {
        incGf(gf);
        incGa(ga);
    }

    public Team getTeam() {
        return team;
    }

    public int getW() {
        return w;
    }

    public int getL() {
        return l;
    }

    public int getD() {
        return d;
    }

    public int getPts() {
        return w * 3 + d;
    }

    public int getGf() {
        return gf;
    }

    public int getGa() {
        return ga;
    }

    public int getGd() {
        return gf - ga;
    }

    public int getP() {
        return w + d + l;
    }

    @Override
    public int compareTo(Position o) {
        if (getPts() > o.getPts()) return -1;
        else if (getPts() < o.getPts()) return 1;
        else if (getGd() > o.getGd()) return -1;
        else if (getGd() < o.getGd()) return 1;
        else return 0;
    }
}
