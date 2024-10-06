from flask import Flask, jsonify, request
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
    host="Simus-MacBook-Air.local",
    user="root",
    password="Simu@1305",
    database="flutterProjects"
)

@app.route('/post', methods=['POST'])
def add_user():
    data = request.get_json()
    
    name = data['name']
    email = data['email']
    
    cursor = db.cursor()
    
    try:
        cursor.execute("INSERT INTO users (name, email) values (%s, %s)", (name, email))
        db.commit()
        return jsonify({"message":"user added successfully"}), 200
    except:
        db.rollback()
        return jsonify({"error":"failed to add user to database"}), 500
    finally:
        cursor.close()

@app.route('/put/<int:id>', methods=['PUT'])
def update_user(id):
    data = request.get_json()
    
    name = data['name']
    email = data['email']
    
    cursor = db.cursor()
    
    try:
        # Update the user's information in the MySQL table
        cursor.execute('UPDATE users SET name=%s, email=%s WHERE id=%s', (name, email, id))
        db.commit()
        return jsonify({"message": "User updated successfully"}), 200
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

if(__name__ == '__main__'):
    app.run(debug=True, port=5050)
