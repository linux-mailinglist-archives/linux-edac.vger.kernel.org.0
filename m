Return-Path: <linux-edac+bounces-5641-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA5D1CA68
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 07:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399F43024E6D
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 06:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848836C587;
	Wed, 14 Jan 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R4ILbbxy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2B326933
	for <linux-edac@vger.kernel.org>; Wed, 14 Jan 2026 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371494; cv=none; b=J461lfYQ3C/w0NivC/cQ+jAS8HXsezcrjU7hLulk6iPDKqpvAgQ1afcsy1T4mOfBEP9Rku7r92g5YB+cgAw7PihgU8VYlqhGqqTFzYe0SqlWSe1EH8qM8VTeOQ0l7iOl5XIwGhkHqBRgBHv6AK6Czfi/Ww0sFQIHlUZlx0/VqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371494; c=relaxed/simple;
	bh=yau+4rlRtbk+Hkl4uAzYetCD2LZ9ZvKbRGUV1gwIuDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaFJlvZ/Zy+yZlTaVEKxbsvdcimr8diiobWQcJLofIc6O2uMwXAWnIl7HebPISaFn6qIt4oj+w/3gBt0TnRipgh2Xj29cyKsBj50YsT9quEjLmQlFVv/nCT0EsfzzYAbIF+TeJhM+D8K8NFA+/E3AW8jiqW3a7a8/sGbSilnHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R4ILbbxy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so947961a12.0
        for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 22:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768371473; x=1768976273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ospkGk8mNG8iLzTlo0V1f4uk0KSl1JOaEVfqVAzbrRw=;
        b=R4ILbbxykmwLRryNfMJkHD0Uu1jTHObY+2h383fkY6yIqoO+3SFDbUzMvvzi7vGVLw
         S1+2bmI60PbpcCKKje/uCof2KdlnZOxb4xf2xELkQ6t+V57DRDXW5Nynd+82fUBCsXIz
         /1qWC1GVSAdS/qDM3WQzLsoVZ/0DuF+ed7MQYbjzHPCF8HWsKVXD8AHBSNYCijFstLGZ
         t5zpRiftZmYsHilK4PdqqkhXevl48wptrHckf41TOltRm+fYQw5AQGSL4JDqsbLBLAS2
         KncgMJ3WtMbA8n5Bgsnk4rpAw2u9QHoxR4vHbUnNSHcXVMWvlZo+aQxjRr2XjsFGLyIM
         pknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768371473; x=1768976273;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ospkGk8mNG8iLzTlo0V1f4uk0KSl1JOaEVfqVAzbrRw=;
        b=Hnnoab5b1aKMM3jHn7zFvP+pTKCUDPtscf5lvIaIjQlpcRUi0gflAiVm47fY76GDbE
         tb76tfj8QJK7+b5uao0Z3k37zmUZPu17Wq0D3AKacu5kpIj+3y9JplLX098QP6oUC/VP
         utIVXNl1H/+8MGKY+3CmbVuzRSKCnWDIs5JvTHEc29lgDBOSPtSCaDS/pvaRDsR0/Tap
         zSs/aMhyf8EYdPl0T3iAyydbzMFf6ruwEJRK+5lfkwWAJKvSAkrj47OlxPTjjQ7EDbM9
         8G5GCxdB7E6R+dNNDanToXQJEW/DpGC3yXZberRKy3kkEzPgXQDMLOUDCTLeu68IqyNN
         Wy+A==
X-Forwarded-Encrypted: i=1; AJvYcCVUiMQPgRhONrSdZ9Z8goKClXMpya3KE+1Yvs/Vm3Ta/pNCP8DDFHiitUJMm5d4jT1BKdCyGjOVLHIK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39h/AvgiITxMVCLmv8sMYIlJ1BI1AdKH3onXOuC0hrvMi4TGB
	MvlOc9LepBcudERfUYXpbBsqi47NZzS13aDODWLLJ8Oj4atUBv2jkcurlS0a6TQb1EU=
X-Gm-Gg: AY/fxX6Xwu264Gc4EM/leR2LW2xrysRvZjPu4K2KnZXmnwiWzHjw96vfE9ywc1T5TGw
	jffAnWw7BGogdkPnUL3tebuhj+4E7UvbdyDv47+qJDVt5cZglIUBz2Tt6dkM/3D0RB3FVaXxKSs
	bQCQ0aiGx4hcbUnQZwlf/2BVSmoCeD9op4vIV3JLDIDothB65bP//jS/VW66z/GeRWu4eEFmp6t
	c4QPcUGXaMDbCyayg4XUbMDDQGmfYZ2++ArOHr8BKigAQzO3fuU0lLXhhokd/MC1xhtKddpjJhl
	y1kz74oYzCqux8fpypOEQqPvpQDghoNQPznrtUeEnJ5ugvhdPlpZWTXDSwwf/DxUh6wBaDYKHFg
	cD3QP1DjbQJNSQDrzFwCXFoTqEcDpGFt1tEKd51htqR06NXROH/SnR8q2GIpiS5wEqHLh+egBni
	BrOh3f1XGhb+TxSWq6mGpjuGBq+zInNAq2kKR7
X-Received: by 2002:a17:906:d553:b0:b87:1755:99da with SMTP id a640c23a62f3a-b87357db944mr440741266b.9.1768371472835;
        Tue, 13 Jan 2026 22:17:52 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b876c599391sm33571066b.58.2026.01.13.22.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 22:17:52 -0800 (PST)
Message-ID: <d2378cc7-d97e-4e8d-b1e7-af5ce3265d2e@suse.com>
Date: Wed, 14 Jan 2026 08:17:50 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.01.26 г. 0:41 ч., Borislav Petkov wrote:
> On Tue, Jan 13, 2026 at 10:31:58PM +0100, Borislav Petkov wrote:
>> Ufff, how silly and overengineered we've made it. I need to think about
>> a cleaner solution tomorrow...
> 
> One idea I just thought of:
> 
> those two steps:
> 
> 1. setting mce_need_notify, and
> 
> 2.  testing and clearing it
> 
> are basically logically a one query: do we have logged errors, or, IOW, is the
> gen pool not empty?
> 
> IOW, this below.
> 
> That'll get rid of that gunk of when should we test and when set and will
> JustWork(tm) for what we want it to do.
> 
> But let's see how it all really works tomorrow...
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 34440021e8cf..c378d4d450b6 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -595,7 +595,7 @@ static bool mce_notify_irq(void)
>   	/* Not more than two messages every minute */
>   	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>   
> -	if (test_and_clear_bit(0, &mce_need_notify)) {
> +	if (!mce_gen_pool_empty()) {
>   		mce_work_trigger();
>   
>   		if (__ratelimit(&ratelimit))
> @@ -618,10 +618,6 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
>   	/* Emit the trace record: */
>   	trace_mce_record(err);
>   
> -	set_bit(0, &mce_need_notify);
> -
> -	mce_notify_irq();
> -

so now mce_notify_irq() is not being called from the early notifier, i.e 
the callchain mc_poll_banks -> machine_check_poll -> mce_log no longer 
call mce_notify_irq() in the early notifier chain.

>   	return NOTIFY_DONE;
>   }
>   


