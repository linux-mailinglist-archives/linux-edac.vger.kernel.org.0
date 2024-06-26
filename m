Return-Path: <linux-edac+bounces-1387-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B58918DF8
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D89287EA6
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CD190468;
	Wed, 26 Jun 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ErRUyrBJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF218F2F9;
	Wed, 26 Jun 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425447; cv=none; b=ZZG3apB/H8hGxk0Wh/XHgROSHInhd742qV1uwu/FTB28AQAk0naALNFm4csodQvyFlPlHhvdDHEXAhOC91IvvckwQMVvK5IlcaUUnunJAMm+sL6BBXIPAos8mldUqAG0kaTbD6qCIA9rFS+jcYukumpuk81g3iqdy/kV7tWWApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425447; c=relaxed/simple;
	bh=YALTyq5NTqRVjCQeYjTVKxmpg9hlxoK2X+LrWJFL36g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7+Pxh33dag3fSEKaw47InWJdArZqR+8/hINfE7J1nliAwr87dj845IWLBOszU8akAu+QvR1Z3vuyZXXnIVGJoWa3QxmMMJmUCdyilkox68cIMjfn17HvMJO+qwvWcf02mQeAbKKMo/HmcrH8/u6IVkyZnkpZ3VuAe9OiN1RGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ErRUyrBJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D48140E01D6;
	Wed, 26 Jun 2024 18:10:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XcLNdntgAjf9; Wed, 26 Jun 2024 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719425440; bh=9uNFM7yG+iY7u7mLqX7ahhmgTVXSR6qE9/wtkFv1BAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErRUyrBJzN0QIw+Rj0q7qg+WQJBaZ0rCyqkWJGb88JgZ20bUeiF4hUT7E7Uf9cfeB
	 FTnPlGHqQo02t/ITW5deMZg09vBNYiUZShj9UzWh1Fy7vavq6W5YZS6CEADhGJTslc
	 LvuDBJuRx8gQ4xIee9Nh1cYQ0R9yt7HgjQ+Y0QxqPQMNfX5riDB9G+jdKX1fLe87Ta
	 5f6pJRdGTmvkh/w7gu6mlGf+5WRpE0fQxqh074XB9cdVAnB7fjbp7ZYbdTxQXnHqvh
	 1r1BDei+xYHrWsgDfgR8NYwgDs5qdLQr1v4dqIz4rUWGbkOuNWfZaD5pXjA+DRk76x
	 fb8Yv+sW5Wgn1ypksE7/EZcd4kxaBzicuEHAtTBv/dR2+jB5Hs6A1mO9SBXUxnC3c0
	 tVQmVxvM04Geta1521Ke9r0CQeyK5CEjD0uD0wgD+7u8FuMGcpoivbB1uE651SZKRl
	 9EzlbPN0HRrnK46Lf2ZPKgxRM29o63YH8NGt8ICQPD5gQ9rSblZnJfI7YBIt5Wt6an
	 EZ3XCE94jmxm/2klJMdpZ1TwdHtXk+NcyOft9lroyThwvFVPB4bm8Eae6N5vjrt/Nt
	 UOLPt/LMvwOAvmH21Fn1ysQzTg+smUtKbLvqSTKB3lgykNqOSbAvVB3cKp+xcb1VKC
	 q9ngUWKSoWvi94fJAXoJnlds=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBA9240E0185;
	Wed, 26 Jun 2024 18:10:20 +0000 (UTC)
Date: Wed, 26 Jun 2024 20:10:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>,
	"avadnaik@amd.com" <avadnaik@amd.com>
Subject: Re: [PATCH v2 1/4] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Message-ID: <20240626181015.GCZnxZh2LF2N1ehu9e@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-2-avadhut.naik@amd.com>
 <20240626104427.GNZnvxC1JHclKwwKQU@fat_crate.local>
 <SJ1PR11MB608351F8BF89ECCAF08831A6FCD62@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608351F8BF89ECCAF08831A6FCD62@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Wed, Jun 26, 2024 at 05:11:29PM +0000, Luck, Tony wrote:
> > Tony, any comments? You ok with this, would that fit any Intel-specific vendor
> > fields too or do you need some additional Intel-specific changes?
> 
> It looks easy enough to add any Intel specific bits to the union later.
> 
> Is there anyway that the trace event could be "smarter" about what vendor specific
> information to include based on boot_cpu_data.x86_vendor? As currently written
> Intel systems are going to see 3*u64 decoded into ascii, that are all zero. Not a
> huge deal, I think it will just look like "0x0,0x0,0x0"

Hmm, good question.

Yo, Steve, is there a way to do conditional things in a TP?

For example:

@@ -83,7 +87,8 @@ TRACE_EVENT(mce_record,
                __entry->walltime,
                __entry->socketid,
                __entry->apicid,
-               __entry->microcode)
+               __entry->microcode,

	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))

i.e., print that array only when on a AMD.

I'm sure this won't fly as it is macro magic - this is just to show the
intent...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

