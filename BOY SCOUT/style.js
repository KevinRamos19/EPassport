<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Eagle Scout Dashboard</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="container">
    <div class="header">
      <img src="logo.png" alt="Logo">
      <img src="profile.png" alt="Profile">
    </div>

    <div class="welcome">
      <p>Hello, Scout! You're making great progress this month.</p>
      <small>Rank: Eagle Scout | Member ID: 0123</small>
    </div>

    <h3>Merit Badges</h3>
    <div class="badges">
      <button>1</button>
      <button>2</button>
      <button>3</button>
      <button>4</button>
      <button>5</button>
      <button>6</button>
      <button>7</button>
      <button>8</button>
    </div>

    <h3>Your Progress</h3>
    <div class="progress-bar">
      <label>Merit Badges</label>
      <progress value="70" max="100"></progress>
    </div>
    <div class="progress-bar">
      <label>Service Hours</label>
      <progress value="50" max="100"></progress>
    </div>
    <div class="progress-bar">
      <label>Leadership Points</label>
      <progress value="30" max="100"></progress>
    </div>

    <div class="events">
      <h3>Upcoming Events</h3>
      <ul>
        <li><strong>15 JUN:</strong> Summer Camp - 8:00 AM</li>
        <li><strong>21 JUN:</strong> Merit Badge Workshop</li>
        <li><strong>21 JUN:</strong> Community Service Project</li>
      </ul>
    </div>
  </div>
</body>
</html>
