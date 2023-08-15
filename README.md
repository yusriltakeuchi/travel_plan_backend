# Travel Plan

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

Travel plan is a backend service to manage travel plan, user can create and get list of travel plan.

### Features
- Auth System (Register, Login, Profile)
- Create, Get List & Detail Travel
- Support Auth Middleware using JWT
- Password Protection using Bcrypt
- MVC

## API Endpoint
Berikut adalah daftar endpoint yang tersedia dalam API ini berserta deskripsi dan contoh permintaan.

| Endpoint         | Description                                 | Example Request                                     | Authorization                                     |
|------------------|-------------------------------------------|-------------------------------------------------------|-------------------------------------------------------|
| `/api/auth/register`         | Register new user.           | `POST /api/auth/register`                                          | NO                                          |
| `/api/auth/login`    | Login using an account.  | `POST /api/login`                                        | NO                                          |
| `/api/profile`         | Get Profile account.          | `GET /api/profile`                                          | YES                                          |
| `/api/travel`    | Create a new travel plan. | `POST /api/travel`                                        | YES                                          |
| `/api/travel`      | Get list of travel plan.           | `GET /api/travel`                                       | NO                                          |
| `/api/travel/{id}` | Get travel plan based on ID.  | `GET /api/travel/4b53732c-6efc-423c-91aa-607c5c6b8976`                                    | NO                                          |
| ...              | ...                                       | ...                                                   | ...                                                   |

### API DOCUMENTATION
https://documenter.getpostman.com/view/11047949/2s9Xy6pUnC

### Sample SQL
1. Create database with name 'travel'
2. Import the sql file from sample_sql/travel.sql
3. Run the backend service using 'dart_frog dev'

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis