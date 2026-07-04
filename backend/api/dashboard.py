from fastapi import APIRouter, Depends
from core.auth import get_current_user

router = APIRouter(tags=["Dashboard"])

@router.get("/dashboard")
async def get_dashboard(current_user: dict = Depends(get_current_user)):
    # Return mock data for now
    return {
        "user": {
            "name": current_user.get("username", "User")
        },
        "cycle": {
            "day": 14,
            "total": 28,
            "nextPeriodDays": 14
        },
        "insights": {
            "mhs": 82,
            "cvi": "Low",
            "sleepHours": "7.2h"
        }
    }