Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85B960BE1A
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJXXDJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 19:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJXXCv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 19:02:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C985111F4B1;
        Mon, 24 Oct 2022 14:24:12 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF1771EC06A9;
        Mon, 24 Oct 2022 23:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666646616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bkJ7W+aoz3ULhI2QMRDy6xjUv7ji/f3Xhg5jY/XpoMQ=;
        b=deA5R2QvcYYl2pEzUFAyeAl91dUUJ5Q3KCLdDABKC+/cd67t4BvBgE7zVoeGZXOs7fsa/9
        4r/cxzecF+HanjCTki85sxq1nKkOzVc9SWvsxgNBymbQJGhrGj/qQFKbPej3VTpnZsmMjn
        /UGXwtDEhJOl+L9TRfE3/S9106/tZao=
Date:   Mon, 24 Oct 2022 23:23:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y1cCU9UqGG7nl8cy@zn.tnic>
References: <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah>
 <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
 <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 24, 2022 at 09:08:54PM +0000, Luck, Tony wrote:
> We already have:
> 
>         __u8  cpuvendor;        /* Kernel's X86_VENDOR enum */
> 
> So the mce structure contains which vendor created it.
> 
> > I guess a u8 vendor_info[VENDOR_INFO_SIZE] or so which we can extend
> > later if needed.
> 
> Extending is hard because we already boxed in the two AMD specific fields
> with some generic fields that follow (ppin & microcode).
> 
> But we could change the current form to be something like:
> 
> 	union {
> 		struct vendor_info {
> 			__u64	vendor_info[2];
> 		};
> 		struct vendor_amd_info {
> 			__u64 synd;             /* MCA_SYND MSR: only valid on SMCA systems */
> 			__u64 ipid;             /* MCA_IPID MSR: only valid on SMCA systems */
> 		};
> 	};
> 
> to make it clear that these 16 bytes are up for grabs to be re-interpreted based on
> the value of "cpuvendor" (and possibly also "cpuid" if a vendor wants different data
> logged for different models).

Yes, there's that. But this thread contains a patch which wants to add
two more fields.

So the above you're proposing we could do if you wanna reuse that info
on Intel.

But again, there's this other question how to add a *new* vendor_info
at the *end* of the structure which can be shared too *and* which could
potentially be enlarged.

And, if we do

	struct mce;
	vendor_info;
	<field shared by the two vendors>

then we're boxing in that vendor_info again and we cannot enlarge it
either.

That's why I'm proposing this prepended length in front of the
vendor_info field so that it can be extended properly in the future
and new shared members can also be added and this whole scheme can be
forward-compatible, so to speak, without having to cast anything in
stone.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
