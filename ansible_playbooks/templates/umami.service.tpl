[Unit]
Description=Umami
Documentation=https://umami.is/docs/about
After=network.target

[Service]
Type=simple
User={{ user }}
WorkingDirectory={{ umami_dir }}
ExecStart=/usr/bin/sudo /usr/local/bin/yarn start
Restart=on-failure
Environment=DATABASE_URL=postgresql://{{ db_username }}:{{ db_password }}@{{ db_host }}:5432/{{ db_name }}
Environment=HASH_SALT={{ db_name }}{{ db_host }}{{ db_username }}
Environment=NODE_ENV={{ node_env }}
Environment=NODE_PORT={{ node_port }}

[Install]
WantedBy=multi-user.target
