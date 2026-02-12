Return-Path: <linux-edac+bounces-5710-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCAoD2/NjWn87AAAu9opvQ
	(envelope-from <linux-edac+bounces-5710-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 13:54:07 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C370812D9A6
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 13:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6999F307D134
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425B35B129;
	Thu, 12 Feb 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="LCPDuPdg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB861B4223;
	Thu, 12 Feb 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900645; cv=none; b=ZviB02/L1tJjtrg2+f2mwOO133wqlGWAgnI0a/zXe5JSQ8vVGBpEUf+U0YOqpo7SDw0O1/DVImPC+mMLqsBHGiENomdcCrA2sfbSf34BHCjAUUuuESOLgI7+pUNvw+L09rjsyPpznfVh4nZGh3ZW5YpMwoKAGUi1HQDBqt6lsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900645; c=relaxed/simple;
	bh=KSICRLAvAUfdqVlNgkJenSJrdWTfSyADbuZBKzEG8A8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cq7hLISUArmXnM4uJtogT1bLn4xGQm0FJ0rNll7wPd7QQdoMN7uxVVo2eIo7lkmEYpwYd5A1OZp7DxqAB9/jAlxyFyMr4z7hCi/fItGeQiTPfIC+K+fFwOmy/4yE0fYnOX1Vutvdn2JrMX7MbEIdewGsro7baIaVHEBgHAZXEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=LCPDuPdg; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770900607; x=1771505407; i=spasswolf@web.de;
	bh=QX9BdzyHHAV2Wo5xLMg0A0++xP/zoGs67dZgQREFwPI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LCPDuPdgsCDLB/98SmynbtYyaDe9RY8Xvd+5LZhYldqTnL/c7Kzs9+kuV5pvIGws
	 jGO3Gvtmhil5QeBgTOtEvGJE7unKE7zT0+In/1MPbyDmUTEC0Wklak7sVHXD5RqLC
	 bZg0kO0edkzFGLCDh2VulNZYxPtZGTAgOWL6lBzlvNbFSfjPC8pEzfdDk4y0Sn9La
	 oX5s3L8UGdjY6Y7u3S1VkUy1taW5UT0i/8+YD4TX1joxElxjC0swQAFcnOtbayabc
	 eDw3mimn7d59soT2dmrYHwr8pBCFw/a4WXdN6wIW3xvsu5Ve5R/H/GOBiGqXmkg3r
	 KPpSs001m9gjFQe1gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1vyFMx0S72-002Gg4; Thu, 12
 Feb 2026 13:50:07 +0100
Message-ID: <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, spasswolf@web.de, Borislav
 Petkov	 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 	linux-next@vger.kernel.org,
 linux-edac@vger.kernel.org, 	linux-acpi@vger.kernel.org, x86@kernel.org,
 rafael@kernel.org, 	qiuxu.zhuo@intel.com,
 Smita.KoralahalliChannabasappa@amd.com, spasswolf@web.de
Date: Thu, 12 Feb 2026 13:50:05 +0100
In-Reply-To: <20251009132055.GA472268@yaz-khff2.amd.com>
References: <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
	 <20250916140744.GA1054485@yaz-khff2.amd.com>
	 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
	 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
	 <20250917144148.GA1313380@yaz-khff2.amd.com>
	 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
	 <20250917192652.GA1610597@yaz-khff2.amd.com>
	 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
	 <20250918210005.GA2150610@yaz-khff2.amd.com>
	 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
	 <20251009132055.GA472268@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tgGAHs5dLLjPQRtfueqgqvjhBzDY874QXU93JId2KciBkZl0JwL
 wFM8mnoY913L7zKKaag44qYu707aEkhHZyqkzcUaV6wk5BGMyuqZzm3tJKvLLvMY1gtZS1p
 TnGST5NKGejQFofDr0iqmXcPURhV+9jzYHkphgNrudd77DGKqCxHywMKSg23TajXi5MBtgT
 ag/nfnqGDuuuDJJWnFzOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dKoChPW6M4Q=;zCLlRMqCwx9OUa+aAhLoAmiWW+h
 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
 ns+mhrt0=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5710-lists,linux-edac=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[suse.com,web.de,alien8.de,intel.com,vger.kernel.org,kernel.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C370812D9A6
X-Rspamd-Action: no action

I couldn't test this patch as I was busy figuring out this:
243b467dea17 Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem=
"
but with this done I could do some testing on v6.19. The periodic bogus mc=
e
errors are gone because smca_should_log_poll_error() usually returns false=
, but
I still get some error messages for which I'm not sure if they are real er=
rors.

I monitored smca_should_log_poll_error() like this (in v6.19 (errors do no=
t occur in v6.18)):

static bool smca_should_log_poll_error(struct mce *m)
{
	if (m->status & MCI_STATUS_VAL) {
		printk(KERN_INFO "%s: 0\n", __func__);
		return true;
	}

	m->status =3D mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
		printk(KERN_INFO "%s: 1\n", __func__);
		m->kflags |=3D MCE_CHECK_DFR_REGS;
		return true;
	}

	printk(KERN_INFO "%s: 2\n", __func__);
	return false;
}

And get these error messages (usually just once or twice per boot)

Examples from v6.19:
$ grep -aE "Hardware Error|smca_should_log_poll_error: 1" /var/log/kern.lo=
g

2026-02-10T16:15:01.001203+01:00 lisa kernel: [    C0] smca_should_log_pol=
l_error: 1
2026-02-10T16:15:01.001815+01:00 lisa kernel: [T45426] mce: [Hardware Erro=
r]: Machine check events logged
2026-02-10T16:15:01.001818+01:00 lisa kernel: [T45426] [Hardware Error]: D=
eferred error, no action required.
2026-02-10T16:15:01.001819+01:00 lisa kernel: [T45426] [Hardware Error]: C=
PU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800=
000000
2026-02-10T16:15:01.001821+01:00 lisa kernel: [T45426] [Hardware Error]: E=
rror Addr: 0x01b3877c00000020
2026-02-10T16:15:01.001822+01:00 lisa kernel: [T45426] [Hardware Error]: I=
PID: 0x000700b040000000
2026-02-10T16:15:01.001831+01:00 lisa kernel: [T45426] [Hardware Error]: L=
3 Cache Ext. Error Code: 0
2026-02-10T16:15:01.001832+01:00 lisa kernel: [T45426] [Hardware Error]: c=
ache level: RESV, tx: INSN

2026-02-11T14:24:13.358353+01:00 lisa kernel: [    C0] smca_should_log_pol=
l_error: 1
2026-02-11T14:24:13.358832+01:00 lisa kernel: [T310371] mce: [Hardware Err=
or]: Machine check events logged
2026-02-11T14:24:13.361773+01:00 lisa kernel: [T310371] [Hardware Error]: =
Deferred error, no action required.
2026-02-11T14:24:13.361778+01:00 lisa kernel: [T310371] [Hardware Error]: =
CPU:0 (19:50:0) MC11_STATUS[-|-|-|AddrV|-|-|SyndV|UECC|Deferred|-|-]:
0x8424b0c8009d011e
2026-02-11T14:24:13.361781+01:00 lisa kernel: [T310371] [Hardware Error]: =
Error Addr: 0x01f8a43400000020
2026-02-11T14:24:13.361782+01:00 lisa kernel: [T310371] [Hardware Error]: =
IPID: 0x000700b040000000, Syndrome: 0x0000000000000042
2026-02-11T14:24:13.361787+01:00 lisa kernel: [T310371] [Hardware Error]: =
L3 Cache Ext. Error Code: 29
2026-02-11T14:24:13.361788+01:00 lisa kernel: [T310371] [Hardware Error]: =
cache level: L2, tx: RESV, mem-tx: RD

2026-02-12T10:07:28.804529+01:00 lisa kernel: [    C0] smca_should_log_pol=
l_error: 1
2026-02-12T10:07:28.805020+01:00 lisa kernel: [T393396] mce: [Hardware Err=
or]: Machine check events logged
2026-02-12T10:07:28.805028+01:00 lisa kernel: [T393396] [Hardware Error]: =
Deferred error, no action required.
2026-02-12T10:07:28.805029+01:00 lisa kernel: [T393396] [Hardware Error]: =
CPU:0 (19:50:0) MC11_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x870090080=
0000000
2026-02-12T10:07:28.805030+01:00 lisa kernel: [T393396] [Hardware Error]: =
Error Addr: 0x01300a9d00000020
2026-02-12T10:07:28.805031+01:00 lisa kernel: [T393396] [Hardware Error]: =
IPID: 0x000700b040000000
2026-02-12T10:07:28.805033+01:00 lisa kernel: [T393396] [Hardware Error]: =
L3 Cache Ext. Error Code: 0
2026-02-12T10:07:28.805034+01:00 lisa kernel: [T393396] [Hardware Error]: =
cache level: RESV, tx: INSN

Are the "Error Addr" reported here supposed to be physical addresses of me=
mory?
If they are they don't seem to make sense to me given the following output=
 of
"cat /proc/iomem":

Memory in my machine:
# cat /proc/iomem=20
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000dffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-09bfefff : System RAM
09bff000-0a000fff : Reserved
0a001000-0a1fffff : System RAM
0a200000-0a20efff : ACPI Non-volatile Storage
0a20f000-e6057fff : System RAM
e6058000-e614bfff : Reserved
e614c000-e868afff : System RAM
e868b000-e868bfff : Reserved
e868c000-e9cdefff : System RAM
e9cdf000-eb1fdfff : Reserved
  eb1dd000-eb1e0fff : MSFT0101:00
  eb1e1000-eb1e4fff : MSFT0101:00
eb1fe000-eb25dfff : ACPI Tables
eb25e000-eb555fff : ACPI Non-volatile Storage
eb556000-ed1fefff : Reserved
ed1ff000-edffffff : System RAM
ee000000-efffffff : Reserved
f0000000-fcffffff : PCI Bus 0000:00
  f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
    f0000000-f7ffffff : pnp 00:00
  fc500000-fc9fffff : PCI Bus 0000:08
    fc500000-fc5fffff : 0000:08:00.7
      fc500000-fc5fffff : pcie_mp2_amd
    fc600000-fc6fffff : 0000:08:00.4
      fc600000-fc6fffff : xhci-hcd
    fc700000-fc7fffff : 0000:08:00.3
      fc700000-fc7fffff : xhci-hcd
    fc800000-fc8fffff : 0000:08:00.2
      fc800000-fc8fffff : ccp
    fc900000-fc97ffff : 0000:08:00.0
    fc980000-fc9bffff : 0000:08:00.5
      fc980000-fc9bffff : AMD ACP3x audio
        fc980000-fc990200 : acp_pdm_iomem
    fc9c0000-fc9c7fff : 0000:08:00.6
      fc9c0000-fc9c7fff : ICH HD audio
    fc9c8000-fc9cbfff : 0000:08:00.1
      fc9c8000-fc9cbfff : ICH HD audio
    fc9cc000-fc9cdfff : 0000:08:00.7
    fc9ce000-fc9cffff : 0000:08:00.2
      fc9ce000-fc9cffff : ccp
  fca00000-fccfffff : PCI Bus 0000:01
    fca00000-fcbfffff : PCI Bus 0000:02
      fca00000-fcbfffff : PCI Bus 0000:03
        fca00000-fcafffff : 0000:03:00.0
        fcb00000-fcb1ffff : 0000:03:00.0
        fcb20000-fcb23fff : 0000:03:00.1
          fcb20000-fcb23fff : ICH HD audio
    fcc00000-fcc03fff : 0000:01:00.0
  fcd00000-fcdfffff : PCI Bus 0000:07
    fcd00000-fcd03fff : 0000:07:00.0
      fcd00000-fcd03fff : nvme
  fce00000-fcefffff : PCI Bus 0000:06
    fce00000-fce03fff : 0000:06:00.0
      fce00000-fce03fff : nvme
  fcf00000-fcffffff : PCI Bus 0000:05
    fcf00000-fcf03fff : 0000:05:00.0
    fcf04000-fcf04fff : 0000:05:00.0
      fcf04000-fcf04fff : r8169
fd300000-fd37ffff : amd_iommu
fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec10fff : Reserved
  fec10000-fec10fff : pnp 00:04
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed40000-fed44fff : Reserved
fed80000-fed8ffff : Reserved
  fed81200-fed812ff : AMDI0030:00
  fed81500-fed818ff : AMDI0030:00
    fed81500-fed818ff : AMDI0030:00 AMDI0030:00
fedc0000-fedc0fff : pnp 00:04
fedc4000-fedc9fff : Reserved
  fedc5000-fedc5fff : AMDI0010:03
    fedc5000-fedc5fff : AMDI0010:03 AMDI0010:03
fedcc000-fedcefff : Reserved
fedd5000-fedd5fff : Reserved
fee00000-fee00fff : pnp 00:04
ff000000-ffffffff : pnp 00:04
100000000-3ee2fffff : System RAM
  30d800000-30e3a3d47 : Kernel code
  30e400000-30e81efff : Kernel rodata
  30ea00000-30eb108ff : Kernel data
  30f00e000-30f1fffff : Kernel bss
3ee300000-40fffffff : Reserved
410000000-ffffffffff : PCI Bus 0000:00
  fc00000000-fe0fffffff : PCI Bus 0000:01
    fc00000000-fe0fffffff : PCI Bus 0000:02
      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0
        fe00000000-fe0fffffff : 0000:03:00.0
  fe20000000-fe301fffff : PCI Bus 0000:08
    fe20000000-fe2fffffff : 0000:08:00.0
    fe30000000-fe301fffff : 0000:08:00.0
  fe30300000-fe304fffff : PCI Bus 0000:04
    fe30300000-fe303fffff : 0000:04:00.0
      fe30300000-fe303fffff : 0000:04:00.0
    fe30400000-fe30403fff : 0000:04:00.0
    fe30404000-fe30404fff : 0000:04:00.0

Cpu (0 of 16):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 5800H with Radeon Graphics
stepping	: 0
microcode	: 0xa50000c
cpu MHz		: 4187.420
cache size	: 512 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat=
 pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_apic=
id aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2ap=
ic movbe
popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy=
 abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfc=
tr_core
perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba i=
brs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a=
 rdseed adx
smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occ=
up_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd=
 cppc arat
npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists=
 pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku os=
pke vaes
vpclmulqdq rdpid overflow_recov succor smca fsrm debug_swap
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso ibpb_=
no_ret spectre_v2_user tsa vmscape
bogomips	: 6388.20
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

Pci devices:
# lspci -tvnn
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root =
Complex [1022:1630]
           +-00.2  Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU=
 [1022:1631]
           +-01.0  Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Ho=
st Bridge [1022:1632]
           +-01.1-[01-03]----00.0-[02-03]----00.0-[03]--+-00.0  Advanced M=
icro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] [1002:=
73ff]
           |                                            \-00.1  Advanced M=
icro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP Audio Controller [1002:ab2=
8]
           +-02.0  Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Ho=
st Bridge [1022:1632]
           +-02.1-[04]----00.0  MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80=
MHz [14c3:0608]
           +-02.2-[05]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/81=
68/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
           +-02.3-[06]----00.0  Kingston Technology Company, Inc. KC3000/F=
URY Renegade NVMe SSD [E18] [2646:5013]
           +-02.4-[07]----00.0  Micron/Crucial Technology P1 NVMe PCIe SSD=
[Frampton] [c0a9:2263]
           +-08.0  Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Ho=
st Bridge [1022:1632]
           +-08.1-[08]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Cez=
anne [Radeon Vega Series / Radeon Vega Mobile Series] [1002:1638]
           |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Ren=
oir Radeon High Definition Audio Controller [1002:1637]
           |            +-00.2  Advanced Micro Devices, Inc. [AMD] Family =
17h (Models 10h-1fh) Platform Security Processor [1022:15df]
           |            +-00.3  Advanced Micro Devices, Inc. [AMD] Renoir/=
Cezanne USB 3.1 [1022:1639]
           |            +-00.4  Advanced Micro Devices, Inc. [AMD] Renoir/=
Cezanne USB 3.1 [1022:1639]
           |            +-00.5  Advanced Micro Devices, Inc. [AMD] Audio C=
oprocessor [1022:15e2]
           |            +-00.6  Advanced Micro Devices, Inc. [AMD] Family =
17h/19h/1ah HD Audio Controller [1022:15e3]
           |            \-00.7  Advanced Micro Devices, Inc. [AMD] Sensor =
Fusion Hub [1022:15e4]
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller=
 [1022:790b]
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022=
:790e]
           +-18.0  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 0 [1022:166a]
           +-18.1  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 1 [1022:166b]
           +-18.2  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 2 [1022:166c]
           +-18.3  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 3 [1022:166d]
           +-18.4  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 4 [1022:166e]
           +-18.5  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 5 [1022:166f]
           +-18.6  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 6 [1022:1670]
           \-18.7  Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric;=
 Function 7 [1022:1671]


Bert Karwatzki

