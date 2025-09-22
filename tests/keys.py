from datetime import datetime
from python_src.utils.keys import s3_event_key

def test_builds_expected_prefix():
    fixed = datetime(2025, 8, 28)
    key = s3_event_key(dt=fixed, event_id="abc123")
    assert key == "events/dt=2025-08-28/event_abc123.json"

def test_generates_uuid_when_missing_id():
    fixed = datetime(2025, 8, 28)
    key = s3_event_key(dt=fixed)
    assert key.startswith("events/dt=2025-08-28/event_")
    assert key.endswith(".json")
