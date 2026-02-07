Return-Path: <linux-edac+bounces-5696-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFZ8Im8nh2m5UQQAu9opvQ
	(envelope-from <linux-edac+bounces-5696-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Feb 2026 12:52:15 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4C105C9A
	for <lists+linux-edac@lfdr.de>; Sat, 07 Feb 2026 12:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D094E301AF5E
	for <lists+linux-edac@lfdr.de>; Sat,  7 Feb 2026 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72F30E820;
	Sat,  7 Feb 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z2ZLmaMB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15435FDA7;
	Sat,  7 Feb 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770465131; cv=none; b=EwOdu8FfHR7iNQowwy4WvWgA+pURd4tAGufkMHyUIAF8FT8OedKDcuEdY3NqGF7InS9yUlPrOtA4+UlghlxVQt95cYWnM7eHL3OTpvmFpr+yNaofpKmc9MhjKXc0pUjtbwFTzE1Z3vyRb0gs6rmXoGSUCwGbGloaAABoavYhGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770465131; c=relaxed/simple;
	bh=Ow0KiPB4Jd/TZ9PegxGSjRfsjPMn6ysSJBCANHwdahI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm3aD+3EqH45RXASECYDRF0XJhFiNrrbBos3rCcKLY31kgX1pzniPIwIDV3VMclcTGmmXURDITKiP6KKSss/dHtwzDJApULJhAfW/Eb/kdOdtyuvuEg4FnR7MrILlI/X2ug/gBADCt8bNvFs6U1T+IKhH418BojScWO/tRr40u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z2ZLmaMB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F1C6040E0364;
	Sat,  7 Feb 2026 11:52:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZIUSpoeFB-5K; Sat,  7 Feb 2026 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770465123; bh=r7uWgv5kXNXeakbCt5lnqdYRrOwMMNNoNOgoAWAed6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2ZLmaMBqxKRtjPWgbXJFX62ObV0SFJiD+XHAwJQnSCCluiaPvb7MSbLNBMxTHhno
	 DXfDJ3vpTFNbzkdByFzTBa4on4TBc6uyFjik4EBhYsK50QvwaYIPwbQBK7ZDUrpaAF
	 /Hi754dpxRxw+tDk2/M/TtiVKAy1vCBVTUVLE0akl6zEUlBNbtjUiH7GJgjcIbEug1
	 Q890Kbw49sZ6Wty8U7TnHf8CqYh7D+OkH39otEG4ahfOf/O2LenwW+q8VrfIY5k2wn
	 qSYKgWOZDl23WSkSX4mkwOntCapMyim+CMMwwuGGT7ZHZUbmAttWUrNbaepzuHs/Hl
	 hmrU8bVJjE0MlISTK/wHOvW7+2TdpZXo+QeC/F7/fUy5SnLXvbOXqutls+2ScRgeTS
	 1W9gPxQ8kLRETr+SBnRMFEECub3YRpOUaHNxlry/2xQKi37qrWETkWmg6iK1BoMU08
	 RHQttumFmAV2JAJmKRhxmgaR8wHOXwERLUZFoxIxhQz8bzzRTMnQjQ4b4j2vhgxsye
	 rdBA6iC2eW2/KI+il9mKbxvl13GjaPnCfHR+soU73/1UXSY8T+e2X1aJMiaN/AN7xU
	 jyaIp9gQXdbD/aduecOnuGxtJ5HJintf8WF4UQVM3BfCG98l02zoQfPRPb2N5dFVfX
	 FP9WL8e3KRT67H5tF3CQVGFQ=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1F9F340E0367;
	Sat,  7 Feb 2026 11:51:50 +0000 (UTC)
Date: Sat, 7 Feb 2026 12:51:42 +0100
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
Message-ID: <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local>
References: <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5696-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: E3A4C105C9A
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 02:50:34PM +0100, Borislav Petkov wrote:
> On Tue, Jan 13, 2026 at 04:30:08PM -0800, Luck, Tony wrote:
> > Seems to work (though you've deleted all the places where mce_need_notify
> > is used, so you can also delete the declaration.
> 
> Right.
> 
> > I see time delta between logs reducing while I'm injecting errors.
> > 
> > When I pause injection for several minutes, and then restart I see the
> > interval went back up again.
> 
> Thanks Tony, I'll play with this too and ponder over what would be the proper
> fix which to take to stable too.

Hmm, so looking at this more while it is all peaceful and I can actually hear
the thoughts in my head... :-)

The whole dance here on the MCE logging path:

mce_log -> ... mce_irq_work -> ... mce_work -> mce_gen_pool_process

can happen in between two mce_timer_fn() function firings - just think of
the default timer running once every 5 mins.

So in-between those runs with 5 min timeout, errors can get logged and when
mce_notify_irq() runs, it won't see either that the genpool is not empty
- it will be empty - and mce_need_notify will be 0 too because we would've
set and cleared it. 

So basically, the timer fires, we log errors without it noticing anything, and
it won't halve.

The only way it would halve is if it manages to notice an error being
in-flight to being logged and it fires right then and there. Then its interval
would get halved.

And this sounds kinda weird and not what we want perhaps.

So fixing that would mean, we'd have to write down the fact that in-between
two timer invocations, we have logged errors. Maybe a per-CPU counter
somewhere which says "this CPU logged so many errors after the timer ran the
last time".

The timer would fire, check that counter for != 0, and if so, decrease
interval and clear it.

And it doesn't even have to be a counter - it suffices to be a single bit
which gets set.

A scheme like that would solve this accurately I'd say.

But the real question actually is, do we really care?

I mean, this thing went unnoticed for so long and frankly, people should run
the CEC anyway which has a better MCE-has-been-logged stifling capability so
that I wanna say, let's do the simplest thing and be done with it.

Or?

Do we care about some real use case here...?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

