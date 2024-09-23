## Crypto Staking Platform Database

This project defines the database schema for a **Crypto Staking Platform**. The database is designed using SQL with various tables, relationships, and triggers to manage user data, wallets, staking packages, referral programs, and income levels efficiently. Below is an overview of the project's structure and functionality.

### 1. **Users Table**
   - Stores information about platform users, including their username, email, referral information, and account status.
   - A **trigger** is created to automatically create a wallet for each new user upon registration.

### 2. **Wallet Table**
   - Tracks each user’s available, reserved balances, and various income sources such as ROI, referral, and rewards.
   - Supports cascading updates and deletions based on the corresponding user.

### 3. **Packages Table**
   - Holds information on staking packages, including the package name, amount, period, daily ROI (Return on Investment), and its status.

### 4. **User Membership Table**
   - Records which staking package a user has subscribed to, along with the membership start date and details about received ROI and the next payment date.

### 5. **ROI Income Table**
   - Logs the ROI received by users, with a **trigger** to update the user's wallet balance when new ROI income is recorded.

### 6. **User Referral Table**
   - Manages the user referral system by linking users who refer others and records referral income.
   - A **trigger** automatically updates the wallet with referral income.

### 7. **Levels and Level Income Tables**
   - The levels table defines different levels users can reach based on points.
   - The level income table records earnings users receive from their downline based on the level system, with triggers updating wallets accordingly.

### 8. **Rewards and User Rewards Tables**
   - Defines the reward system where users can earn rewards by reaching certain business milestones.
   - Triggers update users' wallets when a reward is granted.

### 9. **Transactions Table**
   - Logs all transactions within the wallet, including opening balance, closing balance, credit, debit, type of income, and transaction status.

### Triggers:
- Various triggers are defined to ensure that whenever certain actions happen (e.g., ROI income, referral income), the user’s wallet is updated automatically without manual intervention.

This project represents a comprehensive approach to managing a **crypto staking platform**, handling everything from user registration and wallet creation to managing staking packages, referral systems, and reward mechanisms. It ensures that income calculations (ROI, referral, level, and rewards) are automated using triggers, and relationships between users, wallets, packages, and rewards are maintained with foreign key constraints. 

### Technologies:
- SQL
- MySQL Database
- Triggers for automation

