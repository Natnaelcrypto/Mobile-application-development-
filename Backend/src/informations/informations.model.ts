import mongoose from "mongoose";

export const InformationSchema = new mongoose.Schema({
  bread: {
    type: String,
    required: true,
  },
  age: {
    type: Number,
    required: true,
  },
  detaile: {
    type: {},
    required: true,
  },
});

export class Info {
  bread: string;
  age: number;
  detail: {} ;
}
