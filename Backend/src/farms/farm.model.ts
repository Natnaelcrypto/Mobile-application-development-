import mongoose from 'mongoose';

export const farmSchema = new mongoose.Schema({
  farmName: {
    type: String,
    required: true,
  },
  itemName: {
    type: String,
    default: '',
    required: true,
  },
  dosage: {
    type: String,
    default: '',
  },
  instructions: {
    type: String,
    default: '',
  },
  brand: {
    type: String,
    default: '',
  },
  type: {
    type: String,
    default: '',
  },
  expirationDate: {
    type: String,
    default: Date.now,
  },
  userID: {
    type: String,
    required: true,
  },
  isfeed: {
    type: Boolean,
    required: true,
  },
  ismedication: {
    type: Boolean,
    required: true,
  },
  quantity: {
    type: String,
    required: true,
  },
});

export class Farm {
  farmName: string;
  userID: string;
  expirationDate: string;
  itemName: string;
  dosage: string;
  instructions: string;
  brand: string;
  type: string;
  isfeed: boolean;
  ismedication: boolean;
  quantity: string;
}
