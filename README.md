# Career Guidance

## Overview
**Career Guidance** is a Flutter and Django-based application designed to assist users in making informed career choices. It provides personalized **course recommendations**, **CV analysis**, and other career-related functionalities to help users enhance their professional journey.

## Features
- **Course Recommendations**: Suggests relevant courses based on user skills and interests.
- **CV Analysis**: Evaluates resumes and provides insights for improvement.
- **Career Roadmap**: Guides users on their career path with tailored suggestions.
- **User Authentication**: Secure login and registration system.
- **Interactive UI**: Engaging and intuitive design for seamless navigation.

## Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Django (Python)
- **Database**: PostgreSQL / SQLite
- **API**: Django REST Framework (DRF)

## Installation & Setup
### Prerequisites
Ensure you have the following installed:
- **Flutter** (latest version)
- **Django & Python** (latest version)
- **PostgreSQL / SQLite**

### Backend Setup (Django)
1. Clone the repository:
   ```sh
   git clone https://github.com/naveencule/career.git
   cd career_backend
   ```
2. Create a virtual environment:
   ```sh
   python -m venv venv
   source venv/bin/activate  # On Windows, use venv\Scripts\activate
   ```
3. Install dependencies:
   ```sh
   pip install -r requirements.txt
   ```
4. Run migrations:
   ```sh
   python manage.py migrate
   ```
5. Start the Django server:
   ```sh
   python manage.py runserver
   ```

### Frontend Setup (Flutter)
1. Navigate to the Flutter project directory:
   ```sh
   cd career_flutter
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

## API Endpoints
| Endpoint                | Method | Description |
|-------------------------|--------|-------------|
| `/api/auth/register/`   | POST   | User registration |
| `/api/auth/login/`      | POST   | User login |
| `/api/courses/recommend/` | GET  | Get recommended courses |
| `/api/cv/analyze/`      | POST   | Analyze uploaded CV |

## Contribution
We welcome contributions! Follow these steps:
1. Fork the repository.
2. Create a new branch (`feature-branch`).
3. Commit your changes.
4. Push to the branch and create a pull request.

## License
This project is licensed under the **MIT License**.

## Contact
For any queries or support, contact **Naveen** at [naveesanthosh200@gmail.com](mailto:naveesanthosh200@gmail.com).

