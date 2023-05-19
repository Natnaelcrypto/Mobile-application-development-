import mongoose from 'mongoose';

export const farmSchema = new mongoose.Schema({
  farmName: {
    type: String,
    required: true,
  },
  userID: {
    type: String,
    required: true,
  },
  inventory: {
    type: String,
    required: true,
  },
});

export class Farm {
  farmName: string;
  userID: string;
  inventory: string;
}
