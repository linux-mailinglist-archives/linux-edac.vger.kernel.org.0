Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B1382CA5
	for <lists+linux-edac@lfdr.de>; Mon, 17 May 2021 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhEQM62 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 May 2021 08:58:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhEQM62 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 May 2021 08:58:28 -0400
Received: from zn.tnic (p200300ec2f061b004a70cca8b839c355.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1b00:4a70:cca8:b839:c355])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCFDC1EC01B5;
        Mon, 17 May 2021 14:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621256230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4ZTxHuIXLkDq2ilVFphM2z7wrM4IP5A2RNR6g3B+MWI=;
        b=nMS3bRrXZ7K9CZaH3CdMjqOW+HMOYJhrn8/mTQ3xMrRiMvTfrwImGNKZbyiX9h5DDEc2gl
        i7vjYpp2S+C+sTJykl5wmbM6hRm62wthSHoh4foT5h4lh23fBZDDUzQT6DNqX9DW0fyHwf
        6eSwHfEDx/xhuLtNvzuX/WXAPv1DLF4=
Date:   Mon, 17 May 2021 14:57:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
Message-ID: <YKJoICQzD/o7ZPBp@zn.tnic>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 07, 2021 at 03:01:15PM -0400, Yazen Ghannam wrote:
> Patches 1-24 do the refactor without adding new system support. The goal
> is to break down the translation algorithm into smaller chunks. There
> are some simple wrapper functions defined. These will be filled in when
> supporting newer systems. The intention is that new system support can
> be added without any major refactor. I tried to make a patch for each
> logical change. There's a bit of churn so as to not break the build with
> each change. I think many of these patches can be squashed together, if
> desired. The top level function was split first, then the next level of
> functions, etc. in a somewhat breadth-first approach.

No, that's great what you did and keeping each logical change in a
single patch is a lot easier on everybody involved.

Now, looking at this - and I know we've talked about this before - but:

umc_normaddr_to_sysaddr() is used only in amd64_edac.c.
amd_df_indirect_read() is used only by this function, so how about
moving both to amd64_edac, where they're needed and then doing the
refactoring ontop?

You can simply reuse your current patches - just change the file they
patch from

arch/x86/kernel/cpu/mce/amd.c

to

drivers/edac/amd64_edac.c

I went through te umc_... function and AFAICT, it doesn't need any core
MCE facilities so it should be just fine in EDAC land.

Or?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
