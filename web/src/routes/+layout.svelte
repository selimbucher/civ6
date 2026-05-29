<script lang="ts">
	import './layout.css';
	import favicon from '$lib/assets/favicon.svg';

	let { children } = $props();
</script>

<svelte:head><link rel="icon" href={favicon} /></svelte:head>
<nav class="flex w-full gap-4 justify-center p-4">
	<a href=/leaderboard class="text-l hover:text-primary">Leaderboard</a>
	<a href=/matches class="text-l hover:text-primary">Matches</a>
	<a href=/stats class="text-l hover:text-primary">Stats</a>
	<a href=/achievements class="text-l hover:text-primary">Achievements</a>
</nav>
{@render children()}
