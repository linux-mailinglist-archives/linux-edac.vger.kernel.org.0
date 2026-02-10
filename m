Return-Path: <linux-edac+bounces-5705-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCQgMZ9Ji2l1TwAAu9opvQ
	(envelope-from <linux-edac+bounces-5705-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 10 Feb 2026 16:07:11 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808C11C412
	for <lists+linux-edac@lfdr.de>; Tue, 10 Feb 2026 16:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207F03059A94
	for <lists+linux-edac@lfdr.de>; Tue, 10 Feb 2026 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2D36999C;
	Tue, 10 Feb 2026 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cni7BlbC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A728DC4;
	Tue, 10 Feb 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735702; cv=none; b=Dgy7vv7+GGzwoM4UJsjHtwvxNNFkpyBmG8Q3NiV1Z2Mr7TpiNu06i9rImxMAEmpZRh3J5aW6oIv22UwUA21gQ46TE/D7GG2ssGuG3DCbKDTr0Vuf1vHDLliHNu8bDErByfnaCqfYYDcng8vf2mHfdZNO+aECwklZ1PGls1EVbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735702; c=relaxed/simple;
	bh=AUqHiXJVyBVvHJPmKtQH65Q5nTB8s+UrevFWcLP6O60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUDxLlJNu7vqp2lw8KsJxSt0gkrjA3BYba4JmYPjBjQqUXSrQ4VQ6A6S12hIN2yxWrW6jnKBlZW4HyFa3106qvFMN1VRrzv71kvXpzYhEcB7AOaPkxZOlsSkZ4loqWcmhw9W2RK9Vlsl3I8g4SxkZkd8fDomTmmbc87Yf4QphTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cni7BlbC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5E9140E0359;
	Tue, 10 Feb 2026 15:01:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vx_-O3iOk-S5; Tue, 10 Feb 2026 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770735691; bh=GB0CDXcVvisIEvyxlnnxPyp9pxxsUffhqntNVQCCHZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cni7BlbCAZrGBRo6NhL5+CVSAnaFplo8a8QQ8Oi4O+gYh9SFrAk2bzYqLY1Erj05W
	 gota/Bnvt9BdF1Egc6L6ZkwC/HlAaTKFIQ2RnxQzKwXVV5WbwL/txn6S+jdrk1G8TS
	 Outmy7bCCeGCi07H8UxGuz9R1wyD7lHZLuMcamz6f8EkF666gocpCHyjHqtcpGCsLr
	 FoqvexbXNPGcYl2G+znYDEFnlB97tUfyb+H/Qv+0F5zcdnwOuaqRQATkeiHqdubJwa
	 Vbx1sSvJzdcLMSvwwrUPpw1LRLSeFy3OmEGx1Y+o+QQnhc/6JZIHSDFqnJ2uzV39cY
	 9KIhdC7FhRy1xoX932B1M/onqjqb9kfwvvmYhwOhj12sXZm5EQmX/nl/isXzbAji/a
	 XRP8sBrFP+bW7/YBcYxwIW7tM79f2tnog01hfvBOcqUe/5zDtE20A040skqMquxg5G
	 G019cfPaA/zHWNw4jTEHq5Bz/8HtM8cPDWgUQo/73mVKErbyQBj50dlVhCd5nxhx8V
	 +0R1IGFMVpSC9w42Pd35Nb3CWzVtsKyZjMOuE7UA3XBAWE8FUr5oeTtig4zYO7XPFp
	 Fda0TZbF0TK/JIo8rlWWvr0tAc3x7W0RbR+1J915njDdm9a+O3Sp0AXr+mDQ5YZvPV
	 6ZPAISjo1xIvPcQi17Huza4Q=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2BC4240E01A3;
	Tue, 10 Feb 2026 15:01:18 +0000 (UTC)
Date: Tue, 10 Feb 2026 16:01:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <20260210150117.GBaYtIPfsP0Txw7iIc@fat_crate.local>
References: <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
 <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local>
 <aYobX83_0kElO3NZ@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYobX83_0kElO3NZ@agluck-desk3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5705-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 2808C11C412
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:37:35AM -0800, Luck, Tony wrote:
> If the system is now running in some mixed mode of polling and
> interrupts, then it is unclear what should be done in various
> new cases.

Well, what about CMCI? AMD has similar interrupt types. Those handlers end up
in the same path of machine_check_poll() and the above scenario can happen,
AFAICT.

> I don't think we care. If we miss out halving the interval becuause an
> error was logged between timer based polling, nothing really bad will
> happen. The interval might get sorted out on the next interval.

Right, that's what I'm thinking too.

> Unless someone has a real world case where something is going badly
> wrong, then I don't think any changes are needed to cover this race.

Ok, let's try the simple thing first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

