import React, {Component} from 'react';
// Anywhere you write JSX tags, React must be
// imported, because JSX tags are translated
// to React.createElement(...) calls.
// import {QuestionShowPage} from './QuestionShowPage';
// import {QuestionIndexPage} from './QuestionIndexPage';
// import {QuestionNewPage} from './QuestionNewPage';
// import {SignInPage} from './SignInPage';
// import {NotFoundPage} from './NotFoundPage';
// When importing a directory, the import will actually
// look for a file named `index.js` inside of it and
// import that instead.
// import {NotFoundPage} from './pages';
// import {HomePage} from './HomePage';
import {
  QuestionShowPage,
  QuestionIndexPage,
  QuestionNewPage,
  SignInPage,
  HomePage,
  NotFoundPage
} from './pages';
import {NavBar} from './NavBar';
import {AuthRoute} from './AuthRoute';
import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';
import jwtDecode from 'jwt-decode';

//
// import {Token} from '../requests/tokens';

// function App () {
class App extends Component {
  constructor (props) {
    super(props);

    this.state = {
      user: null,
      loading: true
    };
    this.signIn = this.signIn.bind(this);
    this.signOut = this.signOut.bind(this);
  }

  signOut () {
    localStorage.removeItem('jwt');
    this.setState({user: null});
  }

  signIn () {
    const jwt = localStorage.getItem('jwt');
    if (jwt) {
      const payload = jwtDecode(jwt);
      // this.setState({user: payload});
      this.setState({user: payload, loading: false});
    } else {
      this.setState({loading: false});
    }
  }

  componentDidMount () {
    this.signIn();
  }

  isAuth () {
    return !!this.state.user
  }

  render () {
    // const {user} = this.state;
    const {user, loading} = this.state;

    if (loading) {
      return (
        <div>
          Loading...
        </div>
      );
    }

    // window.Token = Token;
    // The <Switch> component is used with <Route> children.
    // It will force only one route children to render at a time.
    // Only the first <Route> that matches will render.
    return (
      // <Router>
      <Router basename="/client">
        <div className="App">
          {/* <nav>
            <CurrentDateTime />
            <Link to="/">Home</Link>
            <Link to="/questions">Questions</Link>
          </nav> */}
          {/* <QuestionIndexPage />
            <QuestionShowPage /> */}
            <NavBar
              user={user}
              onSignOutClick={this.signOut}
            />
            <Switch>
              <Route exact path="/" component={HomePage} />
              <Route path="/sign_in" render={props => {
                return <SignInPage {...props} onSignIn={this.signIn} />
              }} />
                 {/* <Route path="/questions" exact component={QuestionIndexPage} /> */}
              {/* <Route path="/questions/new" component={QuestionNewPage} />
              <Route path="/questions/:id" component={QuestionShowPage} /> */}
              <AuthRoute
                isAuthenticated={this.isAuth()}
                path="/questions"
                exact component={QuestionIndexPage}
              />
              <AuthRoute
                isAuthenticated={this.isAuth()}
                path="/questions/new"
                component={QuestionNewPage}
              />
              <AuthRoute
                isAuthenticated={this.isAuth()}
                path="/questions/:id"
                component={QuestionShowPage}
              />
              {/* <Route render={props => <div>Not Found</div>}/> */}
              {/*
                To match all routes that aren't matched in
                a Switch component, create a Route without
                a `path` prop. We can use it to implement a 404
                page.
               */}
              <Route component={NotFoundPage} />
            </Switch>
        </div>
      </Router>
    );
  }
}


// import App from './App';
// ð will make the value at App available by importing with ð
// in other files.
export default App;
