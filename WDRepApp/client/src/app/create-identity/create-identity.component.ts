// ...existing code...
import { Component, OnInit } from '@angular/core';
import { maskSsn } from '../utils/masking.utils';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-create-identity',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './create-identity.component.html',
  styleUrls: ['./create-identity.component.scss']
})
export class CreateIdentityComponent implements OnInit {
  onContactCountryChange() {
    const selected = this.contactCountryList.find((c: any) => c.geographyId === this.contactSelectedCountry);
    if (selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada')) {
      this.http.get<any>(`/api/identity/states/${this.contactSelectedCountry}`).subscribe(
        (data) => {
          this.contactStates = (data || []).map((s: any) => ({
            geographyId: s.geographyId ?? s.geographyid,
            geographyName: s.geographyName ?? s.geographyname
          }));
        },
        () => {
          this.contactStates = [];
        }
      );
    } else {
      this.contactStates = [];
    }
    this.contactSelectedState = null;
    this.contactStateText = '';
  }
  // Contact tab fields
  // Email
  emailTypes: { contactTypeId: number, contactTypeName: string }[] = [];
  selectedEmailType: number | null = null;
  primaryEmail: string = '';
  // Phone
  phoneTypes: { contactTypeId: number, contactTypeName: string }[] = [];
  selectedPhoneType: number | null = null;
  primaryPhone: string = '';
  // Address
  addressTypes: { contactTypeId: number, contactTypeName: string }[] = [];
  selectedAddressType: number | null = null;
  addressLine1: string = '';
  addressLine2: string = '';
  contactCountryList: { geographyId: number, geographyName: string }[] = [];
  contactSelectedCountry: number | null = null;
  contactStates: { geographyId: number, geographyName: string }[] = [];
  contactSelectedState: number | null = null;
  contactStateText: string = '';
  contactCity: string = '';
  contactZip: string = '';
  noMiddleName = false;
  // Helper for contact country/state/city
  get isContactUsOrCanada(): boolean {
    const selected = this.contactCountryList.find((c: any) => c.geographyId === this.contactSelectedCountry);
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  }
  activeTab: 'basic' | 'contact' = 'basic';
  sexes: { sexid: number, description: string }[] = [];
  selectedSex: number | null = null;
  city: string = '';
  get isUsOrCanada(): boolean {
    const selected = this.countries.find((c: any) => c.geographyId === this.selectedCountry);
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  }
  states: { geographyId: number, geographyName: string }[] = [];
  selectedState: number | null = null;
  stateText: string = '';
  countries: { geographyId: number, geographyName: string }[] = [];
  selectedCountry: number | null = null;
  dob: string = '';
  ssn: string = '';
  get maskedSsn(): string {
    return maskSsn(this.ssn);
  }
  prefixes: { prefixsuffixid: number, description: string }[] = [];
  suffixes: { prefixsuffixid: number, description: string }[] = [];
  selectedPrefix: number | null = null;
  selectedSuffix: number | null = null;
  loading = false;
  error: string | null = null;
    firstName: string = '';
    middleName: string = '';
    lastName: string = '';
    previousLastName: string = '';
    preferredName: string = '';


  constructor(private http: HttpClient, private router: Router, private route: ActivatedRoute) {}


  ngOnInit() {
    // 1. Load dropdowns as before
    this.loading = true;
    this.http.get<any>('/api/identity/dropdowns').subscribe(
      (data) => {
        this.contactCountryList = (data?.countries || []).map((c: any) => ({
          geographyId: c.geographyId ?? c.geographyid,
          geographyName: c.geographyName ?? c.geographyname
        }));
        this.prefixes = (data?.prefixes || []).map((p: any) => ({
          prefixsuffixid: p.prefixsuffixid ?? p.prefixSuffixId,
          description: p.description
        }));
        this.suffixes = (data?.suffixes || []).map((s: any) => ({
          prefixsuffixid: s.prefixsuffixid ?? s.prefixSuffixId,
          description: s.description
        }));
        this.sexes = (data?.sexes || []).map((s: any) => ({
          sexid: s.sexid ?? s.sexId,
          description: s.description
        }));
        this.countries = (data?.countries || []).map((c: any) => ({
          geographyId: c.geographyId ?? c.geographyid,
          geographyName: c.geographyName ?? c.geographyname
        }));
        this.emailTypes = (data?.emailTypes || []).map((t: any) => ({
          contactTypeId: t.contactTypeId,
          contactTypeName: t.contactTypeName
        }));
        this.phoneTypes = (data?.phoneTypes || []).map((t: any) => ({
          contactTypeId: t.contactTypeId,
          contactTypeName: t.contactTypeName
        }));
        this.addressTypes = (data?.addressTypes || []).map((t: any) => ({
          contactTypeId: t.contactTypeId,
          contactTypeName: t.contactTypeName
        }));
        this.loading = false;
      },
      () => {
        this.error = 'Failed to load dropdown.';
        this.loading = false;
      }
    );

    // 2. Retrieve token from sessionStorage (set by check-ssn)
    const token = sessionStorage.getItem('ssn_token');
    if (!token) {
      this.error = 'No SSN token found. Please start from the SSN check.';
      return;
    }

    // 3. Use token to get SSN
    this.loading = true;
  this.http.post<any>('/api/identity/ssn-from-token', { token: token }, { headers: { 'Content-Type': 'application/json' } })
      .subscribe({
        next: (res: any) => {
          this.ssn = maskSsn(res.ssn);
          // 4. Check if SSN is in coreidentity
          this.http.post<any>('/api/identity/check-ssn', JSON.stringify(res.ssn), { headers: { 'Content-Type': 'application/json' } })
            .subscribe({
              next: (result: any) => {
                this.loading = false;
                if (result && result.found) {
                  // Populate all fields from coreidentity
                  this.firstName = result.firstname || '';
                  this.middleName = result.middlename || '';
                  this.lastName = result.lastname || '';
                  this.dob = result.dob || '';
                  this.selectedPrefix = result.prefixid || null;
                  this.selectedSuffix = result.suffixid || null;
                  this.selectedSex = result.sexid || null;
                  this.selectedCountry = result.placeofbirthid || null;
                  // ...add more fields as needed...
                } else {
                  // Not found: only populate SSN
                  this.firstName = '';
                  this.middleName = '';
                  this.lastName = '';
                  this.dob = '';
                  this.selectedPrefix = null;
                  this.selectedSuffix = null;
                  this.selectedSex = null;
                  this.selectedCountry = null;
                }
              },
              error: () => {
                this.loading = false;
                this.error = 'Failed to check SSN in database.';
              }
            });
        },
        error: () => {
          this.loading = false;
          this.error = 'Failed to retrieve SSN from token.';
        }
      });
  }

  onCountryChange() {
    const selected = this.countries.find((c: any) => c.geographyId === this.selectedCountry);
    if (selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada')) {
      this.http.get<any>(`/api/identity/states/${this.selectedCountry}`).subscribe(
        (data) => {
          this.states = (data || []).map((s: any) => ({
            geographyId: s.geographyId ?? s.geographyid,
            geographyName: s.geographyName ?? s.geographyname
          }));
        },
        () => {
          this.states = [];
        }
      );
    } else {
      this.states = [];
    }
    this.selectedState = null;
    this.stateText = '';
  }

  onNoMiddleNameChange() {
    if (this.noMiddleName) {
      this.middleName = 'NMN';
    } else if (this.middleName === 'NMN') {
      this.middleName = '';
    }
  }

  onCancel() {
    // Implement cancel logic as needed (e.g., clear form, navigate away, etc.)
    // For now, just navigate to the home page
    this.router.navigate(['/']);
  }

  onBack() {
    this.router.navigate(['/check-ssn']);
  }

  onNext() {
    this.activeTab = 'contact';
  }
}
