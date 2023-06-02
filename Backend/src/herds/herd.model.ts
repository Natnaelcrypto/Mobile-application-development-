import mongoose from 'mongoose';

export const herdSchema = new mongoose.Schema({
  farmname: {
    type: String,
    required: true,
  },
  herdID: {
    type: String,
    required: true,
  },
  age: {
    type: String,
    required: true,
  },
  bread: {
    type: String,
    required: true,
  },
  health_history: {
    type: [],
    required: true,
  },
  vaccination: {
    type: [],
    required: true,
  },
  medication: {
    type: [],
    required: true,
  },
  pregnancy: {
    type: [],
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
});

export class Herd {
  farmname: string;
  herdID: string;
  age: string;
  bread: string;
  health_history: [];
  vaccination: [];
  medication: [];
  pregnancy: [];
  gender: string;
}
