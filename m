Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06B4F0C3A
	for <lists+linux-edac@lfdr.de>; Sun,  3 Apr 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiDCSwU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Apr 2022 14:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiDCSwU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Apr 2022 14:52:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A809252AB;
        Sun,  3 Apr 2022 11:50:26 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B213A1EC0373;
        Sun,  3 Apr 2022 20:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649011820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ySPVMZL66xidGf9xEx8etnzVB4GPdT4QPUvI0ZJBTRo=;
        b=F1MvmbAhxjC/zp+x+NU++bNjI72+UjjMuf14N6s5eVsuWdjtZDzVY8dkUg8TupEsbsRx07
        JiMi2bEwHxN2EHJZ1Bj0YVD64msMctJzss9dJun3bI7/9bl6c24NPdrYGmSe/Ss/bpdXI4
        eLG/V13p3aYodOlu3YiIeQ5B6VtDVEo=
Date:   Sun, 3 Apr 2022 20:50:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr
 from MCA_ADDR
Message-ID: <Yknsbp+zMh8Uev8+@zn.tnic>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
 <YkWrlTIK/ZxsQekX@zn.tnic>
 <YkmeJFXXbu3aLzzw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkmeJFXXbu3aLzzw@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 03, 2022 at 03:16:20PM +0200, Borislav Petkov wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 9ccc2ea0ea00..4acc7959be6e 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -723,7 +723,7 @@ bool amd_mce_is_memory_error(struct mce *m)
>  }
>  
>  /* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
> -void smca_extract_err_addr(struct mce *m)
> +void __always_inline smca_extract_err_addr(struct mce *m)

Ok, flip those - the pedantic bot is not happy:

>> arch/x86/kernel/cpu/mce/amd.c:726:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     726 | void __always_inline smca_extract_err_addr(struct mce *m)
         | ^~~~

Needs to be

__always_inline void

whateva...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
