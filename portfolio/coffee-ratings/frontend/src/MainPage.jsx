export default function MainPage({ user }) {
  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>Coffee Ratings</h1>
      <p>Welcome, {user.username}!</p>
    </div>
  );
}
