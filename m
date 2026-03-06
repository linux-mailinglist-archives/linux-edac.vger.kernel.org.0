Return-Path: <linux-edac+bounces-5772-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNvcF3LeqmlqXwEAu9opvQ
	(envelope-from <linux-edac+bounces-5772-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 15:02:26 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A12223CD
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F0C301FD60
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6E31B836;
	Fri,  6 Mar 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iaz2sB7E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECED3254A2;
	Fri,  6 Mar 2026 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805663; cv=none; b=GSdcKXrgpL06M2eXvDkSwyFY64Yi+MnftyO8ds+En4obl8iFfHmoj9Pcw0Re6zYRBH7DKguLyP3UW/RNOvEVaYk12Pht5rD9bWNpWTpeDuNZmAINuNbXjQYi06ZuDwrrW8f2FarTwtEI0G4BOenV3pKDUyoo1vm5cehbTgNlVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805663; c=relaxed/simple;
	bh=6yPhRwWynLwBkGaSYlz0OV1u7wVCm8R2eA0o4TQzdWE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rdN2T/5RJEtOBJut+2Tm7UIrqPifZRwdmSh3CNT5gXcW/NrZYrZRn8u4TVvsMRPf9Dzs/oPrhzxvSAr7AUw/HRWeAf7h71z7C6l7UXcITkaHikZsTgditQECHVZJOxrXM2+ktByHn7NyLqPv3oLbwmW4NwTcrO6KdA9tDtjF2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iaz2sB7E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE16140E0169;
	Fri,  6 Mar 2026 14:00:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hhNWZ4LEtYVV; Fri,  6 Mar 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772805647; bh=6yPhRwWynLwBkGaSYlz0OV1u7wVCm8R2eA0o4TQzdWE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iaz2sB7EQaQjEjje4idBUYiViTLRMV4dfCH5z+jkrHMlsWawaVAbzbXuzGygszHu5
	 1r4jVRYtqbGQQqZRAiclvXAgNLyG8R4oixhnIh0i06/FMVYdCEl5R4aPqyvwMxNXDj
	 sDEzmOOVOJF/Uc9jWwIro5EtP0UoKbIrb70CPpTwh/oiO02QECT6sIV3qxKMvwYKih
	 cK0I4Ckqu/sTbWhOFheg50hhQ+Iex41BzUKg03ZCjKx/KBG0SkVQiRF4HZVopOw90k
	 uAekbSbO2rxR4mw7eJkNDe3XKGMIP5watiU+aBKTKL1NLid68qG+EHIG2Rf6/6PEgN
	 tTlfidVliZ0eCsOsaoMEZxVGfzxGsSZIDXqxFDPjGY9balag76jFfvdqUdjFq/qb39
	 fwTmGtRjGemvEbYWT7aJvSahHuNbntct/PErzE4jUbOeWyrItfazATMquYQzSZl5A6
	 iQm5RYEOa2XJLH3pQjYTd0FkkG7DqE9A7HOfa3Cq93TIsR2ChfQEJrjqtaeu65fveE
	 luSXiRKQwBXhDzMKNOIxX7cJUzMUmaACynHZkfHSDikUjADANkf6AvrAb0bgATPfCj
	 xmoHXT/Iar8S/qyFeQA2wZG0nqQYO68KOK0wD8+RVy3Z5wqvpRJVNUEvmydEtXsAse
	 KV0lPCpW60E7IdM6qarQo3QY=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3038:283:78da:391c:dd47:60a2:4090])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B36D340E00DA;
	Fri,  6 Mar 2026 14:00:33 +0000 (UTC)
Date: Fri, 06 Mar 2026 14:00:29 +0000
From: Borislav Petkov <bp@alien8.de>
To: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>,
 "Luck, Tony" <tony.luck@intel.com>
CC: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5B=E5=A4=96=E9=83=A8?=
 =?UTF-8?Q?=E9=82=AE=E4=BB=B6=5D_Re=3A_=5BPA?=
 =?UTF-8?Q?TCH=5D_x86/mce=3A_Fix_timer?=
 =?UTF-8?Q?_interval_adjustment_after_logging_a_MCE_event?=
User-Agent: K-9 Mail for Android
In-Reply-To: <3748e8c7057a4182bc2a361b44dda51b@baidu.com>
References: <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local> <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com> <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local> <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com> <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local> <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local> <aWbjkAPX9a9ZlJGN@agluck-desk3> <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local> <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local> <aYobX83_0kElO3NZ@agluck-desk3> <20260210150117.GBaYtIPfsP0Txw7iIc@fat_crate.local> <3748e8c7057a4182bc2a361b44dda51b@baidu.com>
Message-ID: <E4BFF14D-85CC-44FA-A217-603C102B1D66@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E24A12223CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-5772-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On March 6, 2026 7:37:01 AM UTC, "Li,Rongqing(ACG CCN)" <lirongqing@baidu=
=2Ecom> wrote:
>Is there any progress on this?

Not yet=2E

May I ask what is your usecase for this?=20

--=20
Small device=2E Typos and formatting crap

