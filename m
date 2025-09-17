Return-Path: <linux-edac+bounces-4821-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DEB8098D
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A789A169DAB
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E572253E4;
	Wed, 17 Sep 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="YNEWF3Ru"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1930C11D;
	Wed, 17 Sep 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123232; cv=none; b=mu9UWwrzbZ/RsyaHvlZ6szZN5pOOEHbrMAAEcYWeUSL4lu/VhMolDaMBg/LHshnfcbG3A1UnCab1lWZ3PFmB0445k+8ZDsDI94URf95qjgxylY10GCD9I4LgQBIKA9zsMgytSb1gAfRS9k8L1JRGA0D80vCmcyq+sLMuml6Uf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123232; c=relaxed/simple;
	bh=UurQylgiDEDl9Pz4L2rJzvLIIaIqsxK5mRNU0/F2xFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+/72LcTPYap90unszSTyZCEGe6GkAwOI1KzVaH4OnkTERCP1/bQqjZooLFoOu7Zh88xFCqEKvdUyoBvNnjCCLfM0QlKFpeZhPPHcJpiJGM/usNGRWVO5RWW/VfUNM5D6+w64JogxZrmi52PK+FueqIH42StVIEDREiAuNI2Ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=YNEWF3Ru; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758123211; x=1758728011; i=spasswolf@web.de;
	bh=/BBdLW1DmUltB0TlZXSCX5FRF8LtiX81a3p4s7tOzv8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YNEWF3RuFW46XYXgAR+kwXkC+xunR+xh8Mam+G7jcpyLIdxHmy9b8WwvNrfCguoQ
	 PaInx3S1CMaRMiYRHIpiJIjdneZURdxeqDWtRNAR9nyE478bAX6I55BVxNmSoA+aN
	 Y4Y0x1cabf4Wnxi47hQMNJkIc5uJ0h68ATpALuJbK5Wx+sleBcpQVJAkXAVGGV7HS
	 FNvlnY0viIWKhXr/IUo5qLdY46mHfJdKJpk9vTuusYu2287GSNK/PPA4MUY8bfGcv
	 nXeLLNOOXop4JGsu90kVNOlsTjuFkXJEL+fgnmJ4V+N1qag/1fazuZdF4RRabBT1D
	 TVTgpDjzONY0mwsUWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFs1t-1vAko01OvP-003kCX; Wed, 17
 Sep 2025 17:33:31 +0200
Message-ID: <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
Subject: Re: spurious mce Hardware Error messages in next-20250912
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, 
	rafael@kernel.org, qiuxu.zhuo@intel.com, nik.borisov@suse.com, 
	Smita.KoralahalliChannabasappa@amd.com, spasswolf@web.de
Date: Wed, 17 Sep 2025 17:33:29 +0200
In-Reply-To: <20250917144148.GA1313380@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
		 <20250915175531.GB869676@yaz-khff2.amd.com>
		 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
		 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
		 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
		 <20250916140744.GA1054485@yaz-khff2.amd.com>
		 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
		 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
		 <20250917144148.GA1313380@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yEbApr4Aiiyd6PFmD/x3Qjf2Cb0WulChfbx5WC1MReyM++am1NU
 g2CEMbjhAKwmLOeOsLXnFyRUbRlc0cov5WnNL4ZpA8+4T1smAVLNrggrFAg4t3u0bFDoUEt
 rQ4+KauRw8N6AonB2d6MZp3ILcUZJYMBCr0QU+gvploQ9GXN3gaQwTVpsQULwHsu549yLsL
 BHhJxhb3aEGNQKhaFMoqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GGPPV8Usx9g=;WGNxukUjX1OoZvqxQdcMSaonzB9
 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

Am Mittwoch, dem 17.09.2025 um 10:41 -0400 schrieb Yazen Ghannam:
> On Wed, Sep 17, 2025 at 09:13:11AM +0200, Bert Karwatzki wrote:
> > Am Dienstag, dem 16.09.2025 um 22:27 +0200 schrieb Bert Karwatzki:
> [...]
> >=20
> > I ran a test for 10h and got one real deferred error, I also looked th=
rough
> > older logs (which only go back to 2025-08-17) and they do not contain =
any
> > mce Hardware errors. Here's the output of
> >=20
> > $ dmesg | grep -E "mce|Hardware Error"
> > [...]
> > [10163.739261] [   T9326] mce: [Hardware Error]: Machine check events =
logged
> > [10163.739265] [   T9326] [Hardware Error]: Deferred error, no action =
required.
> > [10163.739267] [   T9326] [Hardware Error]: CPU:0 (19:50:0) MC14_STATU=
S[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
> > [10163.739275] [   T9326] [Hardware Error]: Error Addr: 0x009546410000=
0020
> > [10163.739276] [   T9326] [Hardware Error]: IPID: 0x000700b040000000
> > [10163.739278] [   T9326] [Hardware Error]: L3 Cache Ext. Error Code: =
0
> > [10163.739279] [   T9326] [Hardware Error]: cache level: RESV, tx: INS=
N
> > [...]

This seems to be a real deferred errror.

>=20
> Summary so far:
> 1) Errors are found on CPU0 banks 11 and 14.
> 2) Errors are found during MCA timer-based polling.
> 3) The data is coming from MCA_DESTAT register.
> 4) The status bits are not consistent with documentation.
> 5) Likely these errors are not generating a deferred error interrupt.
>=20
> Bert, can you please collecting the following data?
>=20
> 1) Output of "/proc/interrupts".
>   a) The MCE, MCP, THR, and DFR lines are of interest.
>   b) We should verify if any other notification types occur besides
>      "MCP" (MCA polling).

This is from next-20250916 (without the debug patch), unfortunately I've
already rebooted after the testrun with next-20250912 and your debug patch=
.

$ cat /proc/interrupts | grep -E "DFR|THR|MCE|MCP"
 THR:          0          0          0          0          0          0   =
       0          0          0          0          0          0          0=
          0
0          0   Threshold APIC interrupts
 DFR:          0          0          0          0          0          0   =
       0          0          0          0          0          0          0=
          0
0          0   Deferred Error APIC interrupts
 MCE:          0          0          0          0          0          0   =
       0          0          0          0          0          0          0=
          0
0          0   Machine check exceptions
 MCP:         39         39         39         39         39         39   =
      39         39         39         39         39         39         39=
         39
39         39   Machine check polls



> 2) Using an older kernel, read the MCA_DESTAT registers for L3 cache.
>   a) CPU0 bank 11: "sudo rdmsr -p 0 0xC00020b8"
>   b) CPU0 bank 14: "sudo rdmsr -p 0 0xC00020e8"
>   c) If these are non-zero, then I think we can confirm that the
>      spurious data was always there.
>=20
> Thanks,
> Yazen

This is from 6.12.43+deb13-amd64 (the stock debian trixie kernel, currentl=
y the
oldest version I have installed):

# rdmsr -p 0 0xC00020b8
8700aa0800000000
# rdmsr -p 0 0xC00020e8
8700a28800000000


Bert Karwatzki

