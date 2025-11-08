import React, { useState } from 'react';
import Login from './Login.jsx';
import MainPage from './MainPage.jsx';

export default function App() {
  const [user, setUser] = useState(null); // null = not logged in

  return (
    <div>
      {user ? (
        <MainPage user={user} />
      ) : (
        <Login onLogin={(userData) => setUser(userData)} />
      )}
    </div>
  );
}
