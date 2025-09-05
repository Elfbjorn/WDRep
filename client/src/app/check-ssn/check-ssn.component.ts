import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { maskSsn } from '../utils/masking.utils';
import { DefaultItemService, DefaultItem } from '../utils/default-item.service';
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

  // Navigation links from menu
  nextLink: string = '/create-identity';
  cancelLink: string = '/home';
  previousLink: string | null = null;
  nextLinkText: string = 'Next';
  cancelLinkText: string = 'Cancel';
  previousLinkText: string = 'Previous';

  constructor(
    private fb: FormBuilder,
    private http: HttpClient,
    private router: Router,
    private defaultItemService: DefaultItemService
  ) {}

  ngOnInit() {
    this.ssnForm = this.fb.group({
      ssn: ['', [Validators.required, Validators.pattern(/^\d{3}-?\d{2}-?\d{4}$/)]]
    });
    this.loadMenuLinks();
  }

  loadMenuLinks() {
    // Try menu API first
    this.http.get<any[]>('/api/menu').subscribe({
      next: (menu) => {
        const item = menu.find(m => m.immediatelink === 'check-ssn');
        if (item) {
          this.nextLink = item.nextlink && item.nextlinktext ? (item.nextlink.startsWith('/') ? item.nextlink : `/${item.nextlink}`) : '';
          this.cancelLink = item.cancellink && item.cancellinktext ? (item.cancellink.startsWith('/') ? item.cancellink : `/${item.cancellink}`) : '';
          this.previousLink = item.previouslink && item.previouslinktext ? (item.previouslink.startsWith('/') ? item.previouslink : `/${item.previouslink}`) : null;
          this.nextLinkText = item.nextlinktext || 'Next';
          this.cancelLinkText = item.cancellinktext || 'Cancel';
          this.previousLinkText = item.previouslinktext || 'Previous';
        } else {
          this.loadDefaultLinks();
        }
      },
      error: () => {
        this.loadDefaultLinks();
      }
    });
  }

  loadDefaultLinks() {
    // Use defaultitems API for fallback config
    this.defaultItemService.getDefaultItem('check-ssn', '').subscribe({
      next: (item: DefaultItem) => {
        this.nextLink = item.nextLink && item.nextLinkText ? (item.nextLink.startsWith('/') ? item.nextLink : `/${item.nextLink}`) : '';
        this.cancelLink = item.cancelLink && item.cancelLinkText ? (item.cancelLink.startsWith('/') ? item.cancelLink : `/${item.cancelLink}`) : '';
        this.previousLink = item.previousLink && item.previousLinkText ? (item.previousLink.startsWith('/') ? item.previousLink : `/${item.previousLink}`) : null;
        this.nextLinkText = item.nextLinkText || 'Next';
        this.cancelLinkText = item.cancelLinkText || 'Cancel';
        this.previousLinkText = item.previousLinkText || 'Previous';
      },
      error: () => {
        // fallback to hardcoded defaults if needed
      }
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
    // Store the SSN token if present, else clear
    if (this.result && this.result.token) {
      sessionStorage.setItem('ssn_token', this.result.token);
    } else {
      sessionStorage.removeItem('ssn_token');
    }
    if (this.nextLink) {
      this.router.navigate([this.nextLink]);
    }
  }

  cancel() {
    if (this.cancelLink) {
      // Always clear token on cancel for safety
      sessionStorage.removeItem('ssn_token');
      // Normalize both paths: remove trailing slashes, ignore query params
      const normalize = (url: string) => url.replace(/\?.*$/, '').replace(/\/+$/, '');
      const currentUrl = normalize(this.router.url);
      const targetUrl = normalize(this.cancelLink);
      console.log('[Cancel] currentUrl:', currentUrl, 'targetUrl:', targetUrl);
      if (currentUrl === targetUrl) {
        console.log('[Cancel] Forcing full reload to', this.cancelLink);
        window.location.href = this.cancelLink;
      } else {
        console.log('[Cancel] Using router.navigate to', this.cancelLink);
        this.router.navigate([this.cancelLink]);
      }
    }
  }

  goPrevious() {
    if (this.previousLink) {
      this.router.navigate([this.previousLink]);
    }
  }

  protected readonly maskSsn = maskSsn;
  reset() {
    this.ssnForm.reset();
    this.error = null;
    this.result = null;
    this.loading = false;
  }
}
