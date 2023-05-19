import mongoose from 'mongoose';

export const herdSchema = new mongoose.Schema({
  farmID: {
    type: String,
    required: true,
  },
  herdID: {
    type: String,
    required: true,
  },
  age: {
    type: Number,
    required: true,
  },
  bread: {
    type: String,
    required: true,
  },
  health_history: {
    type: String,
    required: true,
  },
  vaccination: {
    type: String,
    required: true,
  },
  medication: {
    type: String,
    required: true,
  },
  pregnancy: {
    type: String,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
});

export class Herd {
  farmID: string;
  herdID: string;
  age: number;
  bread: string;
  health_history: string;
  vaccination: string;
  medication: string;
  pregnancy: string;
  gender: string;
}
