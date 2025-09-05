
import { Component, Output, EventEmitter, Input, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-hamburger-menu',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './hamburger-menu.component.html',
  styleUrls: ['./hamburger-menu.component.scss']
})
export class HamburgerMenuComponent implements OnInit {
  @Input() menuOpen = false;
  @Output() menuOpenChange = new EventEmitter<boolean>();
  @Output() menuNavigate = new EventEmitter<string>();

  menuItems: any[] = [];
  headers: any[] = [];
  loading = false;
  error: string | null = null;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.fetchMenu();
  }

  fetchMenu() {
    this.loading = true;
    this.http.get<any[]>('/api/menu').subscribe({
      next: (data) => {
        this.menuItems = data;
        this.headers = data.filter(h => h.menuitemtypename === 'Header');
        this.loading = false;
      },
      error: (err) => {
        this.error = 'Failed to load menu.';
        this.loading = false;
      }
    });
  }

  getChildren(headerId: number) {
    return this.menuItems.filter(i => i.menuitemtypename === 'Item' && i.parentid === headerId);
  }

  toggleMenu() {
    this.menuOpen = !this.menuOpen;
    this.menuOpenChange.emit(this.menuOpen);
  }

  onMenuNavigate(link: string) {
    this.menuNavigate.emit(link);
    this.menuOpen = false;
    this.menuOpenChange.emit(false);
  }
}
