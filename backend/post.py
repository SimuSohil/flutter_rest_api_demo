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

if(__name__ == '__main__'):
    app.run(debug=True)
