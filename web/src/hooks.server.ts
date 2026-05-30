import type { Handle } from '@sveltejs/kit';

export const handle: Handle = async ({ event, resolve }) => {
	if (event.url.pathname.startsWith('/api')) {
		const url = `http://localhost:8080${event.url.pathname}${event.url.search}`;
		return fetch(url, {
			method: event.request.method,
			headers: event.request.headers,
			body: event.request.body,
		});
	}
	return resolve(event);
};