/* global fetch */
import {BASE_URL} from './config';

// const API_KEY = 'e15e969c33fe0c3a41f0dd21f1b1382b0d2c5d7b30d9721156955ed36f82b3eb';

function getJwt () {
  return `JWT ${localStorage.getItem('jwt')}`;
}

// HTTP REQUESTS

// export {Question}
// ð is like ð
// You export any variable, function or class as you
// declare them.
export const Question = {
  all () {
    return fetch(
      `${BASE_URL}/api/v1/questions`,
      {
        headers: {
          // 'Authorization': API_KEY
          'Authorization': getJwt()
        }
      }
    )
    .then(res => res.json())
  },
  get (id) {
    return fetch(
      `${BASE_URL}/api/v1/questions/${id}`,
      {
        headers: {
          // 'Authorization': API_KEY
          'Authorization': getJwt()
        }
      }
    )
      .then(res => res.json())
  },
  create (params) {
    // params should be an object containing
    // attributes to create the question.
    // {title: 'Where are you?', body: 'Canada, US, UK, etc.'}
    return fetch(
      `${BASE_URL}/api/v1/questions`,
      {
        method: 'POST',
        headers: {
          // 'Authorization': API_KEY,
          'Authorization': getJwt(),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
      }
    )
    .then(res => res.json());
  }
}

// window.Question = Question;
// it's possible to use Question.all() for example
