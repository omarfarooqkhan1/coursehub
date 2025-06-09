# CourseHub - A Course Subscription Application

## 📘 Introduction

This project is a prototype ServiceNow application that allows **learners to view and subscribe to courses**. It was built as part of a technical assessment using the **ServiceNow Platform** and **UI Builder**, following best practices in data modeling and client-side logic.

---

## ✅ Implemented Features

### PRD01: Course List
- Displayed a list of available courses using a Data Resource and Repeater.
- Course details include: **Title**, **Description**, and **Duration**.
- Each course card includes a **Subscribe/Unsubscribe** button based on the learner's current subscription status.

### PRD02: Course Subscription
- When the **Subscribe** button is clicked:
  - User gets a confirmation modal with **Yes/No** buttons
  - When the **Yes** button is clicked:
    - A new record is created in the `Course Subscription` table for the logged in user.
    - UI dynamically changes the Subscibe button based on learner’s existing subscription.
- When the **Unsubscribe** button is clicked:
  - User gets a modal with coming soon mentioned (Not implemented because **Learner** cannot unsubscribe).
- Prevents duplicate subscriptions by conditionally showing **Subscribe** and **Unsubscribe** buttons.

---

## 🔐 Learner Login Simulation

- Users can simulate login by typing their name and selecting the account from the dropdown.
- Upon login, the selected learner’s `sys_id` is stored in a **Client State Parameter** (`learnerId`) which is passed to the next page (`/courses`) as a query parameter.
- Redirects to the Course List page with learner context preserved.

---

## 🚦 Navigation Flow

1. **Login Page**:
   - Select a learner from the dropdown (with search functionality).
   - Click **Login** to save learner ID and redirect.
2. **Course List Page**:
   - Courses are displayed with Subscribe/Unsubscribe options.
   - Learner interactions update the subscription model accordingly.

---

## ❌ Not Implemented

- Learner cannot Unsubscribe (as per business rule restriction)
- No authentication or sys_user-level login (simulated via dropdown)
- Robot Framework test automation suite

---

## 🛠️ Technical Summary

| Component         | Technology                     |
|------------------|---------------------------------|
| Backend           | ServiceNow Tables (`x_quo_coursehub_course, x_quo_coursehub_learner, x_quo_coursehub_course_subscription`) |
| Frontend          | UI Builder (Workspace Experience) |
| Logic             | Client State Parameters, Client Scripts, Events, Page Query Parameters |
| Data Handling     | Data Resources (Record List)   |

---

## 🖼️ Screenshots

Please refer to the `/screenshots` folder for:
- Learner Login view with login button disabled (login-screenshot-1)
- Learner Login view when user searches for their account (login-screenshot-2)
- Learner Login view when user searches selects their account (login-screenshot-3)
- List of available courses (prd01-screenshot-1)
- Course subscription feature (prd02-screenshot-2)
- Unsubscribe feature coming soon (prod2-screenshot-3)
- Logout button on available courses page (prd01-screenshot-1)