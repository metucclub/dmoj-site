process.env['server_name'] = process.env['server_name'] || '0.0.0.0';

module.exports = {
	get_host: process.env['server_name'],
	get_port: 15100,
	post_host: process.env['server_name'],
	post_port: 15101,
	http_host: process.env['server_name'],
	http_port: 15102,
	long_poll_timeout: 29000,
};