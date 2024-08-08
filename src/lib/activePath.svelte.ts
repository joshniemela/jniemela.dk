export function createActivePath(root: string) {
	let activePath: string[] = $state([root]);

	return {
		get activePath() {
			return activePath;
		},

		setActivePath(path: string[]) {
			activePath = path;
		}
	};
}
