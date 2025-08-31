import { Component } from '@angular/core';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatTableModule } from '@angular/material/table';
import { ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-check-ssn',
  templateUrl: './check-ssn.component.html',
  styleUrls: ['./check-ssn.component.scss'],
  standalone: true,
  imports: [
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatProgressBarModule,
    MatTableModule,
    ReactiveFormsModule,
    CommonModule
  ]
})
export class CheckSsnComponent {
  ssnForm;
  result: any = null;
  notFound = false;
  loading = false;

  constructor(
    private fb: FormBuilder,
    private http: HttpClient,
    private router: Router
  ) {
    this.ssnForm = this.fb.group({
      ssn: ['', [Validators.required]]
    });
  }

  maskSSN(ssn: string | null | undefined): string {
    if (!ssn) return '';
    const digits = ssn.replace(/\D/g, '');
    if (digits.length !== 9) return ssn;
    return `${digits.slice(0,3)}-${digits.slice(3,5)}-${digits.slice(5)}`;
  }

  onSubmit() {
    if (this.ssnForm.invalid) return;
    this.loading = true;
    const ssn = this.maskSSN(this.ssnForm.value.ssn);
    this.http.get(`/api/coreidentity/by-ssn/${ssn}`).subscribe({
      next: (data: any) => {
        this.result = data;
        this.notFound = !data;
        this.loading = false;
      },
      error: () => {
        this.result = null;
        this.notFound = true;
        this.loading = false;
      }
    });
  }

  continue(yes: boolean) {
    if (yes) {
      this.router.navigate(['/create-identity'], { state: { ssn: this.ssnForm.value.ssn } });
    } else {
      this.ssnForm.reset();
      this.result = null;
      this.notFound = false;
      localStorage.clear();
      document.cookie = '';
    }
  }

  cancel() {
    this.ssnForm.reset();
    this.result = null;
    this.notFound = false;
    localStorage.clear();
    document.cookie = '';
  }
}
