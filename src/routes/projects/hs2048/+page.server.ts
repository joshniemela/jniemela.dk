import { v4 as uuid } from 'uuid';

export function load({ cookies }) {
	let userId = cookies.get('uuid');
	if (!userId) {
		userId = uuid();
		cookies.set('uuid', userId, { path: '/' });
	}
	return { userId };
}
