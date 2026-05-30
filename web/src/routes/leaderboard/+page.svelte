<script lang="ts">
  const tabs = ['1v1', 'FFA', 'Teams'];
  let active = $state(tabs[0]);
</script>
<div class="m-12 p-6 bg-card border border-card-edge rounded-lg">
    <div class="flex bg-card-2 rounded w-fit">
    {#each tabs as tab}
        <button
        onclick={() => active = tab}
        class="px-4 py-2 font-bold rounded  transition-colors duration-200 {active === tab ? 'bg-primary text-black' : 'text-font hover:text-primary'}"
        >
        {tab}
        </button>
    {/each}
    </div>
</div>