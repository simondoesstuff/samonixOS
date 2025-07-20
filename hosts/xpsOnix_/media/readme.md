# Media info

## VPN

For the torrent client to work, you need to add an ovpn file into the config for the ovpn service.

## Undeclarative setup

Sadly some of the stuff isn't fully declarative. Below is all the manual things that must be done.

### Setup prowlarr

In prowlarr add indexers that seem inticing. Then they can be synced to sonarr and radio simultaneously.

### Setup sonarr/radarr

In sonarr and radarr, go into settings and add transmission as the download client.

- When setting transmission, set the "category" to `sonarr` for sonarr and `radarr` for radarr.

Further, if wanted, setup a bunch of custom filters as seen in [this guide](https://trash-guides.info/Radarr/radarr-setup-quality-profiles-anime/https://trash-guides.info/Radarr/radarr-setup-quality-profiles-anime/). This is the most manuly intensive part and can take a while depending on how many custom filters you want to add.

### Setup jellyfin

1. Sign up and log in
2. In the dashboard set up the librariers for

```
/srv/media/movies
/srv/media/shows
/srv/media/anime
```

3. Add custom plugins like intro-skip and whatnot.
