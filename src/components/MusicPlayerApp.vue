<template>
  <div class="music-player-app">
    <div class="music-player">
      <div class="player">
        <audio ref="audio" controls></audio>
        <div class="controls">
          <button @click="playPause">
            {{ isPlaying ? "Pause" : "Play" }}
          </button>
          <button @click="stop">Stop</button>
        </div>
      </div>
      <div class="playlist">
        <h2>Playlist</h2>
        <ul>
          <li v-for="(song, index) in playlist" :key="index">
            <button @click="playSong(index)">
              {{ song.title }}
            </button>
          </li>
        </ul>
      </div>
    </div>
    <div class="add-song">
      <h2>Ajouter une chanson</h2>
      <input v-model="newSong" placeholder="Entrez le titre de la chanson..."/>
      <button @click="addSong">Ajouter</button>
    </div>
  </div>
</template>
<script>

</script>
<style></style>