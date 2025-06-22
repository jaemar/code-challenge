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
bundle install
bin/rails db:prepare # db:create db:migrate db:seed
bin/rails server # run the backend api
```

#### Frontend (ReactJS + Typescript)
```bash
cd frontend
npm install
npm start # run the frontend
```

### Limitation
- No authentication
- No user authorization
- No checkout
- No payment gateway integration
- 