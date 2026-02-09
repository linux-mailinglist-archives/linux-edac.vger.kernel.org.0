Return-Path: <linux-edac+bounces-5699-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ1xLzMbimmtHAAAu9opvQ
	(envelope-from <linux-edac+bounces-5699-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:36:51 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DCE11317E
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790D4301589E
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862C73816E1;
	Mon,  9 Feb 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CSkPuTIj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CC3815FA;
	Mon,  9 Feb 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658606; cv=none; b=KFG0FHlwgYkTgTD3Z4VK+Y9vVS5F9+n1TreeHIQwpnQIEc2bXeK8TpMplAFnE69dR024VcoVFWaT1T3XRvcXLNAkO8s+XyiyTpZtb+tp5ofZxb0fs84fijpoN/AsmObAeV5QEOh58S+Ky8wLCLYqlBYsCL5VyOVcxgJQJrXswbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658606; c=relaxed/simple;
	bh=MWzbR32ggntRD+QOU28sW//hjot6UcidDqeHEXJvrnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTc7l7kGW+sHS4ufnOpFA4Qh9BEqnXXS5GqPD7qAceJyZYzH6KA9M99jvXXBkPYDzRIJ3noqkMyOGfPBDDnnR9yeAGUxCsl4bKeW4jyfmFzKSPgWuUpmaYuvBSjlwTh37nyKxCSNFlu1EZld82VtXMQMXPzLxB5r3ajFn7PDr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CSkPuTIj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3BC6540E0364;
	Mon,  9 Feb 2026 17:36:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HqaZyZOuxbgM; Mon,  9 Feb 2026 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770658599; bh=JStRanCHaM3CSN28+ei1pKlDV7+R6Xn9iD8gHB8uxMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSkPuTIj6+Nlg24yvKhgPYKQ+LS2lDNJ9CvRrPhyIL5XFb53hqWeOatQbzh3szAxJ
	 IeE4xL5yAbyCzn7U1sldBbHkYerXc0yTgHHpanirfwHGqJs6d+hf4QUl3r0YlHsvaY
	 V6O+mR5DLvPXmJCaSH6+lNMzh9hphCmQXpcITNShyfNFQpC+i6ktVwpvq8wL+kMgGZ
	 v8k+vlALJvMPynxGI4b9rBKOpz98AZNSwcgFT2UaQuFfI+97sywlejlJHS5OTc3Cg9
	 eEyehyyPQCjhFctMzPVEhUuHpWBWXcoHlnLgFciKQHKuEaq2b5Pmr3+zyuV6Vbdo2b
	 WiWAFlDTmzZanGjfok8PH7KTGLv1N2DwbIyW43eC9cz52AsNpfHfs1IxERXi71IhOX
	 D9ofFiKj9dDb2wIyFHjy4wub1DgbLcxFw9h5YASAQrxNtiGOKwYDSXEj2JTQrDlZxG
	 19QIixiiB97WdUxkUJ7lxXRhbD/meDwDLHihhdxKI535JK1c4QxCT8iPGRkqQww17b
	 m5rLGYSD7reZV4fxNyHba6L3Rup3qBy4kDHjlmxeqG1n4OK6IZvtqyRxq56RSuk5zg
	 ZTbXO0eEN/FC1Ryf77PLQm3gBKvGvMp+qwPbbGljFroHE+jeMAEsBlSS/alyvZnB4H
	 4fVTe+JRlaFloy+ZXAtUWjRo=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E228840E035A;
	Mon,  9 Feb 2026 17:36:26 +0000 (UTC)
Date: Mon, 9 Feb 2026 18:36:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: William Roche <william.roche@oracle.com>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	"Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
Message-ID: <20260209173619.GCaYobE1nME_z-1z2U@fat_crate.local>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5699-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 54DCE11317E
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 05:36:32PM +0100, William Roche wrote:
> An AMD Qemu VM running this kernel is no longer able to deal with the
> injection of a deferred memory error, and crashes with:
> 
> [  333.420854] mce: MSR access error: WRMSR to 0xc0002098 (tried to write
> 0x0000000000000000) at rIP: 0xffffffff8229894d (mce_wrmsrq+0x1d/0x60)
> [  333.428105] Call Trace:

Works as advertized - KVM is not allowing the MSR write.

This enablement is not meant for VM use. Why do we care about injecting hw
errors in a guest?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

