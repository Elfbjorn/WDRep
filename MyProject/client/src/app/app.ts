import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { HelloComponent } from './hello.component';
import { CommonModule } from '@angular/common';
import { CheckSsnComponent } from './check-ssn/check-ssn.component';
import { CreateIdentityComponent } from './create-identity/create-identity.component';
import { NgModule } from '@angular/core';



@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    HelloComponent,
    CheckSsnComponent,
    CreateIdentityComponent,
    CommonModule
  ],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {}
