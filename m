Return-Path: <linux-edac+bounces-1487-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E719A92CE56
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B731C2282D
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEA17BB31;
	Wed, 10 Jul 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pj4UUZzD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2F17FD;
	Wed, 10 Jul 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604337; cv=none; b=Gm7aa93Q8Mc4hVFIKIP1IehzyBziEUu/NBPcnMoCy0gFE/8BWd3/nmCZSEpvKWPpMNQbtiQl71CZg9c2da+x583i+1RasKqD5db4SLwA55VykYiU0z8Z8xzC521l07lM7vYu7/zzOGCOI7EkFbraumvHLc5wuOctXW60QnjOyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604337; c=relaxed/simple;
	bh=BytwbyifiKESLkwzNohBtpgLDUZDoGmKbGcw/9M/2/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKci7hso2bjcQAAAEDwY4M/tPzOhCHnjl5Yze2gFgUmmoNDoo7mt2YGZ96fUG4EQWO3iis/tV5Nj+5mQhtdJNE8SV2eFni/n79luHxvdydnlKbHe1fUwIqqnS/bdZEuq0xxFkXL6g31qF06xjE+YuySLmJBgLxVt8mTYeZsw0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pj4UUZzD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D881940E019C;
	Wed, 10 Jul 2024 09:38:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZUC_3agCiurD; Wed, 10 Jul 2024 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720604327; bh=4tD55kRk58dzBkcPyPWKImU3k357bp6g9dUEFXRiH5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj4UUZzD3z8BN3ScRN0bDvLplYjALfVoYh3H4FoAWcjoklLMm/Ibbl0ZdPlS5IFFw
	 ouLNVb7H/H8KYCPtM63E4bN4qpeW4GYUqZNvoHE8AAkf0lSKN3UZMtIrq+f52ANGti
	 Set4pCeQu/dAf8OsKNbXUHRFC5t2uzkp6uxkRf7kq9wtgiKzVvTi4SzXsZGFHX61DF
	 XsOieiXltD7d8US6ccBWrW6JZptU3A/NkBpcRvt5EDAaSL5+YcspcPi2PnGZvrtwYx
	 rtrPsyW8TzJt1OVuiCyEgpoweOkTrF1pBohA+idpm1GZzuTb8KJGcbzCsjGEynvy0x
	 PY0wS3MjeESBrQCjAYhExEAQmYge/xqabxnaPgN1Qb1ehMBQRjc57hcLYNC03GFoBE
	 UCgXv13WkJYt96YwuTARB3bDoklfU8tNocMlPdeGw4qklW0EWaYnhlxTrojbu2KTGL
	 XxlZ8Sc7cbo1b7QdX9W5Haj+/SBXQnhZl2xgn1ld9x2NZUzVKVtOLJytZ3djQ2lUzr
	 c1aY0ZLuxAlok9Tr88YqCnNkbKAe1w+91nM2BDvEDWX0IV7mT6cuawx+qQ11mmPNZW
	 YB9LGO9XkK+33kWbuYR82elmqT6ruXSg1JkDFjIhFIyXRn7aXdNIrGWFJvxtuQKb4i
	 7u+qClYOlf/gq9G3Fb8iGQRg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52FB640E019D;
	Wed, 10 Jul 2024 09:38:29 +0000 (UTC)
Date: Wed, 10 Jul 2024 11:38:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <20240710093828.GDZo5WlPrXLg-SbBHd@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-3-avadhut.naik@amd.com>
 <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
 <6c318161-9ae4-4965-b8f3-e38bf1393628@amd.com>
 <20240626181805.GDZnxbXRJlCecNeDGW@fat_crate.local>
 <17bba31a-9bb0-40e5-be7e-96ac6d421066@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17bba31a-9bb0-40e5-be7e-96ac6d421066@amd.com>

On Tue, Jul 09, 2024 at 01:27:25AM -0500, Naik, Avadhut wrote:
> IIUC, its an abbreviation of a Latin word and is used as a synonym for "namely"
> or "that is to say".
> Might not be the best choice in this case. Will change it.

I learn new stuff every day:

https://en.wikipedia.org/wiki/Viz.

> Userspace error decoding tools like the rasdaemon gather related hardware error
> information through the tracepoints. As such, its important to have these two
> registers in the tracepoint so that the tools like rasdaemon can parse them
> and output the supplemental error information like FRU Text contained in them.

Put *that* in the commit message - do not explain what the patch does.

> Got it. The first SoB entry is of the primary author. The successive SoB's are
> from the people handling and transporting the patch.

Exactly!

> IOW, the route taken by a patch, as its propagated, to maintainers and eventually
> to Linus, should be evident from the SoB chain.

You got it.

> With this set, the first two elements of the vendor data dynamic array are SYND 1/2
> registers while the third element is MCA_CONFIG (added through patch 4 of the set).
> Now, in rasdaemon, SYND1/2 register contents (i.e. first two fields) are interpreted
> as FRU Text only if BIT(9) of MCA_CONFIG (third field) is set.
> 
> Thus, we depend on array's layout for accurate FRU Text decoding in the rasdaemon.

So it sounds to me like we want to document and thus freeze the
vendor-specific blob layout because tools are going to be using and parsing
it. And this will spare us the kernel version checks.

And new additions to that AMD-specific blob will come at the end and will
have to be documented too.

That sounds like an ok compromise to me...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

