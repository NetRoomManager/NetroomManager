package com.itbank.service;

import com.itbank.model.dto.League;
import com.itbank.model.dto.Summoner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class RiotAPIService {

    private static final String API_KEY = "RGAPI-b8a61944-925e-48f5-81ef-068db34bb0fd";
    private static final String BASE_URL = "https://kr.api.riotgames.com/lol/";

    @Autowired
    private RestTemplate restTemplate;

    public Summoner getSummoner(String summonerName) {
        String summonerUrl = BASE_URL + "summoner/v4/summoners/by-name/" + summonerName + "?api_key=" + API_KEY;
        ResponseEntity<Summoner> summonerResponse = restTemplate.getForEntity(summonerUrl, Summoner.class);
        Summoner summoner = summonerResponse.getBody();

        if (summoner != null) {
            String leagueUrl = BASE_URL + "league/v4/entries/by-summoner/" + summoner.getId() + "?api_key=" + API_KEY;
            ResponseEntity<League[]> leagueResponse = restTemplate.getForEntity(leagueUrl, League[].class);
            League[] leagues = leagueResponse.getBody();

            if (leagues != null && leagues.length > 0) {
                League soloQueue = findSoloQueue(leagues);
                if (soloQueue != null) {
                    summoner.setTier(soloQueue.getTier());
                    summoner.setRank(soloQueue.getRank());
                    summoner.setLeaguePoints(soloQueue.getLeaguePoints());
                    summoner.setWins(soloQueue.getWins());
                    summoner.setLosses(soloQueue.getLosses());
                }
            }
        }

        return summoner;
    }

    private League findSoloQueue(League[] leagues) {
        for (League league : leagues) {
            if (league.getQueueType().equals("RANKED_SOLO_5x5")) {
                return league;
            }
        }
        return null;
    }
}
