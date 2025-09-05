


import { Component, signal } from '@angular/core';
import { Router, RouterOutlet } from '@angular/router';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { HamburgerMenuComponent } from './hamburger-menu.component';


@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, MatToolbarModule, MatButtonModule, HamburgerMenuComponent],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  protected readonly title = signal('client');
  menuOpen = false;

  constructor(private router: Router) {}

  navigateToCheckSsn() {
    localStorage.removeItem('ssn_token');
    this.router.navigate(['/check-ssn']);
  }

  onMenuNavigate(link: string) {
    if (link) {
      // Remove leading slash if present, then navigate
      const route = link.startsWith('/') ? link : `/${link}`;
      this.router.navigate([route]);
    }
  }
}
