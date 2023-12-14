Return-Path: <linux-edac+bounces-251-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF081371B
	for <lists+linux-edac@lfdr.de>; Thu, 14 Dec 2023 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9EC1F216A4
	for <lists+linux-edac@lfdr.de>; Thu, 14 Dec 2023 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B861FD8;
	Thu, 14 Dec 2023 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dFbgypeJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEFAB7;
	Thu, 14 Dec 2023 08:59:04 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4511140E014B;
	Thu, 14 Dec 2023 16:59:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XaqjZfZWziAL; Thu, 14 Dec 2023 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702573139; bh=CRyA3kt/MINT0pQrhYvKMWzWXjiH97CfyNBCklL4uuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFbgypeJeubtWY1fTt8gDNOF+r3uoa1KG/GZnxSe3a9Y723iEJogp94cSIrFGVeD8
	 Dggv0EUFpL/UkFDpT/t0sZrPS5Er00xWFGqnUZw67xh/dZHJv21s9L76po+FumIudf
	 I3/IApGn/+07anBqY09HVxLdyMltDh+uWjUgC5m4dfuTHo7mC3sfAI1x7+psYXPbns
	 K4HkXy3VeEPDq8PJrYwgKPBqaHDkePt9Yyf5aOOmnLqWzKRjYRaICVrGBmh0NK2eHP
	 dnlbBBLNtTuYpK+YId+8AQPDWNEVEN0s+/f1+oNYIyWSbureRQ1sJGftxduSII1efr
	 Slfk8Caw1/zwVr6BmpNcqm02/ZMg4+bBjKogxWqZSQlMS0f8zpv3qeqdoJjkWh4H8f
	 kt+vJNd7uDCLigefgz8X1rvP/yvL8VcQWAxPgGHMssgey0JsII7/YmX6fN41ruairK
	 futeoT+wWP7/ArNa3FizB5gl2Nx9EeE7qgDeQ73xMCMtzJrMFFJ2cvkVvdbH51CLLO
	 1FVVp/RKuqCjXT3NxoUJ4F5fvNJZhBeeMF+pFht9stUkSlwrM3ay3b0V1pIsMQK+XE
	 5+RWvVRT9IdfSmMVuND1Erged0kJF/RN+GXcWkmXNNUgaMvI1MiX1/5G/5gxsJZwuZ
	 g/S60tySQoi0NVWfBam5h82o=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6E9440E00CB;
	Thu, 14 Dec 2023 16:58:51 +0000 (UTC)
Date: Thu, 14 Dec 2023 17:58:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Smita.KoralahalliChannabasappa@amd.com, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20231214165846.GOZXs0RqkbpovdQWKH@fat_crate.local>
References: <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
 <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
 <ZWTzAujHdrJ950F3@agluck-desk3>
 <ZWT4pAJ6g0i78wec@agluck-desk3>
 <ZWU3WkmUMz3Wk9wT@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWU3WkmUMz3Wk9wT@agluck-desk3>

On Mon, Nov 27, 2023 at 04:42:02PM -0800, Tony Luck wrote:
> On Mon, Nov 27, 2023 at 12:14:28PM -0800, Tony Luck wrote:
> > On Mon, Nov 27, 2023 at 11:50:26AM -0800, Tony Luck wrote:
> > > On Tue, Nov 21, 2023 at 12:54:48PM +0100, Borislav Petkov wrote:
> > > > On Tue, Nov 14, 2023 at 02:04:46PM -0800, Tony Luck wrote:
> > > But it isn't doing the same thing.  The timer calls:
> > > 
> > > 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> > > 
> > > and cmci_mc_poll_banks() calls:
> > > 
> > > 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> 
>         machine_check_poll(0, this_cpu_ptr(&mce_banks_owned));

Hmm, so I applied your v10 and this call with mce_banks_owned is done in
cmci_recheck() only. Which is on some init path.

The thresholding interrupt calls it too.

The timer ends up calling mc_poll_banks_default() which does

	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

I presume we don't do:

        if (!cmci_supported(&banks)) {
                mc_poll_banks = cmci_mc_poll_banks;
                return;
        }

usually on Intel. And even if we did, cmci_mc_poll_banks() calls

	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

too.

So regardless what machine you have, you do call the mc_poll_banks
pointer which in both cases does

	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

The *thresholding* interrupt does

	machine_check_poll(0, this_cpu_ptr(&mce_banks_owned));

and you're saying

	mce_poll_banks and mce_banks_owned

are disjoint.

That's what you mean, right?

Because if so, yes, that makes sense. If the sets of MCA banks polled
and handled in the thresholding interrupt are disjoint, we should be ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

