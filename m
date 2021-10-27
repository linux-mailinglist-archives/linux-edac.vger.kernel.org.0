Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE543C8BA
	for <lists+linux-edac@lfdr.de>; Wed, 27 Oct 2021 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhJ0Lnd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Oct 2021 07:43:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhJ0Lnd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Oct 2021 07:43:33 -0400
Received: from zn.tnic (p200300ec2f161500de850afe3c1188c4.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:de85:afe:3c11:88c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB7671EC061D;
        Wed, 27 Oct 2021 13:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635334867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8AFb4PMAeHttwC3qS0esrlJfGzXNEM1Moimt2WNSlzU=;
        b=QyYiPlHM3SDI0E3QPXTszPfzfejgQnMuXfb1uv/NcQcTzDappkqng30GR78Djhb+HY9s5b
        sbmK9dbaJxXdAb6QAOSa7puPB04FkN8xoOG2XCARHtcLdYocFWc9JoS0IQD6Kf9y5ikaxv
        YdPFxjDBcULwBAD79AqjYyHzEiqrW44=
Date:   Wed, 27 Oct 2021 13:41:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 3/5] x86/mce: Use mca_msr_reg() in prepare_msrs()
Message-ID: <YXk6z9xWvS4B7eRP@zn.tnic>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-4-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019233641.140275-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 19, 2021 at 06:36:39PM -0500, Smita Koralahalli wrote:
> Replace MCx_{STATUS, ADDR, MISC} macros with mca_msr_reg().

And this is where your commit message and patch should end. It is a bad
idea to do textual replacements *and* functional changes in a single
patch: it is hard to review and debug if there are possible issues. So
you do the textual replacements in the first one and then the functional
changes in subsequent patches.

> Also, restructure the code to avoid multiple initializations for MCA
> registers.

What multiple initializations?

> SMCA machines define a different set of MSRs for MCA registers
> and mca_msr_reg() returns the proper MSR address for SMCA and legacy
> processors.
> 
> Initialize MCA_MISC and MCA_SYND registers at the end after initializing
> MCx_{STATUS, DESTAT} which is further explained in the next patch.

And this should be *in* the next patch.

Also, there's no concept of "next patch" when you do git log on the
upstream tree and use different sorting etc. So a patch should be
self-contained and do one change only.

There's very good documentation in Documentation/process/, expecially
Documentation/process/submitting-patches.rst, which explains how a patch
should look like.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
