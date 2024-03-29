Return-Path: <linux-edac+bounces-854-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08673891401
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 08:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBEFB22CA6
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057733FB2A;
	Fri, 29 Mar 2024 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/IWuFJy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A53D964;
	Fri, 29 Mar 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696293; cv=none; b=SRExzY7Os8vWH7mHIbRShaFInkB87RlyJVUnZHk/R3yRhsvO9mbGdCkZDSVeYq3l8vbmzu1F0/0pgdNqCeh1AtpSOowNUtEjiaRomGKZuS4gOdVgZgmiwwylrhB0EWolzppRT+imhttz6X4ms6noskKay1wEppchnT0RpaaDg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696293; c=relaxed/simple;
	bh=D7kH7c8wYDKL3JAmK9VN3cdm/7ml16PXz2EbB8purYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7kzFvU1MA6TJAlWE8Gkp/hsOrE0F/iOWdQAGDyjEHWhzQQAhz8GPH8ZHmswdysayMhNG7D+C61laLh4Rga4IhKB+naw1FQKWbXjk1VN8Iaz+asQMiQoCTvyvzlJcmsSjN4/Hk/RDIuekJRQARsm1MsqNYE9JtkI9+uXpWcC1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/IWuFJy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a468226e135so210396266b.0;
        Fri, 29 Mar 2024 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711696290; x=1712301090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlXzzva3tzYsTbX/Roe1pmkbSeytRQqKfpMzo4ef9kA=;
        b=Y/IWuFJy4qvEa2Bmc4Xtl8lsez2ojixF0cR4B+4DwH50Jt1mEvwqDqf5raNwcz7OO7
         22gFa/ECog26sbZdX3DZslAWuHPW4cgL8aPvkKUE72yp5Y3DJ8OhtRTIHRVgZqcKdklc
         stKaYNwamdpv2VyEQ9ycmByoc+jA9Ni2PeEUkCPSNSUF+k66ln27rdcqiX25A7nAqLYZ
         vpww4OMJjoPLe4Phzt2AGk9D7WV4zKrMWHb01wQKPWowFmE7snehh/SbJmaxNHTQcT0N
         PDUmQVOuUOfaqh/veHw7Uwg1w+zHRKDFMoVR698KVhF5la7IcJ9fngtHPK/G+NgJhhlz
         AFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711696290; x=1712301090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlXzzva3tzYsTbX/Roe1pmkbSeytRQqKfpMzo4ef9kA=;
        b=RUQE3/xndAt1TeKm1VhNkqkOyNewxD0TJB18DBkVqn5BGHc5nsdMVTkohDTfLVsWSk
         jAJNzkS3y4W5L3DrMxbvaxZvy9XQ+WG5S69YV9N70B9eDA/f6nB7OVCEIJMwFQ4PpmUx
         3KvoblElIS/SKjBbmUWYBwvTFyEL17w1FR5yLAr+1bLjjkkpkyqHzk8AocLoOQDSOjlC
         yhxh96frmO1xy1yJpljToCA97WwY2/qZUnzSkNQh2A7t7qSejHd9+3gQBeD2gvRlPpJb
         VJrB4Ml26ZBaBgsmHi3j+dZwAOpMfCWalKIGrLYFghwrIXS0ZYvVatE06CLMx7S8o3HQ
         kGcw==
X-Forwarded-Encrypted: i=1; AJvYcCX2oNH/irEnrLOYw3AI5ZNVl4EVhD3ouiabixJYkOSaJf7nm1n7YLAtnWsTegblFsZkQLIr0a/UfpKd5b5iVlHloARLryvq42OEqw==
X-Gm-Message-State: AOJu0YxzvEk9CEW/V3bnmSy95HHdaqPFXON6lxg5INz9o2fbUAbhehK3
	PLPXHewFNLOhq1ZUXHMbgugw/CAxNBcnhf+q76yiShFVyKjAcrco
X-Google-Smtp-Source: AGHT+IEgGqlQKmbb893pqci3FE+uu9vtfZQCX0qThXh0/soxN53rUqzcmaChWf4gPzV3WpKey2c6VA==
X-Received: by 2002:a17:906:d054:b0:a4e:14a1:fa81 with SMTP id bo20-20020a170906d05400b00a4e14a1fa81mr1029094ejb.46.1711696290039;
        Fri, 29 Mar 2024 00:11:30 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id z1-20020a170906668100b00a474b7bbc76sm1588795ejo.56.2024.03.29.00.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:11:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 08:11:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	rostedt@goodmis.org, tony.luck@intel.com, bp@alien8.de,
	x86@kernel.org, sohil.mehta@intel.com, yazen.ghannam@amd.com,
	avadnaik@amd.com
Subject: [PATCH] x86/mce: Clean up TP_printk() output line of the mce_record
 tracepoint
Message-ID: <ZgZpn/zbCJWYdL5y@gmail.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
 <20240328180435.435076-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328180435.435076-2-avadhut.naik@amd.com>


* Avadhut Naik <avadhut.naik@amd.com> wrote:

>  
> +/*
> + * MCE Event Record.
> + *
> + * Only very relevant and transient information which cannot be
> + * gathered from a system by any other means or which can only be
> + * acquired arduously should be added to this record.
> + */
> +
>  TRACE_EVENT(mce_record,
>  
>  	TP_PROTO(struct mce *m),
> @@ -25,6 +33,7 @@ TRACE_EVENT(mce_record,
>  		__field(	u64,		ipid		)
>  		__field(	u64,		ip		)
>  		__field(	u64,		tsc		)
> +		__field(	u64,		ppin		)
>  		__field(	u64,		walltime	)
>  		__field(	u32,		cpu		)
>  		__field(	u32,		cpuid		)
> @@ -45,6 +54,7 @@ TRACE_EVENT(mce_record,
>  		__entry->ipid		= m->ipid;
>  		__entry->ip		= m->ip;
>  		__entry->tsc		= m->tsc;
> +		__entry->ppin		= m->ppin;
>  		__entry->walltime	= m->time;
>  		__entry->cpu		= m->extcpu;
>  		__entry->cpuid		= m->cpuid;
> @@ -55,7 +65,7 @@ TRACE_EVENT(mce_record,
>  		__entry->cpuvendor	= m->cpuvendor;
>  	),
>  
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x",

Please split out the other (capitalization) changes to the output into 
a separate patch.

- While at it, don't forget to:

   s/ADDR/MISC/SYND
    /addr/misc/synd

- Also, it's a bit weird that we have 'CPU' but also 'processor' 
  fields, why isn't it 'vendor' and 'CPUID'?

- Finally, why are some fields 'merged' as per ADDR/MISC/SYND, while 
  others are listed separately? All that have separate names should be 
  listed separately.

Ie. something like the patch below?

Thanks,

	Ingo

============>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 29 Mar 2024 08:09:23 +0100
Subject: [PATCH] x86/mce: Clean up TP_printk() output line of the mce_record tracepoint

 - Only capitalize entries where that makes sense
 - Print separate values separately
 - Rename 'PROCESSOR' to vendor & CPUID

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/trace/events/mce.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..c5b0523f25ee 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -55,15 +55,18 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, addr: %016Lx, misc: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
 		__entry->ipid,
-		__entry->addr, __entry->misc, __entry->synd,
+		__entry->addr,
+		__entry->misc,
+		__entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
-		__entry->cpuvendor, __entry->cpuid,
+		__entry->cpuvendor,
+		__entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid)

