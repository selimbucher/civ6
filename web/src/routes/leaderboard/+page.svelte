<script lang="ts">
  const tabs = ['All', 'FFA', 'Teams', '1v1'];
  let active = $state(tabs[0]);

  let { data } = $props();
</script>

<div class="m-12 p-6 bg-card border border-card-edge rounded-lg">
  <div class="flex rounded w-fit">
    {#each tabs as tab}
      <button
        onclick={() => active = tab}
        class="px-4 py-2 font-bold rounded transition-colors duration-200 {active === tab ? 'bg-primary text-black' : 'text-font hover:text-font-clear cursor-pointer hover:bg-card-2'}"
      >
        {tab}
      </button>
    {/each}
  </div>

  <div class="mt-6">
    {#each data.players as player}
      <div class="py-2 text-font">{player.name}</div>
    {/each}
  </div>
</div>