CREATE TABLE IF NOT EXISTS devices (
    id BIGSERIAL PRIMARY KEY,
    imei VARCHAR(15) UNIQUE NOT NULL,
    alias VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS device_config (
    device_id BIGINT PRIMARY KEY REFERENCES devices(id),
    mot_thr INTEGER DEFAULT 15,
    mot_dur INTEGER DEFAULT 20,
    report_interval_s INTEGER DEFAULT 30,
    cooldown_s INTEGER DEFAULT 120,
    heartbeat_h INTEGER DEFAULT 24,
    batt_alarm_pct INTEGER DEFAULT 25,
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS pending_commands (
    id BIGSERIAL PRIMARY KEY,
    device_id BIGINT REFERENCES devices(id),
    cmd_json JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    synced BOOLEAN DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS idx_devices_imei ON devices(imei);
CREATE INDEX IF NOT EXISTS idx_pending_device ON pending_commands(device_id);
