import pytest
from app import backend/app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}

def test_users(client):
    response = client.get("/users")
    assert response.status_code == 200
    assert response.get_json() == {"users": ["Alice", "Bob", "Charlie"]}
