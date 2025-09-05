export function maskSsn(ssn: string): string {
  if (!ssn) return '';
  const digits = ssn.replace(/[^0-9]/g, '');
  if (digits.length !== 9) return ssn;
  return `${digits.slice(0, 3)}-${digits.slice(3, 5)}-${digits.slice(5)}`;
}
