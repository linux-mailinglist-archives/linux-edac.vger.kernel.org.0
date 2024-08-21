Return-Path: <linux-edac+bounces-1717-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABA95A40F
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3051F25EA7
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A461B3B3D;
	Wed, 21 Aug 2024 17:40:32 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090E14E2CB;
	Wed, 21 Aug 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262032; cv=none; b=Y/sxlSS+ppz3dTvSg8849lJjoOeT4Ygnr8/7+/AVe6Q2F5knd3qqxwKJjSKPS2pIPQq8vVPA6bHEx0iteF1QnaEjDfngYxEtwmGBlDDzxPKaNHAW0UtNPSxcUuVwiPtaDrr7Ey/TZaqRBUPaI1DR1/oUXCv+/cKlGlGAkXCSdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262032; c=relaxed/simple;
	bh=jTHolsPXS8wT18MlchshV3tM0629BPB8suiDRw/qZks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXoXh3SxK4rcyrwxa3AoyOTZj1cMAYpIVW7vf4yM0XiAVfqjpEAwFJPnpqOU0kuCtXe+HvFoA2ocMhJmWFXOFccjy2gh6BKqhYcTD1eShIGL58xzOj6wAyX9A1byePt7qVvKpM/zYYcg6KIeQ7EA+oLK+CBqkFoousFD2D/fsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC791C32781;
	Wed, 21 Aug 2024 17:40:28 +0000 (UTC)
Date: Wed, 21 Aug 2024 13:40:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <lenb@kernel.org>, <mchehab@kernel.org>, <james.morse@arm.com>,
 <airlied@gmail.com>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
 <avadnaik@amd.com>
Subject: Re: [PATCH v4 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <20240821134057.6fc50940@gandalf.local.home>
In-Reply-To: <20240815211635.1336721-3-avadhut.naik@amd.com>
References: <20240815211635.1336721-1-avadhut.naik@amd.com>
	<20240815211635.1336721-3-avadhut.naik@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 16:16:33 -0500
Avadhut Naik <avadhut.naik@amd.com> wrote:

> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 65aba1afcd07..1e7d5696b3ba 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
>  		__field(	u8,		bank		)
>  		__field(	u8,		cpuvendor	)
>  		__field(	u32,		microcode	)
> +		__field(	u8,		len	)

You don't need to save the length. It's already saved in the
__dynamic_array meta data.

> +		__dynamic_array(u8, v_data, sizeof(err->vendor))
>  	),
>  
>  	TP_fast_assign(
> @@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
>  		__entry->bank		= err->m.bank;
>  		__entry->cpuvendor	= err->m.cpuvendor;
>  		__entry->microcode	= err->m.microcode;
> +		__entry->len		= sizeof(err->vendor);
> +		memcpy(__get_dynamic_array(v_data), &err->vendor, sizeof(err->vendor));
>  	),
>  
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
>  		__entry->cpu,
>  		__entry->mcgcap, __entry->mcgstatus,
>  		__entry->bank, __entry->status,
> @@ -83,7 +87,8 @@ TRACE_EVENT(mce_record,
>  		__entry->walltime,
>  		__entry->socketid,
>  		__entry->apicid,
> -		__entry->microcode)
> +		__entry->microcode,
> +		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))

You can replace the __entry->len with:

		__print_array(__get_dynamic_array(v_data), __get_dynamic_array_len(v_data) / 8, 8))

Hmm, I should add a helper function that would do the same with just:

		__print_dynamic_array(vdata, 8);

Where it will have __print_dynamic_array(array-name, el-size)

-- Steve

>  );
>  
>  #endif /* _TRACE_MCE_H */


