import json
from flask import request
from application import app
from models.user import User

# query parameter
@app.route('/tasks', methods=['GET'])
def query_tasks():
    users = User.query.all()
    print(users[0].to_dict())
    id = request.args.get("id")
    return id

@app.route('/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id=None):
    return "get" + str(task_id)

@app.route('/tasks', methods=['POST'])
def create_task():
    req_body = json.loads(request.data)
    return req_body

@app.route('/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id=None):
    return "update" + str(task_id)

@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id=None):
    return "delete" + str(task_id)


if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080, debug=True)
