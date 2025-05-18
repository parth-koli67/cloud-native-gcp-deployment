from flask import Flask, jsonify, request, render_template

app = Flask(__name__)

# In-memory data store (for simplicity, replace with a database in a real application)
todos = [
    {"id": 1, "task": "Learn Flask", "completed": False},
    {"id": 2, "task": "Build a Todo App", "completed": True},
]

next_id = 3  # Keep track of the next available ID


@app.route('/')
def index():
    """Renders the main page with the todo list."""
    return render_template('index.html', todos=todos)


@app.route('/todos', methods=['GET'])
def get_todos():
    """Returns all todos as a JSON array."""
    return jsonify(todos)


@app.route('/todos', methods=['POST'])
def create_todo():
    """Creates a new todo item."""
    global next_id  # Use the global next_id
    data = request.get_json()  # Get JSON data from the request body

    if not data or 'task' not in data:
        return jsonify({'error': 'Task is required'}), 400

    new_todo = {
        'id': next_id,
        'task': data['task'],
        'completed': False  # Default to incomplete
    }
    todos.append(new_todo)
    next_id += 1  # Increment for the next todo

    return jsonify(new_todo), 201  # Return the created todo with status 201 (Created)


@app.route('/todos/<int:todo_id>', methods=['GET'])
def get_todo(todo_id):
    """Returns a specific todo by ID."""
    todo = next((todo for todo in todos if todo['id'] == todo_id), None)  # Find the todo

    if todo is None:
        return jsonify({'error': 'Todo not found'}), 404

    return jsonify(todo)


@app.route('/todos/<int:todo_id>', methods=['PUT'])
def update_todo(todo_id):
    """Updates an existing todo item."""
    todo = next((todo for todo in todos if todo['id'] == todo_id), None)  # Find the todo

    if todo is None:
        return jsonify({'error': 'Todo not found'}), 404

    data = request.get_json()
    if not data:
        return jsonify({'error': 'No data provided for update'}), 400

    if 'task' in data:
        todo['task'] = data['task']
    if 'completed' in data:
        todo['completed'] = data['completed']

    return jsonify(todo)


@app.route('/todos/<int:todo_id>', methods=['DELETE'])
def delete_todo(todo_id):
    """Deletes a todo item."""
    global todos # Access and modify the global todos list

    original_length = len(todos)  # Store the original length
    todos = [todo for todo in todos if todo['id'] != todo_id]

    if len(todos) == original_length: # Check if any todo was actually removed
        return jsonify({'error': 'Todo not found'}), 404
    else:
        return jsonify({'message': 'Todo deleted successfully'}), 200



if __name__ == '__main__':
    app.run(debug=True)  # Enable debug mode for easier development
