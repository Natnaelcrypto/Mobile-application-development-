import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Task } from './task.model';

@Injectable()
export class TaskService {
  constructor(@InjectModel('Task') private TaskModel: Model<Task>) {}

  async create(task: Task) {
    if (!task.detail || !task.title) {
      throw new BadRequestException('All fildes are requierd');
    }
    const newTask = new this.TaskModel({
      title: task.title,
      detail: task.detail,
      status: task.status,
      farmname: task.farmname,
      due_date: task.due_date,
      assgined_to: task.assgined_to,
    }).save();
    return newTask;
  }

  async findAll(farmname: any) {
    return this.TaskModel.find({ farmname: farmname });
  }

  async findOne(id: string) {
    return this.TaskModel.find({ userID: id });
  }



  async update(id: any, task: Task) {
    console.log(task, id);
    const oldTask = await this.TaskModel.findById(id);
    if (task.detail) {
      oldTask.detail = task.detail;
    }
    if (task.title) {
      oldTask.title = task.title;
    }
    if (task.status) {
      oldTask.status = task.status;
    }
    if (task.assgined_to) {
      oldTask.assgined_to = task.assgined_to;
    }
    if (task.farmname) {
      oldTask.farmname = task.farmname;
    }
    if (task.due_date) {
      oldTask.due_date = task.due_date;
    }

    return oldTask.save();
  }

  async remove(id: string) {
    return this.TaskModel.findByIdAndDelete(id);
  }
}
