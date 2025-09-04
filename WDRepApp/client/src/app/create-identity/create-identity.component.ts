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
  priorAliasesTooltip(): string {
    // Exclude the current field value (trimmed, case-insensitive) from the tooltip
    const current = (this.previousLastName || '').trim().toLowerCase();
    const filtered = this.priorAliases.filter(a => a.trim().toLowerCase() !== current);
    if (filtered.length === 0) return '';
    return 'Prior last names (most recent first):\n' + filtered.join('\n');
  }
  priorAliases: string[] = [];
  get hasPriorAliases(): boolean {
    return this.priorAliases.length > 0;
  }
  protected readonly maskSsn = maskSsn;
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
  // Removed city dropdown logic; city is always a text field
  contactCityText: string = '';
  contactZip: string = '';
  contactGeographyId: number | null = null;
  get isContactUsOrCanada(): boolean {
    const selected = this.contactCountryList.find((c: any) => c.geographyId === this.contactSelectedCountry);
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  }

  // Removed onContactStateChange; city is always a text field
  noMiddleName = false;
  // Helper for contact country/state/city
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
                  // Populate all fields from coreidentity and related tables
                  this.firstName = result.firstname || '';
                  this.middleName = result.middlename || '';
                  this.lastName = result.lastname || '';
                  this.dob = result.dob ? result.dob.substring(0, 10) : '';
                  this.selectedPrefix = result.prefixid || null;
                  this.selectedSuffix = result.suffixid || null;
                  this.selectedSex = result.sexid || null;
                  this.selectedCountry = result.countryofbirthid || null;
                  this.stateText = result.stateofbirth || '';
                  this.city = result.cityofbirth || '';
                  this.primaryEmail = result.email || '';
                  this.selectedEmailType = result.emailtypeid || null;
                  this.primaryPhone = result.phone || '';
                  this.selectedPhoneType = result.phonetypeid || null;
                  this.preferredName = result.preferredname || '';
                  this.previousLastName = result.previouslastname || '';
                  this.priorAliases = Array.isArray(result.prioraliases) ? result.prioraliases : [];
                  if (result.address) {
                    // Robust logging and assignment for all address fields
                    const addr = result.address;
                    console.log('Received address from backend:', addr);
                    this.addressLine1 = addr.address1 ?? '';
                    this.addressLine2 = addr.address2 ?? '';
                    this.contactZip = addr.zipcode ?? '';
                    this.contactGeographyId = addr.geographyId ?? null;
                    // City
                    this.contactCityText = addr.contactCity ?? addr.cityName ?? addr.city ?? '';
                    // State
                    this.contactStateText = addr.contactState ?? addr.stateName ?? addr.state ?? '';
                    // Country
                    // Assign country and state IDs robustly
                    const countryId = addr.contactCountryId ?? addr.countryId ?? null;
                    const stateId = addr.contactStateId ?? addr.stateId ?? null;
                    // Assign country
                    if (this.contactCountryList.length > 0) {
                      this.contactSelectedCountry = countryId;
                      this.onContactCountryChange();
                      setTimeout(() => {
                        this.contactSelectedState = stateId;
                      }, 200);
                    } else {
                      setTimeout(() => {
                        this.contactSelectedCountry = countryId;
                        this.onContactCountryChange();
                        setTimeout(() => {
                          this.contactSelectedState = stateId;
                        }, 200);
                      }, 200);
                    }
                    // Address type
                    this.selectedAddressType = addr.addressTypeId ?? null;
                    // Log all assignments
                    console.log('Assigned contactCityText:', this.contactCityText);
                    console.log('Assigned contactStateText:', this.contactStateText);
                    console.log('Assigned contactSelectedCountry:', this.contactSelectedCountry);
                    console.log('Assigned contactSelectedState:', this.contactSelectedState);
                    console.log('Assigned selectedAddressType:', this.selectedAddressType);
          this.selectedAddressType = result.address.addressTypeId || null;
                    // Pre-fill country/state/city dropdowns for contact address
                    if (this.contactGeographyId) {
                      // Find city, then state, then country by traversing up
                      this.http.get<any>(`/api/identity/geography-parents/${this.contactGeographyId}`).subscribe((geo) => {
                        if (geo) {
                          this.contactSelectedCountry = geo.countryId || null;
                          this.onContactCountryChange();
                          setTimeout(() => {
                            this.contactSelectedState = geo.stateId || null;
                            // No city dropdown logic; city is always a text field
                          }, 200);
                        }
                      });
                    }
                  }
                  // Ensure state dropdown is loaded and selected
                  if (this.selectedCountry && (this.countries.find((c: any) => c.geographyId === this.selectedCountry)?.geographyName === 'United States' || this.countries.find((c: any) => c.geographyId === this.selectedCountry)?.geographyName === 'Canada')) {
                    this.onCountryChange();
                    // Wait for states to load, then set selectedState
                    setTimeout(() => {
                      this.selectedState = result.stateofbirthid || null;
                    }, 300);
                  } else {
                    this.selectedState = null;
                  }
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
                  this.selectedState = null;
                  this.stateText = '';
                  this.city = '';
                  this.primaryEmail = '';
                  this.primaryPhone = '';
                  this.addressLine1 = '';
                  this.addressLine2 = '';
                  this.contactZip = '';
                  this.previousLastName = '';
                  this.priorAliases = [];
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

  onSubmit() {
    this.loading = true;
    this.error = null;
    // Prepare payload matching new CreateIdentityRequest DTO (city-level geography for postal address)
  // Set contactGeographyId from city/state text fields (handled by backend)
  let contactGeographyId: number | null = null;
    const payload = {
      firstName: this.firstName,
      middleName: this.middleName,
      lastName: this.lastName,
      previousLastName: this.previousLastName,
      preferredName: this.preferredName,
      dob: this.dob,
      ssn: this.ssn.replace(/[^0-9]/g, ''),
      prefixId: this.selectedPrefix,
      suffixId: this.selectedSuffix,
      sexId: this.selectedSex,
      countryOfBirthId: this.selectedCountry,
      stateOfBirthId: this.isUsOrCanada ? this.selectedState : null,
      stateOfBirthText: !this.isUsOrCanada ? this.stateText : null,
      cityOfBirth: this.city,
      emailTypeId: this.selectedEmailType,
      primaryEmail: this.primaryEmail,
      phoneTypeId: this.selectedPhoneType,
      primaryPhone: this.primaryPhone,
      addressTypeId: this.selectedAddressType,
      addressLine1: this.addressLine1,
      addressLine2: this.addressLine2,
      contactZip: this.contactZip,
      // New modular address fields
      contactCountryId: this.contactSelectedCountry,
      contactStateId: this.isContactUsOrCanada ? this.contactSelectedState : null,
      contactStateText: !this.isContactUsOrCanada ? this.contactStateText : null,
      contactCityText: this.contactCityText
    };
    this.http.post<any>('/api/identity/create', payload, { headers: { 'Content-Type': 'application/json' } })
      .subscribe({
        next: (res: any) => {
          this.loading = false;
          if (res && res.success) {
            this.router.navigate(['/security-information']);
          } else {
            this.error = res && res.error ? res.error : 'Failed to create identity.';
          }
        },
        error: (err: any) => {
          this.loading = false;
          this.error = err?.error?.error || 'Failed to create identity.';
        }
      });
  }
}
