
import { Component, Output, EventEmitter, Input } from '@angular/core';

@Component({
  selector: 'app-hamburger-menu',
  standalone: true,
  templateUrl: './hamburger-menu.component.html',
  styleUrls: ['./hamburger-menu.component.scss']
})
export class HamburgerMenuComponent {
  @Input() menuOpen = false;
  @Output() menuOpenChange = new EventEmitter<boolean>();
  @Output() hirePersonnel = new EventEmitter<void>();

  toggleMenu() {
    this.menuOpen = !this.menuOpen;
    this.menuOpenChange.emit(this.menuOpen);
  }

  onHirePersonnel() {
    this.hirePersonnel.emit();
    this.menuOpen = false;
    this.menuOpenChange.emit(false);
  }
}
