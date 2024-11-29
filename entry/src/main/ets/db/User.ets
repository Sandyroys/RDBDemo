export class User {
  id?:number
  name: string;
  sex: string;
  age: number
  tel: string;
  constructor( name:string, sex:string, age:number, tel:string,id?:number ) {
    this.id = id
    this.name = name;
    this.sex = sex;
    this.age = age;
    this.tel = tel;
  }

  toString() {
    return  this.id + ' ' + this.name + ' ' + this.sex + ' ' + this.age + ' ' + this.tel + '\n';
  }
}
