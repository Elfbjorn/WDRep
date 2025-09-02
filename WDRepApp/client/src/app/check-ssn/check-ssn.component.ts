import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { maskSsn } from '../utils/masking.utils';
@Component({
  selector: 'app-check-ssn',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './check-ssn.component.html',
  styleUrls: ['./check-ssn.component.scss']
})
export class CheckSsnComponent implements OnInit {
  ssnForm!: FormGroup;
  error: string | null = null;
  result: any = null;
  loading = false;

  constructor(private fb: FormBuilder, private http: HttpClient, private router: Router) {}

  ngOnInit() {
    this.ssnForm = this.fb.group({
      ssn: ['', [Validators.required, Validators.pattern(/^\d{3}-?\d{2}-?\d{4}$/)]]
    });
  }


  submit() {
    // 1. Reset state
    this.error = null;
    this.result = null;
    this.loading = false;

    // 2. Validate input
    if (this.ssnForm.invalid) {
      this.error = 'Please enter a valid SSN.';
      this.ssnForm.markAllAsTouched();
      return;
    }

    // 3. Normalize SSN: remove all non-digits
    const raw = this.ssnForm.value.ssn || '';
    const normalized = raw.replace(/[^0-9]/g, '');
    if (normalized.length !== 9) {
      this.error = 'Please enter a valid SSN.';
      return;
    }

    // 4. Send to API
    this.loading = true;

    this.http.post('/api/identity/check-ssn', JSON.stringify(normalized), { headers: { 'Content-Type': 'application/json' } }).subscribe({
      next: (res: any) => {
        this.loading = false;
        // 5. Check result contract (triple check)
        if (res && typeof res === 'object' && 'found' in res) {
          this.result = res;
        } else {
          this.result = { found: false };
        }
      },
      error: (err: any) => {
        this.loading = false;
        let errMsg = 'An unexpected error occurred while checking the SSN.';
        if (typeof err.error === 'string' && err.error) {
          errMsg = err.error;
        } else if (err.error && err.error.message) {
          errMsg = err.error.message;
        } else if (err.message) {
          errMsg = err.message;
        } else {
          errMsg = JSON.stringify(err.error) || 'Error occurred.';
        }
        this.error = errMsg;
      }
    });
  }

  onBlur() {
    const ssnControl = this.ssnForm.get('ssn');
    if (ssnControl && ssnControl.value) {
      const raw = ssnControl.value || '';
      const normalized = raw.replace(/[^0-9]/g, '');
      if (normalized.length === 9) {
        const formatted = `${normalized.slice(0,3)}-${normalized.slice(3,5)}-${normalized.slice(5)}`;
        // Set value without triggering another blur/valueChange cycle
        ssnControl.setValue(formatted, { emitEvent: false });
      }
    }
  }


  proceed() {
    // Store the SSN token if present (for new identities)
    if (this.result && this.result.token) {
      sessionStorage.setItem('ssn_token', this.result.token);
    } else {
      sessionStorage.removeItem('ssn_token');
    }
    this.router.navigate(['/create-identity']);
  }

  protected readonly maskSsn = maskSsn;
  reset() {
    this.ssnForm.reset();
    this.error = null;
    this.result = null;
    this.loading = false;
  }
}
