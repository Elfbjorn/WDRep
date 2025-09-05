import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-hello',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './hello.html',
  styleUrl: './hello.scss'
})
export class Hello {}
