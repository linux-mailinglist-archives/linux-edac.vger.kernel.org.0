Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0040718C138
	for <lists+linux-edac@lfdr.de>; Thu, 19 Mar 2020 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCSUVc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Mar 2020 16:21:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCSUVc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Mar 2020 16:21:32 -0400
Received: from zn.tnic (p200300EC2F0A85001D12B79F4268FE9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:8500:1d12:b79f:4268:fe9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 811EF1EC0C89;
        Thu, 19 Mar 2020 21:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584649290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0TrVP6v0mx9Ldzd8eXkpG1x+4q0UQeHjrM0tcjHV5sw=;
        b=fR+rDbvjKU4/8dMPuoyYQ6STkE9bKkJK9mr31NIY/kTxUJsHb0kbXl514qTXxMAd2sepvB
        Vm63IYXw3hBOnXVzhaG2Izvds6Lrw5LEB73VSgMqiHGjw2UClHO6f5yEV+HrO3BYaNt6ar
        8hU1qEHbeirzpwQ7OFRJ/4EYTP+g/PE=
Date:   Thu, 19 Mar 2020 21:21:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Huang <whuang2@amd.com>
Cc:     Wei Huang <wei.huang2@amd.com>, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, yazen.ghannam@amd.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, linux-edac@vger.kernel.org,
        x86@kernel.org, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Message-ID: <20200319202134.GG13073@zn.tnic>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
 <20200316180829.GP26126@zn.tnic>
 <53d25b8c-dabe-1b91-4d3b-0a223075e42a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53d25b8c-dabe-1b91-4d3b-0a223075e42a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 19, 2020 at 03:14:53PM -0500, Wei Huang wrote:
> My proposal is to move mce_amd_ppin_init() function to
> ./arch/x86/kernel/cpu/amd.c and probe X86_FEATURE_AMD_PPIN there. This
> is similar to what early_detect_mem_encrypt() does. Later, mce_setup()
> can use X86_FEATURE_AMD_PPIN directly. Is this approach acceptable?

You can add it to arch/x86/kernel/cpu/mce/amd.c just like
intel_ppin_init() is respectively in .../mce/intel.c, as mce/ is where
this thing is used only. We can move it to kernel/cpu/ later if it turns
out that it is needed for something else.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
