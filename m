Return-Path: <linux-edac+bounces-1957-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B12998DE59
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938831C239D2
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1DE1D0BBE;
	Wed,  2 Oct 2024 15:05:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827110E9;
	Wed,  2 Oct 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881553; cv=none; b=BeF7Xjh/h+DtWZ2JD6e3PDm2BvFchsJZmxI13W+9088ojn+DVbvzOP/4Xoi+QGldosbB4ga3uGBLpGj675clbnOdo/tUpWyUpwVBCzmVN3mSY6cX979xvEm1xpICmiPGS76OhwywQ6JrPsbsL6i/jMUDlrTO77KZFLXGLcaPIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881553; c=relaxed/simple;
	bh=sTyfXfDKoj/d7a60kOcmZGiIgkCOaLA98f9leZIsn2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOJDEYKdNReutW2FP14leMeTo2XMuTz7WCJzOHmjvR1S54fB4KgFtsDJrSaJt1aDQU5XiRN7XDnXhcr3OUtja/A7glmnG+/ePj3Gre4nWJ8OJesv1h1WcnzxaiipKQoal3F2roOurx9x+jVna6e+gYtgJ9tqszrFJYbpV/M36mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1FC4CECD;
	Wed,  2 Oct 2024 15:05:50 +0000 (UTC)
Date: Wed, 2 Oct 2024 11:06:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <lenb@kernel.org>, <mchehab@kernel.org>, <james.morse@arm.com>,
 <airlied@gmail.com>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
 <avadnaik@amd.com>
Subject: Re: [PATCH v5 2/5] tracing: Add __print_dynamic_array() helper
Message-ID: <20241002110641.3575c632@gandalf.local.home>
In-Reply-To: <20241001181617.604573-3-avadhut.naik@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
	<20241001181617.604573-3-avadhut.naik@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 18:12:26 +0000
Avadhut Naik <avadhut.naik@amd.com> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When printing a dynamic array in a trace event, the method is rather ugly.
> It has the format of:
> 
>   __print_array(__get_dynamic_array(array),
>             __get_dynmaic_array_len(array) / el_size, el_size)
> 
> Since dynamic arrays are known to the tracing infrastructure, create a
> helper macro that does the above for you.
> 
>   __print_dynamic_array(array, el_size)
> 
> Which would expand to the same output.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

I'm currently adding code where I need this patch too ;-)

I can make a branch that only has this patch based off of v6.12-rc1 where
we can both use it. Can we do that?

-- Steve


> ---
> Changes in v5:
> Patch introduced in the series.
> ---
>  include/trace/stages/stage3_trace_output.h | 8 ++++++++
>  include/trace/stages/stage7_class_define.h | 1 +
>  samples/trace_events/trace-events-sample.h | 7 ++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
> index c1fb1355d309..8e3215093e1f 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -119,6 +119,14 @@
>  		trace_print_array_seq(p, array, count, el_size);	\
>  	})
>  
> +#undef __print_dynamic_array
> +#define __print_dynamic_array(array, el_size)				\
> +	({								\
> +		__print_array(__get_dynamic_array(array),		\
> +			      __get_dynamic_array_len(array) / el_size,	\
> +			      el_size);					\
> +	})
> +
>  #undef __print_hex_dump
>  #define __print_hex_dump(prefix_str, prefix_type,			\
>  			 rowsize, groupsize, buf, len, ascii)		\
> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> index bcb960d16fc0..fcd564a590f4 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -22,6 +22,7 @@
>  #undef __get_rel_cpumask
>  #undef __get_rel_sockaddr
>  #undef __print_array
> +#undef __print_dynamic_array
>  #undef __print_hex_dump
>  #undef __get_buf
>  
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 55f9a3da92d5..999f78d380ae 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -319,7 +319,7 @@ TRACE_EVENT(foo_bar,
>  		__assign_cpumask(cpum, cpumask_bits(mask));
>  	),
>  
> -	TP_printk("foo %s %d %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
> +	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
>  
>  /*
>   * Notice here the use of some helper functions. This includes:
> @@ -363,6 +363,11 @@ TRACE_EVENT(foo_bar,
>  		  __print_array(__get_dynamic_array(list),
>  				__get_dynamic_array_len(list) / sizeof(int),
>  				sizeof(int)),
> +
> +/*     A shortcut is to use __print_dynamic_array for dynamic arrays */
> +
> +		  __print_dynamic_array(list, sizeof(int)),
> +
>  		  __get_str(str), __get_str(lstr),
>  		  __get_bitmask(cpus), __get_cpumask(cpum),
>  		  __get_str(vstr))


