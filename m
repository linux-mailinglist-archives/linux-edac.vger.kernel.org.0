Return-Path: <linux-edac+bounces-5729-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDUAFAGnmGmcKgMAu9opvQ
	(envelope-from <linux-edac+bounces-5729-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 20 Feb 2026 19:25:05 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C381C16A08C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Feb 2026 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 902973010BA8
	for <lists+linux-edac@lfdr.de>; Fri, 20 Feb 2026 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D7331A5F;
	Fri, 20 Feb 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="vh2uFKaF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5773002C8;
	Fri, 20 Feb 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611901; cv=none; b=psS1mH3gf3Ig7UUjgtekZThywWJPPe+PxICmmOzQuUWH5WD49coLWSKzgRmWuuwV+XsOPCjrViqbQvkrNTmuv4i8Y7T8wzVpXD8VtHxvSU8AWRwmDl4+z2Tpbc3A18zcnBRTDyUd5Vr1HD7eviWKY844aa0tDaizaYcN1n/4Nn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611901; c=relaxed/simple;
	bh=oHxqK0VoiGESsnz/lGBeNo2HagU6k8bgUZsZgftuL3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWjVyvCYheJlexmX5BlEPFseAM8wYZFgrKK3fgKYxcintJBi89pHdtJAd7yUC8szrZ8FvPWSR4talJP550+E8/8x4jxgWc4r9/3zsrgF4Qc/59z3wvgp5hh1Pdn9+0wQOcHJxwMZVAoio3eNLm2+82Ip3UHZNK9Je0V0LWA/Q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=vh2uFKaF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771611874; x=1772216674; i=spasswolf@web.de;
	bh=uhi4lV8KO0Vgo6e4TxcYTwBPrMn+t5N4VhyAmc9Ik7A=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vh2uFKaFouiX8sI+jPL5OUt01lPukssd619+S1OwWi0bLM0VE1Y6qg72qurGtY0T
	 qs6I4huppCy9iY79rDo1y4Kq6jvoyTNkqUedYfcNRoaXsnD4wI+L4Iz2X5pUkPdte
	 xhct7H4Y0RBg4+CUNVxV97F58N5ZaaDR3tRyGuixdQ7O7Wg3o0o3Rt6bhhhiPWn1+
	 WVuaR0CwgPT0iuZTPNtwA14BACb09CxBttKtSHtRP0GCXyEo+KlkNSVKTVtgSSSS2
	 z16KCivtDhYBoAEVILVFdB0ajL2piQvLqsNTiYcnoknTA/lTRIOLo2cKN8FybAbb3
	 l0m7smJyDWQFzTDuGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJjZ-1vvy9L160f-00Gxp8; Fri, 20
 Feb 2026 19:24:34 +0100
Message-ID: <290ee50cbe68d246a9899b03d5c7ddebc549f0bf.camel@web.de>
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
From: Bert Karwatzki <spasswolf@web.de>
To: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam
	 <yazen.ghannam@amd.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, spasswolf@web.de, Borislav
 Petkov	 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 	linux-next@vger.kernel.org,
 linux-edac@vger.kernel.org, 	linux-acpi@vger.kernel.org, x86@kernel.org,
 rafael@kernel.org, 	qiuxu.zhuo@intel.com,
 Smita.KoralahalliChannabasappa@amd.com
Date: Fri, 20 Feb 2026 19:24:32 +0100
In-Reply-To: <8530d765-6676-4ba4-98b5-07326c8dc924@amd.com>
References: <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
	 <20250917144148.GA1313380@yaz-khff2.amd.com>
	 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
	 <20250917192652.GA1610597@yaz-khff2.amd.com>
	 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
	 <20250918210005.GA2150610@yaz-khff2.amd.com>
	 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
	 <20251009132055.GA472268@yaz-khff2.amd.com>
	 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
	 <20260216202546.GA420258@yaz-khff2.amd.com>
	 <20260219143345.GA5486@yaz-khff2.amd.com>
	 <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
	 <8530d765-6676-4ba4-98b5-07326c8dc924@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dI2PakJwSMYq+ARwHU2JdWMbDElFwbgRcMD40NYd02/kxuSPdgU
 BLxwSYieZSKeK4tZKZAsPWBkYrAVTngm4v5kSrrlh0nZoKee368ofuAVLgv+BK0LUpaZXvB
 s3KMe4z1IMGb/4KhD4qr5QWZp5oKDFaI+ayyQRHAvfxMotD25blD50ObZ48AK4H6mLRjrB8
 r8wdwDKmzTpiQ7DGpZHAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5APjqxnZ5p8=;ixgtSEiufBJPQaBPs9AHMgUy4TW
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5729-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FREEMAIL_CC(0.00)[suse.com,web.de,alien8.de,intel.com,vger.kernel.org,kernel.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alternate.de:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C381C16A08C
X-Rspamd-Action: no action

Am Freitag, dem 20.02.2026 um 10:49 -0600 schrieb Mario Limonciello:
>=20
> On 2/19/2026 9:43 AM, Bert Karwatzki wrote:
> > Am Donnerstag, dem 19.02.2026 um 09:33 -0500 schrieb Yazen Ghannam:
> > > On Mon, Feb 16, 2026 at 03:25:46PM -0500, Yazen Ghannam wrote:
> > > > On Thu, Feb 12, 2026 at 01:50:05PM +0100, Bert Karwatzki wrote:
> > >=20
> > > [...]
> > >=20
> > > > >=20
> > > > > 2026-02-10T16:15:01.001203+01:00 lisa kernel: [    C0] smca_shou=
ld_log_poll_error: 1
> > > > > 2026-02-10T16:15:01.001815+01:00 lisa kernel: [T45426] mce: [Har=
dware Error]: Machine check events logged
> > > > > 2026-02-10T16:15:01.001818+01:00 lisa kernel: [T45426] [Hardware=
 Error]: Deferred error, no action required.
> > > > > 2026-02-10T16:15:01.001819+01:00 lisa kernel: [T45426] [Hardware=
 Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x=
8700900800000000
> > >=20
> > > Hi Bert,
> > >=20
> > > The CPU stepping indicates that this isn't a production model.
> > >=20
> > > Can you please share more info on your system? Is it a production la=
ptop
> > > or a pre-production sample?
> > >=20
> > > Thanks,
> > > Yazenit
> >=20
> > As far as I know is a production Laptop, a MSI Alpha 15 B5EEK/MS-158L =
model with
> > bios version "BIOS E158LAMS.10F 11/11/2024" (the newest version availa=
ble at
> > https://de.msi.com/Laptop/Alpha-15-B5EX/support?sku_id=3D89840)=C2=A0a=
nd without
> > preinstalled Windows=C2=A0which=C2=A0I bought in=C2=A0December 2021 at=
 www.alternate.de (a shop
> > which MSI lists as a "trusted partner":=C2=A0https://de.msi.com/servic=
e/bzq)
> >=20
> > Bert Karwatzki
>=20
> Do you know if it was purchased "right around" when it launched?  I'm=20
> wondering if it's possible they used pre-production parts for some=20
> reason with their initial systems.
>=20
> The reason for this line of inquiry is if this is what we would have=20
> considered pre-production silicon, it might be more appropriate to flag=
=20
> the CPU accordingly and ignore these MCEs.

Yes, I bought right when it became available.

Bert Karwatzki

