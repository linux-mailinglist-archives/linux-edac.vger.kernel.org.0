Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0060F674
	for <lists+linux-edac@lfdr.de>; Thu, 27 Oct 2022 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiJ0Lqe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Oct 2022 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiJ0Lqb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 27 Oct 2022 07:46:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F069A57BCF;
        Thu, 27 Oct 2022 04:46:29 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E8211EC05DD;
        Thu, 27 Oct 2022 13:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666871188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=70WD3mKzdGoHmhK5moaB/k6Uf9rZZRmGn5dGSO3eq/s=;
        b=qJeclvGdAvnulcRu52rAc1S+0jkFbyWONDuF7mG17QnXwJAvcji53ofqzEWuX3094Xln14
        tK+5oyYm3q9IU2hENTiIDBC1lQ0tOnAD/6romLeKZnaDoFRVkl4rvYFlDquH1jpOtUCz0u
        lDCixK7X9oNdQFAIcqHNRYXgQg9i/I0=
Date:   Thu, 27 Oct 2022 13:46:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] x86/MCE/AMD: Clear DFR errors found in THR handler
Message-ID: <Y1pvkIJ/Uipxolqy@zn.tnic>
References: <20220621155943.33623-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621155943.33623-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 21, 2022 at 03:59:43PM +0000, Yazen Ghannam wrote:
> AMD's MCA Thresholding feature counts errors of all severites not just
> correctable errors. If a deferred error causes the threshold limit to be
> reached (it was the error that caused the overflow), then both a
> deferred error interrupt and a thresholding interrupt will be triggered.
> 
> The order of the interrupts is not guaranteed. If the threshold
> interrupt handler is executed first, then it will clear MCA_STATUS for
> the error. It will not check or clear MCA_DESTAT which also holds a copy
> of the deferred error. When the deferred error interrupt handler runs it
> will not find an error in MCA_STATUS, but it will find the error in
> MCA_DESTAT. This will cause two errors to be logged.
> 
> Check for deferred errors when handling a threshold interrupt. If a bank
> contains a deferred error, then clear the bank's MCA_DESTAT register.
> 
> Define a new helper function to do the deferred error check and clearing
> of MCA_DESTAT.
> 
> Fixes: 37d43acfd79f ("x86/mce/AMD: Redo error logging from APIC LVT interrupt handlers")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 1c87501e0fa3..ab1145cf8328 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -788,6 +788,28 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
>  	return status & MCI_STATUS_DEFERRED;
>  }
>  
> +static bool _log_error_deferred(unsigned int bank, u32 misc)
> +{
> +	bool defrd;
> +
> +	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
> +				mca_msr_reg(bank, MCA_ADDR), misc);
> +
> +	if (!defrd)
> +		return false;

I've zapped that defrd variable:

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ab1145cf8328..6ae7edea3270 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -790,12 +790,8 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
 
 static bool _log_error_deferred(unsigned int bank, u32 misc)
 {
-	bool defrd;
-
-	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-				mca_msr_reg(bank, MCA_ADDR), misc);
-
-	if (!defrd)
+	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
+			     mca_msr_reg(bank, MCA_ADDR), misc))
 		return false;
 
 	/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
