Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299073BA8E
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFWOqc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjFWOqJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 10:46:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B3A1;
        Fri, 23 Jun 2023 07:46:00 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 256561EC03C0;
        Fri, 23 Jun 2023 16:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687531559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=72D4APT785MRKgb7gE3/xsKu0nhOfh7JKYy3cm9up4g=;
        b=A47UKYtvPgnL6kVloE5ywvQb9Ozq9Ni+7YlmLYxhUTxCvg457TnKArE/qQ5YOKHPz4Vzpx
        YZKcUhKnGS0nCj0T7eowehLqdSYAvN6cl4znZaWpIYDt8kDGkaI95Dh5D/ttnlJXjEqMHy
        r8Lffb2y/P9ECW2S3bg8/qrvOdqvD+U=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kQRBcalhvEKI; Fri, 23 Jun 2023 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687531556; bh=72D4APT785MRKgb7gE3/xsKu0nhOfh7JKYy3cm9up4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZjDVvarNOaVPisbHs0oKMUW3BgWFkeVYSIzPiJd/vEaa7me+YUiVGAjEH7buGmqB
         l+iCMzfX4Yh9cIPCR4An0FubDvQpTA7AWOPWMnuEgLicCLVu+tfuqc8gI0g5qOhwz7
         GnyGkvEA5pSUcvaAex55vur8ZDP0D2shs/tMtquvWlVgc0mW6ZLZQJPbXqZwmFw+ZD
         rjIXJX813fHEo89TSPlqBZRYfAi1uNQkKxFsBjqIOhqC+gTjqRm8kEPujqDQmNN7tS
         HhCaQngA6STEWC86PNxK8dJr9Qk5MJlWMg+3WQM5yPD5f87JYJqsyoEgErqFEasDFZ
         Hzym5HczzeXmZOKBsyQMO3IPaLhH/rleeDfNLTkGdSdZmDh7PTEBPb+lur5aWd/R2b
         gAUt1vePRQGG5S2GxfANpIijhlBnewhVfUAsndfkUU0dU9WFjvrXxG4QC7H1hA3Nlk
         +GvvyvZVrlNHjNo/FQb00gU/fYWxSg9fr79JLXs/b7WXOoE2mjgm5IZx8auxi9E/To
         FYzqD8ZIyRJhwp3jIrPGa93Rl9bFSZBl1JdTwaRRnzWEjrM8Y3sSGnFTYUzolehnk+
         P65OYUpTWXyPAEFHjiTHEbicr0vSflSVpK/W/JnagVvt7tUwD7OByAaFl7pkf0MMIZ
         4ZHYhwikdu1t7n0cBAuuC/Bg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58BFA40E01DB;
        Fri, 23 Jun 2023 14:45:48 +0000 (UTC)
Date:   Fri, 23 Jun 2023 16:45:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita.KoralahalliChannabasappa@amd.com
Cc:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 3/4] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <20230623144542.GBZJWwFvA+1uXC1A1g@fat_crate.local>
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
 <20230616182744.17632-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616182744.17632-4-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 16, 2023 at 11:27:43AM -0700, Tony Luck wrote:
> +static void _reset_block(struct threshold_block *block)
> +{
> +	struct thresh_restart tr;
> +
> +	memset(&tr, 0, sizeof(tr));
> +	tr.b = block;
> +	threshold_restart_bank(&tr);
> +}

> +
> +static void toggle_interrupt_reset_block(struct threshold_block *block, bool on)
> +{
> +	if (!block)
> +		return;
> +
> +	block->interrupt_enable = !!on;
> +	_reset_block(block);
> +}
> +
> +void mce_amd_handle_storm(int bank, bool on)
> +{
> +	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
> +	struct threshold_bank **bp = this_cpu_read(threshold_banks);
> +	unsigned long flags;
> +
> +	if (!bp)
> +		return;
> +
> +	local_irq_save(flags);
> +
> +	first_block = bp[bank]->blocks;
> +	if (!first_block)
> +		goto end;
> +
> +	toggle_interrupt_reset_block(first_block, on);
> +
> +	list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
> +		toggle_interrupt_reset_block(block, on);
> +end:
> +	local_irq_restore(flags);
> +}

There's already other code which does this threshold block control. Pls
refactor and unify it instead of adding almost redundant similar functions.

>  static void mce_threshold_block_init(struct threshold_block *b, int offset)
>  {
>  	struct thresh_restart tr = {
> @@ -868,6 +909,7 @@ static void amd_threshold_interrupt(void)
>  	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
>  	struct threshold_bank **bp = this_cpu_read(threshold_banks);
>  	unsigned int bank, cpu = smp_processor_id();
> +	u64 status;
>  
>  	/*
>  	 * Validate that the threshold bank has been initialized already. The
> @@ -881,6 +923,13 @@ static void amd_threshold_interrupt(void)
>  		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
>  			continue;
>  
> +		rdmsrl(mca_msr_reg(bank, MCA_STATUS), status);
> +		track_cmci_storm(bank, status);

So this is called from interrupt context.

There's another track_cmci_storm() from machine_check_poll() which can
happen in process context.

And there's no sync (locking) between the two. Not good.

Why are even two calls needed on AMD?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
