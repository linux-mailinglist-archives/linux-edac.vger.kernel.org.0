Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D196137AD17
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEKR2Z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 13:28:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhEKR2Y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 13:28:24 -0400
Received: from zn.tnic (p200300ec2f0ec70020ab858661d7f414.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:20ab:8586:61d7:f414])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45B771EC02E6;
        Tue, 11 May 2021 19:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620754037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B3r/YO4GVHpZhNHppOEhHaJZiEO73O06Xor7sWfCBJg=;
        b=HKDtVnk855QV7vLOW2EqBGvdL5dVylFBP/gFe7MQ/dzTxDmYSfXzIJUgwIaTtg3uP4sDEA
        bb4L3PWBo7/cMO9PJUsEsJL+B1KYVLpRid+IA6r3fXJ/8JNYWOC0NiTgTHaexiAOnvLth0
        HVYns2auhDoC5XX6KTAeNHrUG+Xtgyo=
Date:   Tue, 11 May 2021 19:27:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Message-ID: <YJq+ca+kJ4cRl5B8@zn.tnic>
References: <20210511152538.148084-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210511152538.148084-1-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 11, 2021 at 08:55:36PM +0530, Naveen Krishna Chatradhi wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index e486f96b3cb3..055f3a0acf5e 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -90,6 +90,7 @@ static struct smca_bank_name smca_names[] = {
>  	[SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
>  	[SMCA_PIE]	= { "pie",		"Power, Interrupts, etc." },
>  	[SMCA_UMC]	= { "umc",		"Unified Memory Controller" },
> +	[SMCA_UMC_V2]	= { "umc_v2",		"Unified Memory Controller" },

So this is called "umc_v2" but the other V2 FUs's strings are the same.
Why?

Also, if you're going to repeat strings, you can just as well group all
those which are the same this way:

	[ SMCA_UMC ... SMCA_UMC_V2 ]    = { "umc",              "Unified Memory Controller" },

and do that for all which have V1 and V2.

I mean, gcc is smart enough to do that behind the scenes for identical
strings but you should do that in C too.

> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 5dd905a3f30c..5515fd9336b1 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -323,6 +323,21 @@ static const char * const smca_umc_mce_desc[] = {
>  	"AES SRAM ECC error",
>  };
>  
> +static const char * const smca_umc2_mce_desc[] = {

Ok, gcc reuses the identical string pointers from smca_umc_mce_desc[] so
we should be ok wrt duplication.

> +	"DRAM ECC error",
> +	"Data poison error",
> +	"SDP parity error",
> +	"Reserved",
> +	"Address/Command parity error",
> +	"Write data parity error",
> +	"DCQ SRAM ECC error",
> +	"Reserved",
> +	"Read data parity error",
> +	"Rdb SRAM ECC error",
> +	"RdRsp SRAM ECC error",
> +	"LM32 MP errors",
> +};

...


> +static const char * const smca_xgmipcs_mce_desc[] = {
> +	"DataLossErr",
> +	"TrainingErr",
> +	"FlowCtrlAckErr",
> +	"RxFifoUnderflowErr",
> +	"RxFifoOverflowErr",
> +	"CRCErr",
> +	"BERExceededErr",
> +	"TxVcidDataErr",
> +	"ReplayBufParityErr",
> +	"DataParityErr",
> +	"ReplayFifoOverflowErr",
> +	"ReplayFIfoUnderflowErr",
> +	"ElasticFifoOverflowErr",
> +	"DeskewErr",
> +	"FlowCtrlCRCErr",
> +	"DataStartupLimitErr",
> +	"FCInitTimeoutErr",
> +	"RecoveryTimeoutErr",
> +	"ReadySerialTimeoutErr",
> +	"ReadySerialAttemptErr",
> +	"RecoveryAttemptErr",
> +	"RecoveryRelockAttemptErr",
> +	"ReplayAttemptErr",
> +	"SyncHdrErr",
> +	"TxReplayTimeoutErr",
> +	"RxReplayTimeoutErr",
> +	"LinkSubTxTimeoutErr",
> +	"LinkSubRxTimeoutErr",
> +	"RxCMDPktErr",

What happened to those and why aren't they proper words like the other
error descriptions?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
