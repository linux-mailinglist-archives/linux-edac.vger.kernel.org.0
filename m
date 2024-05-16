Return-Path: <linux-edac+bounces-1058-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E658C7438
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 11:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D20C1C236E5
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7CA143874;
	Thu, 16 May 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M6DainB4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650F14293;
	Thu, 16 May 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853457; cv=none; b=OwTB7oLWzMZLjYrD7tO1ru9kj0HtLmaxrYK0IG336fQb6m47HTofJv9i6O4Jd4832LzGJYxKO0n/v2JQL00ePdMz4YH9u2Xb66ldL5KdRxux6iFqxscv+n5rB4zIjVpFjqDYDn2DToPqGtN3hwu8OmlF6saJEmSrk1O5w1M4w38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853457; c=relaxed/simple;
	bh=ON1mL+QNRSBXFklaXMD/l37rxtKcsZUzmRwJ6kaQtQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSb/pB39MuwkZlVwtMWZzfHWlWkAkUqt6jbKjv7Oi5WhEKxJv2weY790gRbF2+nZb9ymNwDIvoOO4rFgO/dIQaYrrbUz+Y0WImRUHgJp5Jt8XrTwx33a2tRx+224MH1xXdy6tSYIzHpYccXtDjG2JOE802oSIt8BlcYEJsqFgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M6DainB4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 75E0140E016A;
	Thu, 16 May 2024 09:57:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZmEHKAOatmne; Thu, 16 May 2024 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715853448; bh=N3hlxw9aahtEYdoCrk85o0Biy95tVPWvjuIc5FNL0yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6DainB4kgiJKha/2O5yqsQuoS/WQ+LYWwyrfNjOrmrUd6Q/Q5OTdYYZLZ1x9xzwo
	 jX/noe5x4bmMoMVqW6tIf3mgJN4bSzQCc8ndMa5aZ7mWHyadpm7kkE5ZdAcsSa+r4d
	 c5kgNHXFv1mBvUtM+EChAlfaFmKSrZMepgxjXwEkGp0nvLlhnQAP1PK5zCz5H8IL3T
	 pMLmMYR66W4EjRkYAfO9DQ3iDN1oAJlWvCKOCOIKmzBSnUmB+j622zelmwXS46rw6E
	 nKtgGu2MAns8vVlb2BBaznrGUhFoifaGG1jqwhW9H8AglXu+qPNxsi8yLjrrdDwC47
	 mZdZXewYESFUya+JqMOi18XrhqxCXZtcAaxmbXqDR5u+z1q2/yTRsUhEt5YHceITcD
	 v3qQQbDL21nBG5p1IihnLv9jLPI+3a00au8fNIRNUFq4TEoTmAWE8M+p1NpXpBLWDa
	 b53fEUEP/eByEe2poR+xI/Q2AA87KuGxLybraHi4gwqVpslPlFrCkQkCgnvSkqeVbM
	 4/dfphteapH7VltP991E5s4wq4+RoM8oFqY5uyzvfwidQ8uAyUyrXKntwPd8IN8kOI
	 DrwQnyKYyaEGXnDnUuV6bHRJqxfPqs5bzC5cx2/eb7Xsx5izyC1t3uqDOMGW6qyIT9
	 J295MjR/fg9GS1fozIhHO45w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFF5440E0177;
	Thu, 16 May 2024 09:57:20 +0000 (UTC)
Date: Thu, 16 May 2024 11:57:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <20240516095714.GCZkXYeiKbUk2QXoIO@fat_crate.local>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
 <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Sun, May 12, 2024 at 04:45:08PM -0700, Dan Williams wrote:
> Yes, my point though was that if it got deleted I doubt anyone would
> notice. rasdaemon explicitly does not check the return from
> open("daemon_active").

The intent was for userspace to open it and thus it'll increment
trace_count which then ras_userspace_consumers() reads...

> I am also curious about the history here. This "daemon_active" scheme is
> an awkward way to detect that something is consuming the tracepoint. It
> was added on v4.0, but Steven had added "tracepoint_enabled()" back in
> v3.17:
> 
> 7c65bbc7dcfa tracing: Add trace_<tracepoint>_enabled() function

Ha, I usually talk to Rostedt for all things tracepoint when wondering
how we could use them for RAS purposes but I haven't this time, it
seems.

> So even if non-rasdaemon userspace was watching the extlog tracepoints
> they would not fire because ras_userspace_consumers() prevents it.
>
> I am finding it difficult to see why ras_userspace_consumers() needs to
> continue to be maintained.

Well, you still need some functionality which tests whether a userspace
daemon consumes RAS events. Whether it is something cludgy like now or
something which checks whether all RAS tracepoints have been enabled,
something's gotta be there.

> That would be odd since there is no ras_userspace_consumers() in the
> ACPI GHES path,

Probably because no one's using RAS daemon with GHES. I at least haven't
heard of anyone complaining about this yet...

> so it is already the case that you can get duplicate error information
> depending on which path triggers the error.
>
> Tracepoints are individually configurable.

Sure.

> From my perspective I want alignement between "firmware first" and "OS
> Native" events and I think any movement away from kernel log messages as
> a hardware error mechanism towards tracepoints is a good thing.

That has been the goal for a while now, yap.

Anyone who parses the kernel log for anything serious has been living
under a rock in the last decade at least. :)

> Recall that tracepoints can also be configured to emit to the kernel
> log, so that might be a way to keep legacy kernel log message parsing
> environments happy.

Ok.

> Would be great to hear from folks that have a reasons for kernel log
> message error reporting to continue.

Right, from my experience so far, you never hear anything. :-\

So if we do anything, it should be something simple and which works for
almost everyone.

With RAS, everyone does their own thing. And then there's the firmware
which claims that it can do better RAS but then f*cks up on basic things
like *actually* shipping a working EINJ or whatever implementation.

So in the end of the day it is, oh, we need our drivers in the OS
because we can't fix firmware. It is harder to fix it than *hardware*
:-P

> Uniformity of error response to "fatal" events, but that is mainly a
> PCIe error handling concern not  CPU errors.

Sure, just make sure to keep it simple and generic.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

