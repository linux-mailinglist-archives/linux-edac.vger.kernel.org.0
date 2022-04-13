Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C0C4FF4A1
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiDMKYI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDMKYH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 06:24:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE65640C;
        Wed, 13 Apr 2022 03:21:46 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D58D1EC0541;
        Wed, 13 Apr 2022 12:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649845301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e4zRIp13Jc3sRegjwhYb9xA+8VgTbG+UMlHH7kMNN1M=;
        b=oktHMGLTHg4Yg6sQxewesiZGBvmLHPL5psbDmsJhv3ojbovoP3laRdJM7xMxoOYn5NxlBL
        ulpQWGpVZ7XNyFA3WrgcmSnlrJrQMDrSOjYH9+oX0f3Q7cO6TQgEC/7KEpbjxVJ3r3DOsj
        YVuTLc59VQGccgVwmtNZ4DYpaU1Ck+0=
Date:   Wed, 13 Apr 2022 12:21:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tony Luck <tony.luck@intel.com>, hpa@zytor.com,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlakNe012hhErszh@zn.tnic>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 12, 2022 at 10:40:38AM -0500, Smita Koralahalli wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index f809eacac523..4f2744324d9b 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -722,6 +722,17 @@ bool amd_mce_is_memory_error(struct mce *m)
>  	return m->bank == 4 && xec == 0x8;
>  }
>  
> +void smca_feature_init(void)
> +{
> +	unsigned int bank;
> +	u64 mca_cfg;
> +
> +	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
> +		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
> +		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
> +	}
> +}

We have smca_configure() for SMCA banks init and there it even reads
MCx_CONFIG.

Do you guys not see this?

Or integrating new stuff into the existing code doesn't really matter -
just bolt it on wherever it works?!

> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 64dbae6b8a09..0f4934fb3d93 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -177,6 +177,22 @@ struct mce_vendor_flags {
>  
>  extern struct mce_vendor_flags mce_flags;
>  
> +struct mce_bank {
> +	u64			ctl;			/* subevents to enable */
> +
> +	__u64 init			: 1,		/* initialise bank? */
> +
> +	/*
> +	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
> +	 * the LSB field is found in MCA_STATUS, when set.
> +	 */
> +	      lsb_in_status		: 1,
> +
> +	      __reserved_1		: 62;
> +};

Put those comments over the members, while at it:

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 0f4934fb3d93..770a31120fd2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -178,17 +178,18 @@ struct mce_vendor_flags {
 extern struct mce_vendor_flags mce_flags;
 
 struct mce_bank {
-       u64                     ctl;                    /* subevents to enable */
+       /* subevents to enable */
+       u64                     ctl;
 
-       __u64 init                      : 1,            /* initialise bank? */
+       /* initialise bank? */
+       __u64 init              : 1,
 
        /*
         * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
         * the LSB field is found in MCA_STATUS, when set.
         */
-             lsb_in_status             : 1,
-
-             __reserved_1              : 62;
+             lsb_in_status     : 1,
+             __reserved_1      : 62;
 };

> +DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
> +
>  enum mca_msr {
>  	MCA_CTL,
>  	MCA_STATUS,
> @@ -190,7 +206,9 @@ extern bool filter_mce(struct mce *m);
>  #ifdef CONFIG_X86_MCE_AMD
>  extern bool amd_filter_mce(struct mce *m);
>  
> -/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
> +/* If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
> + * [56:0], else in bits [55:0] of MCA_ADDR.
> + */

verify_comment_style: Warning: Multi-line comment needs to start text on the second line:
 [+/* If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits]

Documentation/process/maintainer-tip.rst, Section "Comment style".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
