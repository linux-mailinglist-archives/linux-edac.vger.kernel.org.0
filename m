Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6382F3F3244
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhHTRbu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 13:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhHTRbt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Aug 2021 13:31:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD0C061575;
        Fri, 20 Aug 2021 10:31:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f107b00196adb237f9ce365.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:196a:db23:7f9c:e365])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F8881EC0589;
        Fri, 20 Aug 2021 19:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629480666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lRij2bTpSGXVMDbhycmb3su8DPnygSPG8qvXt1BdmMQ=;
        b=GaEhMARj8xGVHTj7bt43VnhjzJAALO983uuEfnVXcY7iemcXn6D2JzdeM5GpM5554eoedj
        83L3SI19//s9Uf/driz3PyNsPgczirOiDKay/8/uEylpeovTWgsGglPxWYZn6L4uDnHyKB
        4vZ6J6dPquVkf5++AYKhlLsuBQkTbeg=
Date:   Fri, 20 Aug 2021 19:31:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YR/m/8PCmCTbogey@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818002942.1607544-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 17, 2021 at 05:29:40PM -0700, Tony Luck wrote:
> @@ -1287,17 +1291,34 @@ static void kill_me_maybe(struct callback_head *cb)
>  	}
>  }
>  
> -static void queue_task_work(struct mce *m, int kill_current_task)
> +static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
>  {
> -	current->mce_addr = m->addr;
> -	current->mce_kflags = m->kflags;
> -	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> -	current->mce_whole_page = whole_page(m);
> +	int count = ++current->mce_count;
>  
> -	if (kill_current_task)
> -		current->mce_kill_me.func = kill_me_now;
> -	else
> -		current->mce_kill_me.func = kill_me_maybe;
> +	/* First call, save all the details */
> +	if (count == 1) {
> +		current->mce_addr = m->addr;
> +		current->mce_kflags = m->kflags;
> +		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> +		current->mce_whole_page = whole_page(m);
> +
> +		if (kill_current_task)
> +			current->mce_kill_me.func = kill_me_now;
> +		else
> +			current->mce_kill_me.func = kill_me_maybe;
> +	}
> +
> +	/* Ten is likley overkill. Don't expect more than two faults before task_work() */

"likely"

> +	if (count > 10)
> +		mce_panic("Too many machine checks while accessing user data", m, msg);

Ok, aren't we too nasty here? Why should we panic the whole box even
with 10 MCEs? It is still user memory...

IOW, why not:

	if (count > 10)
		current->mce_kill_me.func = kill_me_now;

and when we return, that user process dies immediately.

> +	/* Second or later call, make sure page address matches the one from first call */
> +	if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> +		mce_panic("Machine checks to different user pages", m, msg);

Same question here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
