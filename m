Return-Path: <linux-edac+bounces-1085-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3158CB39E
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9E3282D2B
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4514900A;
	Tue, 21 May 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hAvSbqWY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43B148FE6;
	Tue, 21 May 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316775; cv=none; b=oBHopOxoBLb1HKYIU6b76eM8DJharxW26kKiiHX4W0hS6cUwCZto3l0ybdSdVN0AF9HH1SMROaUVQoqVBuGYR0XxrGB1avYrzznKXn1pegLIeIBJv4PUik/Sekp+kvkYdCuvJ1rMfqPpqmbp3hfrUI9/SevnXENxXMx8+LiB8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316775; c=relaxed/simple;
	bh=2OwM9OXUCRq9x0pBAcwrcHhHRTWyszwBTrJVPIxQlXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgYBpWjswuYSB0ZtO4MydlMQXNx46aHmPhUmyNTjJEyVlLx9Gneiblr/COI+/T24sjB5BUIuKxCEo3/t1K8cJBYbJCgIe3qFr9CBN17JvKgHRigb9yM9azG/JgS5wWEsj1ZphIBKjAKFoNuMa0kr43GWAFkN+KGhpiIErnXFX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hAvSbqWY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3934F40E0254;
	Tue, 21 May 2024 18:39:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z7xw7aBKgNlL; Tue, 21 May 2024 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716316767; bh=vidwVOS9FKehluQc192AliUTp5o7jNiEJhT6qtLB4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAvSbqWYOa2w4hqZuivUSRdmM6Lz5CghzlWorfUZLDjG+ebkVjzga3j9/I8ubWgCI
	 3LCVuAwIGr9XC8YOpPjbV2mQZo0abeOiBpiORrxIBu9km14r8T/QaHTSmhoksxMnwN
	 4dSqtIF4onTym6QOqwLq+hdnULKVMRAtwLvpd0ak70U3EQ5hb+nef1zyaGQzEPHczH
	 +YpBQG2aV86n+fFGW7EORrxPMG/YwTvXTS6tNwZYWKj5k4j/ROLbIBd0mxC1gHYxUJ
	 ApEDENe0rD06lvU6k7zGTY6xkL9bBxp/vuC3Jgdf4ZVq51DPHRdxaeoY01aNdWnggH
	 eXIJqrhku3IBdiPGie1W1oXYFNc+vuA6hNECILICyKlChlIYekBGq8ugPytW7QUetb
	 jgkUSc6l4i9mrufS7Yx3VxvYTwYGPgiCJ5HXeXLsDek6/4JsI4T0E9VOLrBGl+K5nT
	 o1K/XZexD84KUoWkrmcRvjAMDwNuHsFKBqqj4Hrz7hY+1MvwUpck61jgCR8wp2+wNJ
	 V/I3ecUVxpMJQGGAjwxRv9CuuD/m9HBuElrRxKYr5cGMQxP7PQS+7NWYEAijSl/svZ
	 m3TUkygWnLGe1abtEzHvskUw3NjuTxP6aAsw7/VNJ7KVcYcIe6Ly6eIiHL1bbyNAEP
	 LoybpH5kBVac5UrCApsrR7uA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 898C440E023A;
	Tue, 21 May 2024 18:39:18 +0000 (UTC)
Date: Tue, 21 May 2024 20:39:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
 <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240516095714.GCZkXYeiKbUk2QXoIO@fat_crate.local>
 <664656cf7c59b_2c2629493@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <664656cf7c59b_2c2629493@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, May 16, 2024 at 11:56:15AM -0700, Dan Williams wrote:
> Something like a new annotation for tracepoints marking them as "emit to
> kernel log if no-one is watching this high-priority trace event"?

I'm not sure anymore what we want here now... :)

We want for the kernel to not pay attention to whether userspace is
consuming error info from the tracepoints and to issue errors into the
kernel log too.

So you have them in the kernel log *and* in the tracepoints.

Right?

Or only through the tracepoints?

> Well no, there is little to complain about in that path because that
> path does not play "is anybody watching" games. It always emits to the
> kernel log (subject to rate limiting) and then follows up with always
> emitting a tracepoint (subject to standard trace filtering).
> 
> For CXL I asked that its events deprecate the kernel log path with the
> hope of not growing new userspace dependencies on kernel log parsing for

Yeah, kernel log string format is not an ABI so no problem.

> newfangled CXL errors.

So shuffling hw error info solely through the tracepoints is probably ok
but I am unable to rule out *all* possible cases where it would still
make sense to dump to the kernel log, be it there's no userspace, be it
it is a critical error and you want to dump it immediately or whatnot.

It should probably be configurable.

As in: by default all hw error info goes only through tracepoints with
the exception of fatal errors - they go both to the kernel log and
tracepoints.

And then perhaps add "ras=dump_all_error_info_to_kernel_log_too" or so,
cmdline param.

> At least when the firmware gets out of the way Linux has a chance to
> solve user issues.

Yeap.

> Yes, tracepoints feel simple and generic to me while kernel log messages
> with rate-limiting is already a lossy proposition.

Right. Btw, do bear in mind that ratelimiting of hw errors can be bad
sometimes: imagine it ratelimits exactly that one fatal error which you
absolutely should've seen... :-\

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

