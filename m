Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1905A4F09D5
	for <lists+linux-edac@lfdr.de>; Sun,  3 Apr 2022 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358820AbiDCNSa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Apr 2022 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358945AbiDCNSX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Apr 2022 09:18:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EDE54;
        Sun,  3 Apr 2022 06:16:29 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D7DB91EC01B5;
        Sun,  3 Apr 2022 15:16:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648991783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=31OJMjqHClIj9JrX8Y21C+6EHoiVM7Hu/S7vtVGm6hA=;
        b=UuFnoL7FgLyFDuh3Aqtle2b9A9Um6/ORZ1ABQn+mDiLS4P8/+8g6hlaPVItuI8nwV2+Tgu
        M0yUwVFjQP4iK+hZtcOeRsbOG+V3sh8Pv1NSXQ5WHIZGU2Ha3L6UAL0jlKChuu4C7Ndx10
        7Ht9IvWC+snnauTjR6fgKyFsIlnfAZs=
Date:   Sun, 3 Apr 2022 15:16:20 +0200
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
Message-ID: <YkmeJFXXbu3aLzzw@zn.tnic>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
 <YkWrlTIK/ZxsQekX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkWrlTIK/ZxsQekX@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 31, 2022 at 03:24:37PM +0200, Borislav Petkov wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 1940d305db1c..a1a4a5dc53e8 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -722,6 +722,19 @@ bool amd_mce_is_memory_error(struct mce *m)
>  	return m->bank == 4 && xec == 0x8;
>  }
>  
> +/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
> +void smca_extract_err_addr(struct mce *m)

In addition:

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9ccc2ea0ea00..4acc7959be6e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -723,7 +723,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 }
 
 /* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
-void smca_extract_err_addr(struct mce *m)
+void __always_inline smca_extract_err_addr(struct mce *m)
 {
 	u8 lsb;
 

because some compilers cause:

vmlinux.o: warning: objtool: mce_read_aux()+0x82: call to smca_extract_err_addr() leaves .noinstr.text section

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
