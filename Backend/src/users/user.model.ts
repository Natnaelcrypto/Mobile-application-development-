import mongoose from 'mongoose';

export const UserSchema = new mongoose.Schema({
  fristName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  userName: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  Role: {
    type: String,
    required: true,
  },
  farmName: {
    type: String,
    required: true,
  },
});

export class User {
  farmName: string;
  fristName: string;
  lastName: string;
  password: string;
  userName: string;
  Role: string;
}

