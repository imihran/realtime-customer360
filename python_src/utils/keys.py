from datetime import datetime
from typing import Optional
import uuid

def s3_event_key(dt: Optional[datetime] = None, event_id: Optional[str] = None) -> str:
    d = (dt or datetime.utcnow()).strftime("%Y-%m-%d")
    eid = event_id or str(uuid.uuid4())
    return f"events/dt={d}/event_{eid}.json"