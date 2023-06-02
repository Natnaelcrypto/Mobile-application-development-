import mongoose from 'mongoose';

export const TaskSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  detail: {
    type: String,
    required: true,
  },
  status: {
    type: Boolean,
    required: true,
  },
  assgined_to: {
    type: String,
    required: true,
  },
  farmname: {
    type: String,
    required: true,
  },
  date_created: {
    type: String,
    default: Date.now,
  },
  due_date: {
    type: String,
    required: true,
  },
});

export class Task {
  title: string;
  detail: string;
  status: boolean;
  assgined_to: string;
  date_created: Date;
  due_date: String;
  farmname: String;
}
