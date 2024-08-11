import net from 'node:net';

import { spawn } from 'node:child_process';

// Create TCP server
const server = net.createServer((socket) => {
	console.log('Client connected');

	// Event when receiving data from the client
	socket.on('data', (data) => {
		console.log('Data received:', data.toString());

		// Send data back to the client
		socket.write('Data received by the server: ' + data.toString());
	});

	// Event when the client connection is closed
	socket.on('close', () => {
		console.log('Client disconnected');
	});

	// Handle connection errors
	socket.on('error', (err) => {
		console.error('Connection error:', err);
	});
});

server.listen(0, () => {
	console.log(`TCP server started on port ${server.address().port}`);
});

const game = spawn('./src/routes/projects/hs2048/hs2048', ['-p', '5555']);
