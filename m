Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2046D2442
	for <lists+linux-edac@lfdr.de>; Fri, 31 Mar 2023 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjCaPoX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 Mar 2023 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjCaPoU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 31 Mar 2023 11:44:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C31EFC8;
        Fri, 31 Mar 2023 08:44:18 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E8AD1EC054E;
        Fri, 31 Mar 2023 17:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680277457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uOXvk0lXz8sOScAFN5PiHAvC4fkV3slYbSlEtYIkG9o=;
        b=mjvV+leo+m6gctb9bQve0ooLZD8L9ZxWZcThxRYs6xZvpC8682Vcrf/aLFEwklxKBTfvgv
        f9E8cjRUO2OSySh+fEJoIwWYvQBQsBpyaj0qRI20/4fA5p1Vq3BTLQTbfPTNoBqPwBcOZh
        I2Kom+byeEF0IhgAwEV7sC226qr1Nu0=
Date:   Fri, 31 Mar 2023 17:44:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Avadhut Naik <avadnaik@amd.com>
Cc:     linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Update SMCA bank error descriptions
Message-ID: <20230331154412.GBZCb/zO/BGR3a/bVT@fat_crate.local>
References: <20230329192200.110813-1-avadnaik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329192200.110813-1-avadnaik@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 29, 2023 at 07:22:00PM +0000, Avadhut Naik wrote:
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index cc5c63feb26a..869dcca5e2f4 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -192,24 +192,24 @@ static const char * const smca_ls2_mce_desc[] = {
>  	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
>  	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
>  	"A hardware assertion error was reported",
> -	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
> +	"A parity error was detected in an STLF, SCB EMEM entry, store data mask or SRB store data by any access",

I'm assuming that "by any access" is not needed because
amd_decode_err_code() would say "GEN"-eric for the transaction type
which is the same thing, basically.

>  static const char * const smca_if_mce_desc[] = {
> -	"Op Cache Microtag Probe Port Parity Error",
> +	"Op Cache Microtag Parity Error",
>  	"IC Microtag or Full Tag Multi-hit Error",
>  	"IC Full Tag Parity Error",
>  	"IC Data Array Parity Error",
> -	"Decoupling Queue PhysAddr Parity Error",
> +	"PRQ Parity Error",
>  	"L0 ITLB Parity Error",
> -	"L1 ITLB Parity Error",
> -	"L2 ITLB Parity Error",
> +	"L1-TLB Parity Error",
> +	"L2-TLB Parity Error",
>  	"BPQ Thread 0 Snoop Parity Error",
>  	"BPQ Thread 1 Snoop Parity Error",
> -	"L1 BTB Multi-Match Error",
> -	"L2 BTB Multi-Match Error",
> +	"BP L1-BTB Multi-Hit Error",
> +	"BP L2-BTB Multi-Hit Error",
>  	"L2 Cache Response Poison Error",
> -	"System Read Data Error",
> +	"L2 Cache Error Response",

Hmm, so I don't think we can do that - I'll bet on older Zens, this was
"System Read Data Error" and on newer it is "L2 Cache Error Response"
which are not the same thing.

Right?

If so, we can't really "update" descriptions like that. If we had to be
precise, we will have to differentiate by family here. Not sure if we
care enough but still...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
