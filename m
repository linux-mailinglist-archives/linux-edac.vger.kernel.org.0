Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C14D2193
	for <lists+linux-edac@lfdr.de>; Tue,  8 Mar 2022 20:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349531AbiCHTeH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Mar 2022 14:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349436AbiCHTeH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Mar 2022 14:34:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435553B4F;
        Tue,  8 Mar 2022 11:33:09 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-253-133.2.247.pool.telefonica.de [2.247.253.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F22091EC064E;
        Tue,  8 Mar 2022 20:33:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646767984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OYNiKYESHbJzHK2pSiTjx95k/lbxvnxmuLbmGVL/AhY=;
        b=i5zRFdrpK8KYCCl8uZHUc22dp9WKizOpoyWUJ4RJliF3+o+PPYjT+OBbElgNpC/jB2oEW+
        cFaB+4Z4oSt5TSdxPJNUi5+Qrz+HXaBnD7qjfjYKgVcGgw5QPVMBbd0G0z6uPNBLWCx3uH
        /YFY29m4pUSU7HRMhFYMxje1kcbyhlA=
Date:   Tue, 8 Mar 2022 20:32:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH] x86/mce: Unify vendors grading logic and provide AMD
 machine error checks
Message-ID: <YievKnn5hSK0AvMt@nazgul.tnic>
References: <20220308184133.712761-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308184133.712761-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 08, 2022 at 12:41:34PM -0600, Carlos Bilbao wrote:
> AMD's severity grading covers very few machine errors. In the graded cases
> there are no user-readable messages, complicating debugging of critical
> hardware errors. Furthermore, with the current implementation AMD MCEs have
> no support for the severities-coverage file. Adding new severities for AMD
> with the current logic would be too convoluted.
> 
> Fix the above issues including AMD severities to the severity table, in
> combination with Intel MCEs. Unify the severity grading logic of both
> vendors. Label the vendor-specific cases (e.g. cases with different
> registers) where checks cannot be implicit with the available features.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  arch/x86/include/asm/mce.h         |   7 ++
>  arch/x86/kernel/cpu/mce/severity.c | 188 +++++++++++++++--------------
>  2 files changed, 103 insertions(+), 92 deletions(-)

Sorry, maybe you're too new to this and you probably haven't read the
old discussions we have had about the severity grading turd. In order to
save you some time: adding more to that macro insanity is not going to
happen.

The AMD severity grading functions are *actually* readable vs this
abomination which I hate with passion.

If you want to add more logic, you should add to mce_severity_amd(),
perhaps call other helper functions which grade based on a certain
aspect of the error type, split the logic, use comments, etc, but
*definitely* not this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
