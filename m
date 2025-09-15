Return-Path: <linux-edac+bounces-4800-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C05B56DB4
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 03:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBDB18976CE
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B931448D5;
	Mon, 15 Sep 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="jl4uq5O5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768F2C181;
	Mon, 15 Sep 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757898051; cv=none; b=ZT+6T41GL9cNX//U3e7oUuh9rjnTNRomT04UM701cssL8lVU3dDejxFqW+VyNigPIah0L5s1ntxzTEmwiYDnXiq6MtYEKlYPmALX31nOChw1PFhEH6yqAjimU6vmqrcG9Z3qJNQGLOb0FIfQ6A1qSZ7NrW/Abw89CeYxJApwXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757898051; c=relaxed/simple;
	bh=NzN9rjVJQ+9EoqpW5aOLzYJjWUlAVKwEbf7e/tgTI6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGwUIi0jsIrUVkeYkHuLs4jjCzdbl0lS18pcZ7weRXNLjY3twrg7zOf8pxQcRHXACmU7+EHDbCbXTgtApa0HX550/hwwI8mc+rOEYCkceG02L47uVJScFs7W7yjVn4SDV9q8M6VwNOI/3YZYn++biRH07aXEZQmZ4EnsmSEhB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=jl4uq5O5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757898015; x=1758502815; i=spasswolf@web.de;
	bh=VGFoDMyPFuUpDSYcboPvOFSN6QkbwjmIPVFfUtrHzig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jl4uq5O5+qnKX0N+kQSCJVaH/nMmvGJU2wbLhGDkOntB0iINLZwaMjV0Xif9yHss
	 8jfRVuc6e0Er/HXQ8KcfPKWBAQKcvshNh/ca5KiS4PXfGIC2NKlGwYml9cI6S/siM
	 imSws9D6Ad16tnuI6z/Nu1FfL3mc+0yuL4iN1If0vGkM9Zax2t9UowNOGMkX6u8eM
	 mUp4gbGnqlblRUPkNW+ho1YG5488l8s9qE8NmEOBX4JPaNeYnnIoZWGq4RB1hAu3W
	 Up3G+oag7ALl5VYJ7CzvbWgBj2p8/bRpq2At5djXH2pQF+CLx4zc8BwfalMZ0WP3+
	 71RHNc4p3x4d/4/0Cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N30dT-1uGpHf3ssP-012mT3; Mon, 15 Sep 2025 03:00:15 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	x86@kernel.org,
	rafael@kernel.org,
	qiuxu.zhuo@intel.com,
	nik.borisov@suse.com,
	Smita.KoralahalliChannabasappa@amd.com
Subject: spurious mce Hardware Error messages in next-20250912
Date: Mon, 15 Sep 2025 03:00:09 +0200
Message-ID: <20250915010010.3547-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: 20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com
References: 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNh5W7o0sGw2tu3AAaWth41d+FZXAKBijQruaUs5pxCRE2B71sM
 c7AaO0ugWHKYc4nixAuR1gKc/4bRkobRByBslxZeiOO66f3ki7ykmWocBAgKIdK/CcaRA5o
 /NIoqELQoqvP9E8L2DKzxEvLmFWSCcIvYT/J0OgSVi99ILdV7qfGgf0eeaDY5LKlE9Ujloo
 Qh/bfLcfZCmyFHrz+kCWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ChJG+CxSw1Y=;doF7wlOYm+8sLH3OP4GqrgmLcOU
 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
 O5gpw+C0ou6Ea5dX89C

On my MSI Alpha 15 (amd64) laptop running debian stable(trixie) and =20
kernel next-20250912 I noticed the following mce error message in demsg:

[   T10] mce: [Hardware Error]: Machine check events logged
[   T10] [Hardware Error]: Corrected error, no action required.
[   T10] [Hardware Error]: CPU:0 (19:50:0) MC11_STATUS[-|CE|-|AddrV|-|-|-|=
UECC|-|Poison|-]: 0x8400aa4800a90139
[   T10] [Hardware Error]: Error Addr: 0x006637a200000020
[   T10] [Hardware Error]: IPID: 0x000700b040000000
[   T10] [Hardware Error]: L3 Cache Ext. Error Code: 41
[   T10] [Hardware Error]: cache level: L1, tx: GEN, mem-tx: DRD
[   T10] mce: [Hardware Error]: Machine check events logged
[   T10] [Hardware Error]: Corrected error, no action required.
[   T10] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|CE|-|AddrV|PCC|-|=
SyndV|UECC|-|Poison|-]: 0x8724ac0800000000
[   T10] [Hardware Error]: Error Addr: 0x002bf52e00000020
[   T10] [Hardware Error]: IPID: 0x000700b040000000, Syndrome: 0x000000000=
0000042
[   T10]=20
[   T10] [Hardware Error]: L3 Cache Ext. Error Code: 0
[   T10] [Hardware Error]: cache level: RESV, tx: INSN

The messages start about 333.34s after boot and usually appear 327.68s app=
art
(Yes, these timings are reproducible!):
$ dmesg | grep mce
[  333.338334] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[  333.338354] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[  661.018322] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[  661.018347] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[  988.698305] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[  988.698329] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[ 1316.378283] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[ 1316.378311] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[ 1644.058284] [     T10] mce: [Hardware Error]: Machine check events logg=
ed
[ 1644.058303] [     T10] mce: [Hardware Error]: Machine check events logg=
ed

As these messages do not appear in v6.17-rc5 I bisected the issue=20
(from v6.17-rc5 to next-20250912) and found this as the first bad commit:

cf6f155e848b ("x86/mce: Unify AMD DFR handler with MCA Polling")

Are these error messages a new error that was not reported previously or
are these error messages a sign that the new code erroneously reports erro=
rs?

Hardware used:
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Roo=
t Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bri=
dge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCI=
e GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (re=
v 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev=
 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upst=
ream Port of PCI Express Switch (rev c3)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Down=
stream Port of PCI Express Switch
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23=
 [Radeon RX 6600/6600 XT/6600M] (rev c3)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HD=
MI/DP Audio Controller
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/=
8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. =
KC3000/FURY Renegade NVMe SSD [E18] (rev 01)
07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe =
PCIe SSD[Frampton] (rev 03)
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] =
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon=
 High Definition Audio Controller
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 1=
7h (Models 10h-1fh) Platform Security Processor
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne =
USB 3.1
08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne =
USB 3.1
08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Audio Co=
processor (rev 01)
08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1a=
h HD Audio Controller
08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] S=
ensor Fusion Hub

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 5800H with Radeon Graphics
stepping	: 0
microcode	: 0xa50000c
cpu MHz		: 2145.090
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
 pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_apicid =
aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic =
movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_=
legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext=
 perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pst=
ate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms inv=
pcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xget=
bv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf=
 xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale=
 vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsav=
e_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_re=
cov succor smca fsrm debug_swap
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso ibpb_=
no_ret spectre_v2_user tsa
bogomips	: 6388.44
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]


Bert Karwatzki

