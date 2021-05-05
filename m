Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C5373382
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 03:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhEEBSB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 May 2021 21:18:01 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59385 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230328AbhEEBSB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 May 2021 21:18:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BEABC1894;
        Tue,  4 May 2021 21:17:04 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 04 May 2021 21:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=O5REtwqvgt8KsIaYaZnDGcg20cB2UjM
        nPfZ6Ty5OO+0=; b=TpqN/m6HLdmUdxpIzKonFN6eq/4P59qcgXTzO5BsfOqIq+E
        kwpNe+ueTJPA7n//4beb46D/IZ+CFGF1VegZpYCl3+Y61DlzDbr8m0SqQwisTnd9
        EhSSH5LIfJqF8F12/DmsL5YwFzFg6NbKBE3mh1r2Qu8RP9SwJlaue9l/LWsZG0kZ
        pNhPbofTIv+8PXWTxibhV9JjMavJi+hw1ZplrqaBYNsxZ0DzhxpIC/Hv8Ar1qrDe
        depPqNM+r6q7aZC0YMfAvCoVdz0JKKRH04u3nqkoj+CuiZbP2UmcuGIE0Rfufthi
        5+UvHtcqBSn7iSm9mxt6Z3UrpK+hPqMEdDlgKJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=O5REtw
        qvgt8KsIaYaZnDGcg20cB2UjMnPfZ6Ty5OO+0=; b=I/CKbZypZ55gje+EEqjuai
        xwRiD1jPAsI6MdbLl8UduJyldQiBEjPJwEEw3fV9pGwtrTcJl//7lWaBuoBvNglJ
        T+EAhyRFV73lchsBtLppQYZ234ovcbzWUP+qGllMrMP0Y0UmdcP4obi8k9TyuCUE
        J3wfWqGoBpGqhVMDD3+sUY7hdvl9GFIkcQT0I8XRR2mFzVG4Z1w4ews4MStHbqSs
        HttsPr9AVSzmElF6J3AjpMnGT9bxSR8CNZYq6SEYDDCuQPNvv4bC9zMFRBDAAHP/
        KPnxGHHxjXZMMzl7tphs/R373FTGzmIH5TN1gMy4q75Jbmxs3fwhTfSxXQAePU6A
        ==
X-ME-Sender: <xms:D_KRYCXXfKi6EEIA6F6mTTItmmuUfyQYFVUa0-lnZyuaYsL1dQWUag>
    <xme:D_KRYOn0hJpPxc_fNQWD74nV8M74Oqgo9k3IKOPCf18vk8tC2KKMGYzRZFrbg_Z4U
    lva2t2uO1j4GDpzWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepvefgvdevfeelfeejgeegfeevjeejhfdvtdeffeejgeetueelgfekudek
    teeiteejnecuffhomhgrihhnpehrshhtrdgttgdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruh
X-ME-Proxy: <xmx:D_KRYGb10Qq0pwI5X9Bj54iRIFzPF8aqrLLvL60e5TIvLfrycXFcfQ>
    <xmx:D_KRYJWMyjA1busrACJs4fpO-Grvh1DBCVWzkZ2OQ3enHnhynIQvcg>
    <xmx:D_KRYMl9K8w3ILRrpdcQKjZ2dRYYIdCgka_yK283RwcpvEsI-7u1aQ>
    <xmx:EPKRYG4DIQ3iMwpZXjR0fGrDVAeEo3fshbSXaXnTw3mNjFGGbnsAIJ0IsHQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2BF85A00079; Tue,  4 May 2021 21:17:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-442-g5daca166b9-fm-20210428.001-g5daca166
Mime-Version: 1.0
Message-Id: <f3427072-4dc4-47c8-a681-4f37e3c440e2@www.fastmail.com>
In-Reply-To: <892dfd15-a8f7-9db9-86bb-9630e88e0e3c@infradead.org>
References: <20210503163409.31944-1-rdunlap@infradead.org>
 <e899781c-304c-4494-a544-e3950e928e55@www.fastmail.com>
 <892dfd15-a8f7-9db9-86bb-9630e88e0e3c@infradead.org>
Date:   Wed, 05 May 2021 10:46:41 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "kbuild test robot" <lkp@intel.com>, linux-aspeed@lists.ozlabs.org,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>,
        "Borislav Petkov" <bp@suse.de>, linux-edac@vger.kernel.org,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH] EDAC: aspeed: print resource_size_t using %pa
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Tue, 4 May 2021, at 14:37, Randy Dunlap wrote:
> On 5/3/21 9:57 PM, Andrew Jeffery wrote:
> > 
> > 
> > On Tue, 4 May 2021, at 02:04, Randy Dunlap wrote:
> >> Fix build warnings for using "%x" to print resource_size_t in 2 places.
> >> resource_size_t can be either of u32 or u64. We have a special format
> >> "%pa" for printing a resource_size_t, which is the same as a phys_addr_t.
> >> See Documentation/core-api/printk-formats.rst.
> >>
> >>   CC      drivers/edac/aspeed_edac.o
> >> ../drivers/edac/aspeed_edac.c: In function 'init_csrows':
> >> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
> >> argument of type 'unsigned int', but argument 4 has type 
> >> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
> >>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
> >> argument of type 'unsigned int', but argument 5 has type 
> >> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
> >>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >>
> >> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Cc: Troy Lee <troy_lee@aspeedtech.com>
> >> Cc: Stefan Schaeckeler <sschaeck@cisco.com>
> >> Cc: linux-edac@vger.kernel.org
> >> Cc: Borislav Petkov <bp@alien8.de>
> >> Cc: Borislav Petkov <bp@suse.de>
> >> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> >> Cc: Tony Luck <tony.luck@intel.com>
> >> Cc: linux-aspeed@lists.ozlabs.org
> >> ---
> >> Found in linux-next but applies to mainline.
> > 
> >>
> >>  drivers/edac/aspeed_edac.c |    8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> --- linux-next-20210503.orig/drivers/edac/aspeed_edac.c
> >> +++ linux-next-20210503/drivers/edac/aspeed_edac.c
> >> @@ -234,6 +234,7 @@ static int init_csrows(struct mem_ctl_in
> >>  	u32 nr_pages, dram_type;
> >>  	struct dimm_info *dimm;
> >>  	struct device_node *np;
> >> +	resource_size_t rsize;
> >>  	struct resource r;
> >>  	u32 reg04;
> >>  	int rc;
> >> @@ -254,11 +255,12 @@ static int init_csrows(struct mem_ctl_in
> >>  		return rc;
> >>  	}
> >>  
> >> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> >> -		r.start, resource_size(&r), PAGE_SHIFT);
> >> +	rsize = resource_size(&r);
> >> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> >> r.start=0x%pa, resource_size=0x%pa, PAGE_SHIFT macro=0x%x\n",
> >> +		&r.start, &rsize, PAGE_SHIFT);
> > 
> > Arnd posted a fix a few days back that feels more intuitive, though 
> > probably could have cleaned up the grammar:
> > 
> > https://lore.kernel.org/lkml/20210421135500.3518661-1-arnd@kernel.org/
> 
> Oh, that's fine. I just missed it. :(

No worries, I was a bit short there as I was in a rush. I certainly 
don't expect you to go looking for Arnd's patch without knowing it 
exists :)

Andrew
