import { Component, inject, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'hello-db',
  template: `
    <div style="display: flex; flex-direction: column; align-items: center; margin-top: 3rem;">
      <h1>Hello World</h1>
      <button mat-raised-button color="primary" (click)="checkDb()">Check Database Connection</button>
      <div *ngIf="status()" style="margin-top: 2rem; font-size: 1.2rem;">
        {{ status() }}
      </div>
    </div>
  `,
  standalone: true,
  imports: [CommonModule],
})
export class HelloComponent {
  private http = inject(HttpClient);
  status = signal<string | null>(null);

  checkDb() {
    this.http.get<{ status: string }>('/api/health/db-status').subscribe({
      next: res => this.status.set(res.status),
      error: () => this.status.set('Database is NOT reachable')
    });
  }
}
