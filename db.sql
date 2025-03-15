create database retaurant;
use retaurant;

creat table tables{
    id int primary key auto_increment,
    locations int not null,
    hourvalues real not null,
}

create table clients{
    id int primary key auto_increment,
    names varchar(100) not null,
    email varchar(50) not null,
} 

create table products{
    id int primary key auto_increment,
    names varchar(100) not null,
    price real not null,
}

create table orders{
    id int primary key auto_increment,
    tid int not null,
    cid int not null,
    dates day not null,
    statu enun('reserved', 'canceled', 'open', 'payment', 'closed') not null,
    foreign key (tid) references tables(id),
    foreign key (cid) references clients(id),   
}

create table produtctsche{
    sid int not null,
    pid int not null,
    quntitys int not null,
    foreign key (pid) references products(id),
    foreign key (sid) references orders(id),
}