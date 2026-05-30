<script lang="ts">
	import './layout.css';
	import favicon from '$lib/assets/favicon.svg';

	const links = [
		{ href: '/leaderboard', label: 'Leaderboard' },
		{ href: '/matches', label: 'Matches' },
		{ href: '/stats', label: 'Stats' },
		{ href: '/achievements', label: 'Achievements' },
	];

	let { children } = $props();
</script>

<svelte:head><link rel="icon" href={favicon} /></svelte:head>
<nav class="flex w-full gap-6 justify-center p-6">
	{#each links as link}
		<a href={link.href} class="relative text-m font-semibold tracking-wide hover:text-font-clear transition-colors duration-200 ease-in-out group">
			{link.label}
			<span class="absolute bottom-0 left-0 w-full h-px bg-font-clear scale-x-0 group-hover:scale-x-100 transition-transform duration-200 ease-in-out"></span>
		</a>
	{/each}
</nav>
{@render children()}