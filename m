Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854F8731C58
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbjFOPUw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFOPUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 11:20:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69412E;
        Thu, 15 Jun 2023 08:20:49 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 218571EC0858;
        Thu, 15 Jun 2023 17:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686842448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fj2iR/eMNidl70OgvRwKnMRdIhxWJ2i0N+CGx9LcEN0=;
        b=AJGPUdi61ZBaqpDqZmB3+nm7hun4kZghQhFbT0cff9mIH8Dsvs0wJPHqsbLBOLjoIKnJ6O
        FxO+7Aas0CR5bdz4TK7sO0Yj14hlakRuA/KpJ0CCVehWITCbVn3S7RVHh+47qISimcB5ch
        EoUey7QLdUZyYRGUEGLCaOzavVltP+g=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ps0FFOcVRvk4; Thu, 15 Jun 2023 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686842445; bh=Fj2iR/eMNidl70OgvRwKnMRdIhxWJ2i0N+CGx9LcEN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOnMU30/kUJOo0orh+sUwrRUwzig7VEoiQIF2cg81LGer8eSjmiUCF1Y5xiAN0K0K
         WR+0hIVvobYTJWzPvj0BhnRJ2MMhUeFFyrPNwsIhH1yRMJ4fkAPgI/BHlWjF16h2R2
         7c/mzUNNVOl9ZP/EE9DsJ/LmNWVGVFwdTiUaW9800dL7nMlt+IJ5lFIJTkre4fG/Qu
         horKT79iyetJvC2Bo/dC4zWyVTGIcSp6M08QOoVjST4HsC0LB26GodwsaBXzDc2Qpg
         c9gZEq+liMntlnVXUqtiVvFSj9wvx6K88QCdqchnIDDpl+GlIfP6wq9UkBsA/AbR67
         nV4Ccpy3ABlaFzHGNKifmbLIcp7n1fHEGEUwubFztKqc7d5B1dGKmNa1Th5Nq6kwkj
         qsduR2e9ui0jXLwPgAytDHZS+BOxM6rRqR8BTMxBWBMidGj6ZO3T0Q/w3k6woFAcxv
         KIZ0yYYLpURnij4cbXS6+5Qoy03w4QGKy6qMEK+A/K7EOaxw1DKBT4L+ucYgNqzTX0
         HEwtYB8/ey9s7uiwBC71ojKUzn5o0veY0zuaimW8nGrDIFUV+uYpjLoKenGqRnsCV9
         AB6chIt1TvHc3kSpCj43BvjUGuRxPhcW0qb+v5ln12V6c4pjMyAbaEG7UqzmdAMYj3
         h+8cdxd5WHNrqApw84MjUImY=
Received: from zn.tnic (p200300ea971DC500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c500:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBE6640E018C;
        Thu, 15 Jun 2023 15:20:40 +0000 (UTC)
Date:   Thu, 15 Jun 2023 17:20:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Message-ID: <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417162006.3292715-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 17, 2023 at 04:20:06PM +0000, Yazen Ghannam wrote:
> @@ -97,20 +102,13 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  	if (ctx_info->reg_arr_size < 48)
>  		return -EINVAL;
>  
> -	mce_setup(&m);
> -
> -	m.extcpu = -1;
> -	m.socketid = -1;
> -
> -	for_each_possible_cpu(cpu) {
> -		if (cpu_data(cpu).initial_apicid == lapic_id) {
> -			m.extcpu = cpu;
> -			m.socketid = cpu_data(m.extcpu).phys_proc_id;
> +	for_each_possible_cpu(cpu)
> +		if (cpu_data(cpu).initial_apicid == lapic_id)
>  			break;
> -		}
> -	}
>  
> -	m.apicid = lapic_id;
> +	if (smp_call_function_single(cpu, __mce_setup, &m, 1))

I can see the following call-chain from NMI context which is a no-no:

ghes_notify_nmi
|-> ghes_in_nmi_spool_from_list
    |-> ghes_in_nmi_queue_one_entry
        |-> __ghes_panic
	    |-> __ghes_print_estatus
	        |-> cper_estatus_print
		    |-> cper_estatus_print_section
		        |-> cper_print_proc_ia
			    |-> arch_apei_report_x86_error
			        |-> apei_smca_report_x86_error
				    |-> smp_call_function_single


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
