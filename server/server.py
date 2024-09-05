from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import Mapped, mapped_column

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test.db'
db = SQLAlchemy(app=app)

class Product(db.Model):    
    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str] = mapped_column(nullable=False)
    price: Mapped[int] = mapped_column(nullable=False)
    rating: Mapped[int] = mapped_column(nullable=False)
    imageURL: Mapped[str] = mapped_column(nullable=False)
    modelURL: Mapped[str] = mapped_column()
    category: Mapped[str] = mapped_column(nullable=False)

@app.route('/api/products', methods=['GET'])
def get_products():
    products = Product.query.all()
    return jsonify([{
        'id': product.id,
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'rating': product.rating,
        'imageURL': product.imageURL,
        'modelURL': product.modelURL,
        'category': product.category
    } for product in products])

@app.route('/api/products', methods=['POST'])
def post_products():
    data = request.get_json()
    new_item = Product(
        title = data['title'],
        description = data['description'],
        price = data['price'],
        rating = data['rating'],
        imageURL = data['imageURL'],
        modelURL = data['modelURL'],
        category = data['category']
    )
    db.session.add(new_item)
    db.session.commit()
    return jsonify(
        {
            'id': new_item.id,
            'title': new_item.title,
            'description': new_item.description,
            'price': new_item.price,
            'rating': new_item.rating,
            'imageURL': new_item.imageURL,
            'modelURL': new_item.modelURL,
            'category': new_item.category
        }
    ), 201

@app.route('/api/products/removeAll', methods=['DELETE'])
def remove_all_products():
    Product.query.delete()
    db.session.commit()
    return '', 204

if __name__ == '__main__':
    app.app_context().push()
    db.create_all()
    app.run(debug=True, host='0.0.0.0', port=5000)