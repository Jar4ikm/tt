
const request = require('supertest');
const app = require('./app'); // путь к app.js должен быть './app'

describe('GET /', function () {
  it('should respond with Hello World and status 200', function (done) {
    request(app)
      .get('/')
      .expect(200)
      .expect('Hello World', done);
  });
});

