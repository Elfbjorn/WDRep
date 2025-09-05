// ...existing code...
import { Component, ChangeDetectionStrategy, signal, computed, effect, inject } from '@angular/core';
import { maskSsn } from '../utils/masking.utils';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { DefaultItemService, DefaultItem } from '../utils/default-item.service';

@Component({
  selector: 'app-create-identity',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './create-identity.component.html',
  styleUrls: ['./create-identity.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class CreateIdentityComponent {
  // Signals for state
  loading = signal(false);
  error = signal<string | null>(null);
  activeTab = signal<'basic' | 'contact'>('basic');
  nextLink = signal('');
  nextLinkText = signal('Next');
  previousLink = signal('');
  previousLinkText = signal('Back');
  cancelLink = signal('');
  cancelLinkText = signal('Cancel');
  // All other stateful properties as signals
  priorAliases = signal<string[]>([]);
  noMiddleName = signal(false);
  emailTypes = signal<{ contactTypeId: number, contactTypeName: string }[]>([]);
  selectedEmailType = signal<number | null>(null);
  primaryEmail = signal('');
  phoneTypes = signal<{ contactTypeId: number, contactTypeName: string }[]>([]);
  selectedPhoneType = signal<number | null>(null);
  primaryPhone = signal('');
  addressTypes = signal<{ contactTypeId: number, contactTypeName: string }[]>([]);
  selectedAddressType = signal<number | null>(null);
  addressLine1 = signal('');
  addressLine2 = signal('');
  contactCountryList = signal<{ geographyId: number, geographyName: string }[]>([]);
  contactSelectedCountry = signal<number | null>(null);
  contactStates = signal<{ geographyId: number, geographyName: string }[]>([]);
  contactSelectedState = signal<number | null>(null);
  contactStateText = signal('');
  contactCityText = signal('');
  contactZip = signal('');
  contactGeographyId = signal<number | null>(null);
  sexes = signal<{ sexid: number, description: string }[]>([]);
  selectedSex = signal<number | null>(null);
  city = signal('');
  states = signal<{ geographyId: number, geographyName: string }[]>([]);
  selectedState = signal<number | null>(null);
  stateText = signal('');
  countries = signal<{ geographyId: number, geographyName: string }[]>([]);
  selectedCountry = signal<number | null>(null);
  dob = signal('');
  ssn = signal('');
  prefixes = signal<{ prefixsuffixid: number, description: string }[]>([]);
  suffixes = signal<{ prefixsuffixid: number, description: string }[]>([]);
  selectedPrefix = signal<number | null>(null);
  selectedSuffix = signal<number | null>(null);
  firstName = signal('');
  middleName = signal('');
  lastName = signal('');
  previousLastName = signal('');
  preferredName = signal('');
  // Computed properties
  hasPriorAliases = computed(() => this.priorAliases().length > 0);
  isContactUsOrCanada = computed(() => {
    const selected = this.contactCountryList().find((c: any) => c.geographyId === this.contactSelectedCountry());
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  });
  isUsOrCanada = computed(() => {
    const selected = this.countries().find((c: any) => c.geographyId === this.selectedCountry());
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  });
  countriesWithUsFirst = computed(() => {
    const countries = this.countries();
    if (!countries || countries.length === 0) return [];
    const us = countries.find(c => c.geographyName === 'United States');
    const rest = [...countries];
    const usIndex = rest.findIndex(c => c.geographyName === 'United States');
    if (usIndex !== -1) rest.splice(usIndex, 1);
    rest.sort((a, b) => a.geographyName.localeCompare(b.geographyName));
    return us ? [us, ...rest] : rest;
  });
  maskedSsn = computed(() => maskSsn(this.ssn()));
  protected readonly maskSsn = maskSsn;
  // Use inject() for all services
  private http = inject(HttpClient);
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private defaultItemService = inject(DefaultItemService);
  // Effect for initialization (replaces ngOnInit)
  constructor() {
    effect(() => {
      this.loadMenuLinks();
      this.loadDropdownsAndPrefill();
    });
  }
  priorAliasesTooltip(): string {
    const current = (this.previousLastName() || '').trim().toLowerCase();
    const filtered = this.priorAliases().filter(a => a.trim().toLowerCase() !== current);
    if (filtered.length === 0) return '';
    return 'Prior last names (most recent first):\n' + filtered.join('\n');
  }

  loadDropdownsAndPrefill() {
    // 1. Load dropdowns as before
    this.loading.set(true);
    this.http.get<any>('/api/identity/dropdowns').subscribe(
      (data) => {
        const allCountries = (data?.countries || []).map((c: any) => ({
          geographyId: c.geographyId ?? c.geographyid,
          geographyName: c.geographyName ?? c.geographyname
        }));
        // United States always first after 'Select a country'
        const us = allCountries.find((c: any) => c.geographyName === 'United States');
        this.countries.set(us ? [us, ...allCountries] : [...allCountries]);
        this.contactCountryList.set(this.countries());
        this.prefixes.set((data?.prefixes || []).map((p: any) => ({
          prefixsuffixid: p.prefixsuffixid ?? p.prefixSuffixId,
          description: p.description
        })));
        this.suffixes.set((data?.suffixes || []).map((s: any) => ({
          prefixsuffixid: s.prefixsuffixid ?? s.prefixSuffixId,
          description: s.description
        })));
        this.sexes.set((data?.sexes || []).map((s: any) => ({
          sexid: s.sexid ?? s.sexId,
          description: s.description
        })));
        this.emailTypes.set(Array.isArray(data?.emailTypes) && data.emailTypes.length > 0
          ? data.emailTypes.map((t: any) => ({
              contactTypeId: t.contactTypeId ?? t.contacttypeid,
              contactTypeName: t.contactTypeName ?? t.contacttypename
            }))
          : []);
        this.phoneTypes.set(Array.isArray(data?.phoneTypes) && data.phoneTypes.length > 0
          ? data.phoneTypes.map((t: any) => ({
              contactTypeId: t.contactTypeId ?? t.contacttypeid,
              contactTypeName: t.contactTypeName ?? t.contacttypename
            }))
          : []);
        this.addressTypes.set(Array.isArray(data?.addressTypes) && data.addressTypes.length > 0
          ? data.addressTypes.map((t: any) => ({
              contactTypeId: t.contactTypeId ?? t.contacttypeid,
              contactTypeName: t.contactTypeName ?? t.contacttypename
            }))
          : []);
        this.loading.set(false);
      },
      () => {
        this.error.set('Failed to load dropdown.');
        this.loading.set(false);
      }
    );

    // 2. Retrieve token from sessionStorage (set by check-ssn)
    const token = sessionStorage.getItem('ssn_token');
    if (!token) {
      this.error.set('No SSN token found. Please start from the SSN check.');
      return;
    }

    // 3. Use token to get SSN
    this.loading.set(true);
    this.http.post<any>('/api/identity/ssn-from-token', { token: token }, { headers: { 'Content-Type': 'application/json' } })
      .subscribe({
        next: (res: any) => {
          this.ssn.set(maskSsn(res.ssn));
          // 4. Check if SSN is in coreidentity
          this.http.post<any>('/api/identity/check-ssn', JSON.stringify(res.ssn), { headers: { 'Content-Type': 'application/json' } })
            .subscribe({
              next: (result: any) => {
                this.loading.set(false);
                if (result && result.found) {
                  // Populate all fields from coreidentity and related tables
                  this.firstName.set(result.firstname || '');
                  this.middleName.set(result.middlename || '');
                  this.lastName.set(result.lastname || '');
                  this.dob.set(result.dob ? result.dob.substring(0, 10) : '');
                  this.selectedPrefix.set(result.prefixid || null);
                  this.selectedSuffix.set(result.suffixid || null);
                  this.selectedSex.set(result.sexid || null);
                  this.selectedCountry.set(result.countryofbirthid || null);
                  this.stateText.set(result.stateofbirth || '');
                  this.city.set(result.cityofbirth || '');
                  this.primaryEmail.set(result.email || '');
                  this.selectedEmailType.set(result.emailtypeid || null);
                  this.primaryPhone.set(result.phone || '');
                  this.selectedPhoneType.set(result.phonetypeid || null);
                  this.preferredName.set(result.preferredname || '');
                  this.previousLastName.set(result.previouslastname || '');
                  this.priorAliases.set(Array.isArray(result.prioraliases) ? result.prioraliases : []);
                  if (result.address) {
                    // Robust logging and assignment for all address fields
                    const addr = result.address;
                    console.log('Received address from backend:', addr);
                    this.addressLine1.set(addr.address1 ?? '');
                    this.addressLine2.set(addr.address2 ?? '');
                    this.contactZip.set(addr.zipcode ?? '');
                    this.contactGeographyId.set(addr.geographyId ?? null);
                    // City
                    this.contactCityText.set(addr.contactCity ?? addr.cityName ?? addr.city ?? '');
                    // State
                    this.contactStateText.set(addr.contactState ?? addr.stateName ?? addr.state ?? '');
                    // Country
                    // Assign country and state IDs robustly
                    const countryId = addr.contactCountryId ?? addr.countryId ?? null;
                    const stateId = addr.contactStateId ?? addr.stateId ?? null;
                    // Assign country
                    if (this.contactCountryList().length > 0) {
                      this.contactSelectedCountry.set(countryId);
                      this.onCountryChange();
                      setTimeout(() => {
                        this.contactSelectedState.set(stateId);
                      }, 200);
                    } else {
                      setTimeout(() => {
                        this.contactSelectedCountry.set(countryId);
                        this.onCountryChange();
                        setTimeout(() => {
                          this.contactSelectedState.set(stateId);
                        }, 200);
                      }, 200);
                    }
                    // Address type
                    this.selectedAddressType.set(addr.addressTypeId ?? null);
                    // Log all assignments
                    console.log('Assigned contactCityText:', this.contactCityText());
                    console.log('Assigned contactStateText:', this.contactStateText());
                    console.log('Assigned contactSelectedCountry:', this.contactSelectedCountry());
                    console.log('Assigned contactSelectedState:', this.contactSelectedState());
                    console.log('Assigned selectedAddressType:', this.selectedAddressType());
                    this.selectedAddressType.set(result.address.addressTypeId || null);
                    // Pre-fill country/state/city dropdowns for contact address
                    if (this.contactGeographyId()) {
                      // Find city, then state, then country by traversing up
                      this.http.get<any>(`/api/identity/geography-parents/${this.contactGeographyId()}`).subscribe((geo) => {
                        if (geo) {
                          this.contactSelectedCountry.set(geo.countryId || null);
                          this.onCountryChange();
                          setTimeout(() => {
                            this.contactSelectedState.set(geo.stateId || null);
                            // No city dropdown logic; city is always a text field
                          }, 200);
                        }
                      });
                    }
                  }
                  // Ensure state dropdown is loaded and selected
                  if (this.selectedCountry() && (this.countries().find((c: any) => c.geographyId === this.selectedCountry())?.geographyName === 'United States' || this.countries().find((c: any) => c.geographyId === this.selectedCountry())?.geographyName === 'Canada')) {
                    this.onCountryChange();
                    // Wait for states to load, then set selectedState
                    setTimeout(() => {
                      this.selectedState.set(result.stateofbirthid || null);
                    }, 300);
                  } else {
                    this.selectedState.set(null);
                  }
                } else {
                  // Not found: only populate SSN
                  this.firstName.set('');
                  this.middleName.set('');
                  this.lastName.set('');
                  this.dob.set('');
                  this.selectedPrefix.set(null);
                  this.selectedSuffix.set(null);
                  this.selectedSex.set(null);
                  this.selectedCountry.set(null);
                  this.selectedState.set(null);
                  this.stateText.set('');
                  this.city.set('');
                  this.primaryEmail.set('');
                  this.primaryPhone.set('');
                  this.addressLine1.set('');
                  this.addressLine2.set('');
                  this.contactZip.set('');
                  this.previousLastName.set('');
                  this.priorAliases.set([]);
                }
              },
              error: () => {
                this.loading.set(false);
                this.error.set('Failed to check SSN in database.');
              }
            });
        },
        error: () => {
          this.loading.set(false);
          this.error.set('Failed to retrieve SSN from token.');
        }
      });
  }


  onCountryChange(isContactTab: boolean = false) {
    // Determine which tab is active or allow explicit override
    const isContact = isContactTab || this.activeTab() === 'contact';
    const countryId = isContact ? this.contactSelectedCountry() : this.selectedCountry();
    const setStates = isContact ? this.contactStates : this.states;
    const setSelectedState = isContact ? this.contactSelectedState : this.selectedState;
    const setStateText = isContact ? this.contactStateText : this.stateText;
    const countryList = isContact ? this.contactCountryList() : this.countries();
    const selected = countryList.find((c: any) => c.geographyId === countryId);
    if (selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada')) {
      this.http.get<any>(`/api/identity/states/${countryId}`).subscribe(
        (data) => {
          setStates.set((data || []).map((s: any) => ({
            geographyId: s.geographyId ?? s.geographyid,
            geographyName: s.geographyName ?? s.geographyname
          })));
        },
        () => {
          setStates.set([]);
        }
      );
    } else {
      setStates.set([]);
    }
    setSelectedState.set(null);
    setStateText.set('');
  }

  onNoMiddleNameChange() {
    if (this.noMiddleName()) {
      this.middleName.set('NMN');
    } else if (this.middleName() === 'NMN') {
      this.middleName.set('');
    }
  }


  onCancel() {
  localStorage.removeItem('ssn_token');
  this.handleNavLink(this.cancelLink());
  }
  // Navigation and menu/default logic
  loadMenuLinks() {
    // Try menu API first for context
    console.log('[CreateIdentityComponent] loadMenuLinks called');
    this.http.get<any[]>('/api/menu').subscribe({
      next: (menu) => {
        console.log('[loadMenuLinks] /api/menu response:', menu);
        // Determine current page/tab context
        const page = 'create-identity';
  const tab = this.activeTab() === 'contact' ? 'Contact Information' : 'Basic Information';
        // Try to find a menu item matching page/tab
        let item = menu.find(m => m.immediatelink === page && (m.tab === tab || !m.tab));
        if (!item) {
          // Fallback: just match page
          item = menu.find(m => m.immediatelink === page);
        }
        if (item) {
          this.nextLink.set(item.nextlink || '');
          this.nextLinkText.set(item.nextlinktext || 'Next');
          this.previousLink.set(item.previouslink || '');
          this.previousLinkText.set(item.previouslinktext || 'Back');
          this.cancelLink.set(item.cancellink || '');
          this.cancelLinkText.set(item.cancellinktext || 'Cancel');
          console.log('[loadMenuLinks] Set nextLink:', this.nextLink());
        } else {
          console.log('[loadMenuLinks] No menu item found, loading default links.');
          this.loadDefaultLinks();
        }
      },
      error: (err) => {
        console.warn('[loadMenuLinks] /api/menu error:', err);
        this.loadDefaultLinks();
      }
    });
  }

  loadDefaultLinks() {
    // Use defaultitems API for fallback config
    const page = 'create-identity';
    const tab = this.activeTab() === 'contact' ? 'Contact Information' : 'Basic Information';
    this.defaultItemService.getDefaultItem(page, tab).subscribe({
      next: (item: any) => {
        console.log('[loadDefaultLinks] getDefaultItem response:', item);
        // Robust property mapping: try both camelCase and PascalCase
        const nextLink = item.nextLink || item.NextLink || '';
        const nextLinkText = item.nextLinkText || item.NextLinkText || 'Next';
        const previousLink = item.previousLink || item.PreviousLink || '';
        const previousLinkText = item.previousLinkText || item.PreviousLinkText || 'Back';
        const cancelLink = item.cancelLink || item.CancelLink || '';
        const cancelLinkText = item.cancelLinkText || item.CancelLinkText || 'Cancel';
        this.nextLink.set(nextLink);
        this.nextLinkText.set(nextLinkText);
        this.previousLink.set(previousLink);
        this.previousLinkText.set(previousLinkText);
        this.cancelLink.set(cancelLink);
        this.cancelLinkText.set(cancelLinkText);
        console.log('[loadDefaultLinks] Set nextLink:', this.nextLink());
        console.log('[loadDefaultLinks] Set nextLinkText:', this.nextLinkText());
        console.log('[loadDefaultLinks] Set previousLink:', this.previousLink());
        console.log('[loadDefaultLinks] Set previousLinkText:', this.previousLinkText());
        console.log('[loadDefaultLinks] Set cancelLink:', this.cancelLink());
        console.log('[loadDefaultLinks] Set cancelLinkText:', this.cancelLinkText());
      },
      error: (err) => {
        console.warn('[loadDefaultLinks] getDefaultItem error:', err);
        // fallback to hardcoded defaults if needed
      }
    });
  }

  onNext() {
  console.log('[onNext] nextLink:', this.nextLink());
  this.handleNavLink(this.nextLink());
  }

  onPrevious() {
  this.handleNavLink(this.previousLink());
  }

  handleNavLink(link: string) {
    console.log('[handleNavLink] link:', link);
    if (!link) {
      console.warn('[handleNavLink] No link provided.');
      return;
    }
    // Parse link for tab context: e.g., create-identity.Basic Information
    const [page, tab] = link.split('.', 2);
    if (page === 'create-identity') {
      if (tab) {
        // Switch tab in-place
  this.activeTab.set(tab.trim().toLowerCase().includes('contact') ? 'contact' : 'basic');
  console.log('[handleNavLink] Switched activeTab to:', this.activeTab());
        this.loadMenuLinks();
      } else {
        // No tab: reload or navigate
        console.log('[handleNavLink] Navigating to /create-identity');
        this.router.navigate(['/create-identity']);
      }
    } else {
      // Navigate to other page
      console.log('[handleNavLink] Navigating to /' + page);
      this.router.navigate([`/${page}`]);
    }
  }

  onSubmit() {
    this.loading.set(true);
    this.error.set(null);
    // Prepare payload matching new CreateIdentityRequest DTO (city-level geography for postal address)
    // Set contactGeographyId from city/state text fields (handled by backend)
    let contactGeographyId: number | null = null;
    const payload = {
      firstName: this.firstName(),
      middleName: this.middleName(),
      lastName: this.lastName(),
      previousLastName: this.previousLastName(),
      preferredName: this.preferredName(),
      dob: this.dob(),
      ssn: this.ssn().replace(/[^0-9]/g, ''),
      prefixId: this.selectedPrefix(),
      suffixId: this.selectedSuffix(),
      sexId: this.selectedSex(),
      countryOfBirthId: this.selectedCountry(),
      stateOfBirthId: this.isUsOrCanada() ? this.selectedState() : null,
      stateOfBirthText: !this.isUsOrCanada() ? this.stateText() : null,
      cityOfBirth: this.city(),
      emailTypeId: this.selectedEmailType(),
      primaryEmail: this.primaryEmail(),
      phoneTypeId: this.selectedPhoneType(),
      primaryPhone: this.primaryPhone(),
      addressTypeId: this.selectedAddressType(),
      addressLine1: this.addressLine1(),
      addressLine2: this.addressLine2(),
      contactZip: this.contactZip(),
      // New modular address fields
      contactCountryId: this.contactSelectedCountry(),
      contactStateId: this.isContactUsOrCanada() ? this.contactSelectedState() : null,
      contactStateText: !this.isContactUsOrCanada() ? this.contactStateText() : null,
      contactCityText: this.contactCityText()
    };
    this.http.post<any>('/api/identity/create', payload, { headers: { 'Content-Type': 'application/json' } })
      .subscribe({
        next: (res: any) => {
          this.loading.set(false);
          if (res && res.success) {
            this.router.navigate(['/security-information']);
          } else {
            this.error.set(res && res.error ? res.error : 'Failed to create identity.');
          }
        },
        error: (err: any) => {
          this.loading.set(false);
          this.error.set(err?.error?.error || 'Failed to create identity.');
        }
      });
  }
}
