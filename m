Return-Path: <linux-edac+bounces-5727-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDSWARQxl2kcvgIAu9opvQ
	(envelope-from <linux-edac+bounces-5727-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 19 Feb 2026 16:49:40 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8641605C7
	for <lists+linux-edac@lfdr.de>; Thu, 19 Feb 2026 16:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0CA6309D421
	for <lists+linux-edac@lfdr.de>; Thu, 19 Feb 2026 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6F34887B;
	Thu, 19 Feb 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="JYvDZpJt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4734846C;
	Thu, 19 Feb 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515851; cv=none; b=AOI9qfvezKp56bF7ErPSpfGQ3hBu11nZTavV/T9nmy5qa8hHnkWFZZjcBop4n2LKeBHq16D7P0g1X7J9siI8PKJTkSULToquWPwvc6rY9FB+frdyu+Q79Ur/UZasKhHcTbYeEwYFgf6u692TuKNYmA/mN0d1sUjmrL6Qg9Z2oL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515851; c=relaxed/simple;
	bh=kCGePlFJkmeTteqAMsHSq8kPLAdNjKjdlOu33iyAOdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JqXqAn/OHbemRiqHsPbZ7Xjmlxh94WPZKJBRJ+kHRKUNL27YhnVI37aM/nzJ69NuOGA44s4Yb2ONTFojfHgH1y2/rEVi3P7fS/eV3gaAJR/wkLJdTJaVRaYVv9uIsS7dbYeoROKcBlZV6ZljrNFkTJ2IU5WLXrMseqqyC/xLrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=JYvDZpJt; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771515821; x=1772120621; i=spasswolf@web.de;
	bh=D+WRABvE0ljfm+qRJRni4zTzrYA5KHwJ77KWhBMHSAo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JYvDZpJtxeijSsVK+4hunJ3HUWrTR3h0LvfTlsSOR9V9XGIdblXmi88naICJJujv
	 ZEYJ2KsLWxDy6wQItpLomEWU+hCdN7zpHAcSg5J1b3HE33032G+rp0tr8tpHw7bwL
	 dGPpMLDBLeYhHhumsWIgo2TcPVLEH5snbyLpC34HnGlPLR4LMEGpx69pPnyufbk0i
	 0PpI7Uq/2psTFIOdlKEBlH4blvshOQ7oUhOy1+IGjPYukAQu8KjnSNqj+92vNawyI
	 6wAHDz9QMQmCoPoZ1cL7SmZ1ohz224JtX0o5+H89C+zvxpi3MrP22p89UKtx/hGTS
	 NuQ2lklo3IZsIhBk2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7am-1vMlRL2Ncs-00bIRk; Thu, 19
 Feb 2026 16:43:41 +0100
Message-ID: <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, "spasswolf@web.de Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 	linux-next@vger.kernel.org,
 linux-edac@vger.kernel.org, 	linux-acpi@vger.kernel.org, x86@kernel.org,
 rafael@kernel.org, 	qiuxu.zhuo@intel.com,
 Smita.KoralahalliChannabasappa@amd.com, Mario Limonciello	
 <mario.limonciello@amd.com>
Date: Thu, 19 Feb 2026 16:43:39 +0100
In-Reply-To: <20260219143345.GA5486@yaz-khff2.amd.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V8DgLdRqy3Y/CH7KTkLP+351jk8a1pyBeIMdy0UPthXZbR5x91b
 plXUhC++ptpzrsjPFv4SzdFZsl2Rt4UMKwk7obCwuOs/LCqap3JAztdAvGUb4Edu0GIFcjT
 kmA0OZb+2ebO96Y0xdJxZvM2MlJogklYs1Ltd0qhI1+CvU5kBtZuLknpskCe/irFXKL4B7e
 mkV74UdmmzQULP0ZBQSXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tfqJqRMSh9I=;wfMzYYTg3aoHpl63k10NPvco1WT
 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
 pYjnU9Go=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5727-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alternate.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7A8641605C7
X-Rspamd-Action: no action

Am Donnerstag, dem 19.02.2026 um 09:33 -0500 schrieb Yazen Ghannam:
> On Mon, Feb 16, 2026 at 03:25:46PM -0500, Yazen Ghannam wrote:
> > On Thu, Feb 12, 2026 at 01:50:05PM +0100, Bert Karwatzki wrote:
>=20
> [...]
>=20
> > >=20
> > > 2026-02-10T16:15:01.001203+01:00 lisa kernel: [    C0] smca_should_l=
og_poll_error: 1
> > > 2026-02-10T16:15:01.001815+01:00 lisa kernel: [T45426] mce: [Hardwar=
e Error]: Machine check events logged
> > > 2026-02-10T16:15:01.001818+01:00 lisa kernel: [T45426] [Hardware Err=
or]: Deferred error, no action required.
> > > 2026-02-10T16:15:01.001819+01:00 lisa kernel: [T45426] [Hardware Err=
or]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700=
900800000000
>=20
> Hi Bert,
>=20
> The CPU stepping indicates that this isn't a production model.
>=20
> Can you please share more info on your system? Is it a production laptop
> or a pre-production sample?
>=20
> Thanks,
> Yazenit=20

As far as I know is a production Laptop, a MSI Alpha 15 B5EEK/MS-158L mode=
l with
bios version "BIOS E158LAMS.10F 11/11/2024" (the newest version available =
at
https://de.msi.com/Laptop/Alpha-15-B5EX/support?sku_id=3D89840)=C2=A0and w=
ithout=C2=A0
preinstalled Windows=C2=A0which=C2=A0I bought in=C2=A0December 2021 at www=
.alternate.de (a shop
which MSI lists as a "trusted partner":=C2=A0https://de.msi.com/service/bz=
q)

Bert Karwatzki=20

