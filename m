Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE10B43DD32
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhJ1I4B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 04:56:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhJ1I4B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 04:56:01 -0400
Received: from zn.tnic (p200300ec2f13a70055babd09551bec66.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a700:55ba:bd09:551b:ec66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30ED21EC064E;
        Thu, 28 Oct 2021 10:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635411213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DvOoyo1XKHGob7k4rSognbYB+jQykBxHt0HYpc/zPoA=;
        b=BnJCKIF8hrw+iAYzJ+fAEZncz37ov25IOg48XjNMdoJbPaAv39XJ7dUfwOiUU+/Swxx5Z7
        6IHfedl0l9M2kwjHOXD1LEjAXa67u818TdjcyT5QlK1FhHDbRf2Hv3rr/v8dhqi6Ttgupu
        2QgNXkpaTgvriXD06njphmzyp4qqKa8=
Date:   Thu, 28 Oct 2021 10:53:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 3/5] x86/mce: Use mca_msr_reg() in prepare_msrs()
Message-ID: <YXplCF5ccfbl+dGg@zn.tnic>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-4-Smita.KoralahalliChannabasappa@amd.com>
 <YXk6z9xWvS4B7eRP@zn.tnic>
 <f5287d1d-bb2b-bb9b-1b33-f6692eaeb566@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5287d1d-bb2b-bb9b-1b33-f6692eaeb566@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 27, 2021 at 03:19:51PM -0500, Koralahalli Channabasappa, Smita wrote:
> Multiple initialization here I mean: Initializing the MCA registers twice.
> Prior to mca_msr_reg() replacement, the MCA registers were initialized
> separately for SMCA and legacy processors. However, this is not required
> after replacing with mca_msr_reg() as it does the job of returning the
> proper MSR addresses.

You mean, there was a simple if-else statement

	if (SMCA)

		prepare MSRs

	else

		prepare MSRs for !SMCA

which did the init for each type of system in one go.

But frankly, your change doesn't make it more readable but less - you
have a goto label now and another SMCA feature check at the end. Vs a
simple if-else which is trivial to read.

So I don't see any advantage in this change.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
