## Tech Stack

- Ruby-on-Rails
- ReactJS
- Typescript
- SQLite3

## Setup

#### Project clone
```bash
git clone git@github.com:jaemar/code-challenge.git
cd code-challenge
```

#### Backend (Ruby-on-Rails)
```bash
cd backend
bundle install
bin/rails db:prepare # db:create db:migrate db:seed
bin/rails server -p 3001 # run the backend api
```

#### Frontend (ReactJS + Typescript)
```bash
cd frontend
npm install
npm start # run the frontend
```

## Feature
- Cart Listing
- Cart Items Listing (or) Cart Details
- Add Product to Cart
- Product Listing


## Limitation
- No authentication
- No user authorization
- No checkout
- No payment gateway integration
- No adding of new products
- No adding of new discount and condition on products