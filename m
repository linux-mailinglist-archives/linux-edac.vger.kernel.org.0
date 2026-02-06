Return-Path: <linux-edac+bounces-5695-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ma2BwNnhmmAMwQAu9opvQ
	(envelope-from <linux-edac+bounces-5695-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Feb 2026 23:11:15 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D80103ABA
	for <lists+linux-edac@lfdr.de>; Fri, 06 Feb 2026 23:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D333035D53
	for <lists+linux-edac@lfdr.de>; Fri,  6 Feb 2026 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094C309F0D;
	Fri,  6 Feb 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VWhXZbKo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D23303A1A;
	Fri,  6 Feb 2026 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770415866; cv=none; b=TQiJzWjaXcxTXUpfnXO+xlvoS1kTDGzJcaC7eGYa20PomMjzUhEr6ZrJGk4MsSXvmPtrV59O39PI3Ky5mCRDyw8ABQqzM/wdTulKJLePVqb9dzCinuTzxVTs6/5bnmnLzT+lkeJkovRS2HdbO6XA37JmFc2TihYBzTk19ONeR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770415866; c=relaxed/simple;
	bh=x37PprnNVBwCioe7QffXYQ4sngis1J0kaG3Fvwc8feI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQm1Hxi27W/DY92okncwObUirlOWVuEukT6+UZpguubB09zeLHESneRnGyD8iVE71qo3MBoqkegMZQb6rfsISsP7InMqoXaVTjUcGxfHIhg1IzPNMEzVLVRo8EMfFUmXcIiI0JNd9ubNYo0DoTLLHaaOnU5idSgfN8/QcHY62Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VWhXZbKo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5355040E0365;
	Fri,  6 Feb 2026 22:04:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wDh_YtPloIjt; Fri,  6 Feb 2026 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770415450; bh=jtswCjRH12CHCOy1L1MLMBTIpNJ34LaCX+gCIxQ7NsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWhXZbKoAsYlC1rTnaB5YjnbxDQNcAxIRfyEIC6JfMTR8iiYrqrG/f6aq+QXh4vOD
	 u4SftHhnowucS+GBim3i6QbjDzeLKd3YQZWWWZF03nWvqylunkQHbkV58yM98s+lVN
	 C/bljzSYThAtao7arPI6VSOpVnSW8wVUO0ZR3zw68pg5VeZP8bfmXjFmJYBSqQbasT
	 PJZ6fqz2wv8q07ZcZdesVvrqwAoDvIRa10H/jiValyaoWQloYZzg72OYm928WzZuNA
	 Fgq56gmzCBj7yDvReGk3rAyVEZnWslM+jId5nrhmMgic9DzmSdn66u20C5RhCbhu8i
	 fFVvMRl+eU+MxTEcchvyqyugJ8TcuToErhBCN60pLPghfUmh5a5rThFgLyCBC9fk67
	 MU/cXHAUEHS0j/8h9s0YWTzW6X7nimoP1MEe81wCwAZk24NuBHFKyX1p8Hgh6sRaLe
	 4N38pdvbpa3gwics2URzPx8YMreA0NlwsXot0hQP9R3VGJQTmuwkFNxvR9072Jm6eQ
	 MNIyE+fQ/LtOF8fshzXdG9Lrzd8NUQ440urwGw/BYrv1bZKkKLNnQf1HGhPISAp0HM
	 sbEn6sLIl1HmRPdtFvY0TJekhck8Ureuuo3IVT2B/62CZORVepbjPNJh4piMMKemF6
	 1DYsKHL8JVHQYOdZ+7GrR43c=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9E19540E019D;
	Fri,  6 Feb 2026 22:03:57 +0000 (UTC)
Date: Fri, 6 Feb 2026 23:03:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
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
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENIXSB4ODYvbWNl?= =?utf-8?Q?=3A?= Fix timer interval
 adjustment after logging a MCE event
Message-ID: <20260206220350.GBaYZlRvmgESS6JgkR@fat_crate.local>
References: <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
 <20260114144813.GCaWesrQ7zdEftdV87@fat_crate.local>
 <20260202151828.GAaYDARDsP21UVEPTb@fat_crate.local>
 <8c967791348a4f4d815c7612a15eee15@baidu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c967791348a4f4d815c7612a15eee15@baidu.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5695-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fat_crate.local:mid]
X-Rspamd-Queue-Id: 35D80103ABA
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:49:40PM +0000, Li,Rongqing wrote:
> Is it possible where CPU0 sets mce_need_notify, but CPU1 concurrently calls
> mce_notify_irq in mce_timer_fn, and then CPU1 sets its own timer to 1/2
> instead of CPU0's

I don't see why not.

But this is no different than what it was before AFAICT.

And if the timer expiry interval on the wrong CPU gets halved, then it'll see
faster that there's no error for it to log and it'll enlarge the interval
again.

So I don't see a problem with that particular scenario.

Or?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

