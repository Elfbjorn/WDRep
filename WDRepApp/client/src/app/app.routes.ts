import { Routes } from '@angular/router';
import { Hello } from './hello';

import { CheckSsnComponent } from './check-ssn/check-ssn.component';
import { CreateIdentityComponent } from './create-identity/create-identity.component';

export const routes: Routes = [
	{ path: '', redirectTo: 'check-ssn', pathMatch: 'full' },
	{ path: 'hello', component: Hello },
	{ path: 'check-ssn', loadComponent: () => import('./check-ssn/check-ssn.component').then(m => m.CheckSsnComponent) },
	{ path: 'create-identity', loadComponent: () => import('./create-identity/create-identity.component').then(m => m.CreateIdentityComponent) },
	{ path: 'security-information', loadComponent: () => import('./security-information/security-information.component').then(m => m.SecurityInformationComponent) },
	{ path: '**', redirectTo: 'check-ssn' }
];
