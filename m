Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28964135856
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2020 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgAILqL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 06:46:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51702 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgAILqL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 06:46:11 -0500
Received: from zn.tnic (p200300EC2F0C5700288952748FF21F24.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:2889:5274:8ff2:1f24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E5701EC0AED;
        Thu,  9 Jan 2020 12:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578570370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TvfFRMR6ycdcrY1OKKxWXR/kNAvBaZFOPHrkYJ3yApE=;
        b=rnJQRQJLqKbuhnx62nJcYoFHz/TlvwipjK30beLzv5OeZSmT6oSF4/vCSPKoLOMjy+FHUg
        q/E21eg1FLO81zgK0b7XX+hKb0ZIysUfYx0NYGq1P+vAqAbaHw62DKizMRBC4Nu4K5gwEn
        KH3IOM9z38XYIuGKX6H2UuvQGprhzHM=
Date:   Thu, 9 Jan 2020 12:46:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xie XiuQi <xiexiuqi@huawei.com>, James Morse <james.morse@arm.com>
Cc:     tony.luck@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] trace: ras: print the raw data of arm processor error
 info
Message-ID: <20200109114603.GC5603@zn.tnic>
References: <20191214121109.8349-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214121109.8349-1-xiexiuqi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Dec 14, 2019 at 08:11:09PM +0800, Xie XiuQi wrote:
> User space tools such as rasdaemon need the complete error
> information from trace event. So, we print the raw data of
> error information in arm_event.
> 
> In the past, I try to parse them in trace event, but it's
> hard to deal the dynamic error item. And in commit 301f55b1a917
> ("efi: Parse ARM error information value"), the error information
> already been parsed to syslog.
> 
> So, just print the raw data in trace event for simpler.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  include/ras/ras_event.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 36c5c5e38c1d..2023ba9206b3 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -180,6 +180,9 @@ TRACE_EVENT(arm_event,
>  		__field(u32, running_state)
>  		__field(u32, psci_state)
>  		__field(u8, affinity)
> +		__field(u32, count)
> +		__field(u32, len)
> +		__dynamic_array(u8, err_info, proc->err_info_num * sizeof(struct cper_arm_err_info))
>  	),
>  
>  	TP_fast_assign(
> @@ -199,12 +202,18 @@ TRACE_EVENT(arm_event,
>  			__entry->running_state = ~0;
>  			__entry->psci_state = ~0;
>  		}
> +
> +		__entry->count = proc->err_info_num;
> +		__entry->len = __entry->count * sizeof(struct cper_arm_err_info);
> +		memcpy(__get_dynamic_array(err_info), proc + 1, __entry->len);
>  	),
>  
>  	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> -		  "running state: %d; PSCI state: %d",
> +		  "running state: %d; PSCI state: %d; error count: %d; "
> +		  "raw data: %s",
>  		  __entry->affinity, __entry->mpidr, __entry->midr,
> -		  __entry->running_state, __entry->psci_state)
> +		  __entry->running_state, __entry->psci_state, __entry->count,
> +		  __print_hex(__get_dynamic_array(err_info), __entry->len))
>  );
>  
>  /*
> -- 

That's for ARM folks to decide whether they wanna shuffle raw error
records into userspace like that. CCed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
