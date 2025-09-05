import { Routes } from '@angular/router';
import { Hello } from './hello';

export const routes: Routes = [
	{ path: '', redirectTo: 'welcome', pathMatch: 'full' },
	{ path: 'welcome', loadComponent: () => import('./welcome/welcome.component').then(m => m.WelcomeComponent) },
	{ path: 'hello', component: Hello },
	{ path: 'check-ssn', loadComponent: () => import('./check-ssn/check-ssn.component').then(m => m.CheckSsnComponent) },
	{ path: 'create-identity', loadComponent: () => import('./create-identity/create-identity.component').then(m => m.CreateIdentityComponent) },
	{ path: 'security-information', loadComponent: () => import('./security-information/security-information.component').then(m => m.SecurityInformationComponent) },
	{ path: '**', redirectTo: 'welcome' }
];
