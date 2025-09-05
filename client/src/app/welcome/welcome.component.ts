import { Component } from '@angular/core';
import { HamburgerMenuComponent } from '../hamburger-menu.component';

@Component({
  selector: 'app-welcome',
  standalone: true,
  imports: [HamburgerMenuComponent],
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.scss']
})
export class WelcomeComponent {}
