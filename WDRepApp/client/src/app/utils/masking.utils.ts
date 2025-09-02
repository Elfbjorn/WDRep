export function maskSsn(ssn: string): string {
  if (!ssn) return '';
  const digits = ssn.replace(/[^0-9]/g, '');
  if (digits.length !== 9) return ssn;
  return '###-##-' + digits.slice(-4);
}
