Return-Path: <linux-edac+bounces-4869-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61969B891F8
	for <lists+linux-edac@lfdr.de>; Fri, 19 Sep 2025 12:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DF23BF34F
	for <lists+linux-edac@lfdr.de>; Fri, 19 Sep 2025 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD48308F17;
	Fri, 19 Sep 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WVAhBzKQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F4306B17
	for <linux-edac@vger.kernel.org>; Fri, 19 Sep 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278583; cv=none; b=bXwUkgln6Y4O/2RrDkGrZW/TNmwkWYFjW+HSIwq6ug9UyR+aJxftB9b772KfEvl4NcYIrCKFnfR/KF+9oqUjL1LP5p0WkijH072IcmcTtnyx8N2wc3phivGHAnp+GE8IZnzLSSM/Q3+osfYMPHqFV7WUk9rLqTJaVwB9UFzlNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278583; c=relaxed/simple;
	bh=+JzZ1lcKi/XwHvN0bT8VLHcok4tzYHYA7niCaXgmp6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw7LbokuFvED2hQouhrihIN6NByy70XDE6iIRox/rZv/4rO4X6j2l9SSwgVtzXemBPdvctgeNlqU/OlUa57j6eZ8br4Ane0lN2aURtVZ10pPDqgIVcOI5fQDuHAqcS5viynM14iChDQuzvkPVekoxFXJ3YdukkZUxJhuNxpTZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WVAhBzKQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so357487966b.0
        for <linux-edac@vger.kernel.org>; Fri, 19 Sep 2025 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758278579; x=1758883379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihYBz/zfcgpG/TQdBCL4wkwIrU8k32PxFeX5ZO16w/k=;
        b=WVAhBzKQGBD9sR2gD/NgCI/ZNb97yS6XuwbwyEaPQzhtbmAxFJwvQLYOLQ0+DT9C6x
         jYK2EWpIC+fXVL11nTGw9qiLu81qbc5u+9sL3bK3OV9SfLkofXdGGwDUpDLwg9NFXSQx
         6sxxtWezQN3+8GtoB4T+tVNdg89XwPISOAc+4HaSUS+74XHtZiuSfXF+2vyUP1NX1FlT
         VSGL5uRlykCta/CsVgJAf/IKjVMs8gclbAvPk6DEgdkYzHpqLzY60nMFDuYlU8eMVHVr
         ptaW/Msfk+k2XgM0SAtEGnABI62D7pQ8XNIOWqssoWHBoQ1QCR5p6ZkTuusEg95LtmP7
         /y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758278579; x=1758883379;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihYBz/zfcgpG/TQdBCL4wkwIrU8k32PxFeX5ZO16w/k=;
        b=q7pJaSJr8VxGF9Uje407ZHy6WnxEwLF6OLKPwu8pM60za+1UXVPJIsUentMt/cwFKo
         mHChOmnycHLsBX4NmQAvpYyc34aAEUz+ko9/SyHzJS9DdzJyQF9oF6nso6XdQWospfWq
         ZzovVCHWHOCHdnedGTM/skUzrVtuXvB+9wiOqA4Xf13DYiawKI8wrEN99En8ldw8gpVC
         jCPBqLRchPOb9mgNG7Z4tFjT3uKgB8zTS2yDd985ppR1082g2lUr55tuRt00Ecsl4rWX
         VLKx4FInnIpdNqzarbLchcBh2Xd9Y84x3sj/2x3PP2Dv9IfpZJFKD4l9RT1qE2WAzsW1
         6rkA==
X-Forwarded-Encrypted: i=1; AJvYcCXoMIoEnEpyLY8wTfROQr9MiqWm8271fOCz0waGazvgP97wW5RtPgFDJsJ4nMWw6RAvBjjqKp9m1GNX@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXBD4jtGA+1vEialKk3JcVUtUfSVut/4NB0Cj4g/577QktxCq
	r2GILT3m7JQjpbuFHafnChCLXAkoBK07yhlMI/ItCz+k4/5WJs0EHcsWQ6q0Zn8j0V4=
X-Gm-Gg: ASbGnctZcJvGfedq9QGPAHIctGwPLo+YNgAJi4C+t44LwE/EnGQzjrJv/bQViVyiaR5
	APztP58oL+x8o4ILnK9+dlx2+aMTF+YUukek6zpBsJ6EwS6+1FRBp6Mle2bNsodjPecKyCNjiE+
	OJwthDfZCf6jlLZOYcuig52eH3wIuSiO7mmgvDgErUDdlsQvu7vxOmlB5oFpvf+XGDkyqEBvM0t
	9GcNdzvT3Q+UjpuubIJ+poxn9nwMYL0d/nvsZQfjE+m0cYqLiKroDO02DF7MIMqFGQeB0Eeiotc
	q7+flZFNVDxNW1My3ygb7xnKyL1gy7C5sDMuAT+H6yXOzrpa4kJr8qleWGoBJyCzp0z1mMpla4M
	MIOF6r4iStl4qSd7ggpGWRhSCUmxvDWavsgxe0FSs5lQsWDI=
X-Google-Smtp-Source: AGHT+IGMSebx4yMVoxYvKBsvfpQu5sA5tumjbV9DOc4mgo8cPctnw+Z/Yl6cbdb2H35TaWYPT0GnrQ==
X-Received: by 2002:a17:907:6eab:b0:b21:b4f6:d676 with SMTP id a640c23a62f3a-b24eedb9ee5mr320177966b.25.1758278578896;
        Fri, 19 Sep 2025 03:42:58 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44fcesm401731266b.20.2025.09.19.03.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 03:42:58 -0700 (PDT)
Message-ID: <6e2d5351-dbd2-4e28-8bdb-b961fade5ebc@suse.com>
Date: Fri, 19 Sep 2025 13:42:57 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] x86/mce: Save and use APEI corrected threshold
 limit
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com>
 <64314c7a-5212-4bf0-8181-8bbada0e81b5@suse.com>
 <20250915173332.GA869676@yaz-khff2.amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250915173332.GA869676@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/15/25 20:33, Yazen Ghannam wrote:
> On Thu, Sep 11, 2025 at 08:01:17PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 9/8/25 18:40, Yazen Ghannam wrote:
>>> The MCA threshold limit generally is not something that needs to change
>>> during runtime. It is common for a system administrator to decide on a
>>> policy for their managed systems.
>>>
>>> If MCA thresholding is OS-managed, then the threshold limit must be set
>>> at every boot. However, many systems allow the user to set a value in
>>> their BIOS. And this is reported through an APEI HEST entry even if
>>> thresholding is not in FW-First mode.
>>>
>>> Use this value, if available, to set the OS-managed threshold limit.
>>> Users can still override it through sysfs if desired for testing or
>>> debug.
>>>
>>> APEI is parsed after MCE is initialized. So reset the thresholding
>>> blocks later to pick up the threshold limit.
>>>
>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>> ---
>>>
>>> Notes:
>>>       Link:
>>>       https://lore.kernel.org/r/20250825-wip-mca-updates-v5-20-865768a2eef8@amd.com
>>>       v5->v6:
>>>       * No change.
>>>       v4->v5:
>>>       * No change.
>>>       v3->v4:
>>>       * New in v4.
>>>
>>>    arch/x86/include/asm/mce.h          |  6 ++++++
>>>    arch/x86/kernel/acpi/apei.c         |  2 ++
>>>    arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
>>>    arch/x86/kernel/cpu/mce/internal.h  |  2 ++
>>>    arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
>>>    5 files changed, 39 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>>> index 7d6588195d56..1cfbfff0be3f 100644
>>> --- a/arch/x86/include/asm/mce.h
>>> +++ b/arch/x86/include/asm/mce.h
>>> @@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
>>>    /* Disable CMCI/polling for MCA bank claimed by firmware */
>>>    extern void mce_disable_bank(int bank);
>>> +#ifdef CONFIG_X86_MCE_THRESHOLD
>>> +void mce_save_apei_thr_limit(u32 thr_limit);
>>> +#else
>>> +static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
>>> +#endif /* CONFIG_X86_MCE_THRESHOLD */
>>> +
>>>    /*
>>>     * Exception handler
>>>     */
>>> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
>>> index 0916f00a992e..e21419e686eb 100644
>>> --- a/arch/x86/kernel/acpi/apei.c
>>> +++ b/arch/x86/kernel/acpi/apei.c
>>> @@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
>>>    	if (!cmc->enabled)
>>>    		return 0;
>>> +	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
>>> +
>>>    	/*
>>>    	 * We expect HEST to provide a list of MC banks that report errors
>>>    	 * in firmware first mode. Otherwise, return non-zero value to
>>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>>> index b895559e80ad..9b746080351f 100644
>>> --- a/arch/x86/kernel/cpu/mce/amd.c
>>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>>> @@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
>>>    	}
>>>    }
>>> +/* Try to use the threshold limit reported through APEI. */
>>> +static u16 get_thr_limit(void)
>>> +{
>>> +	u32 thr_limit = mce_get_apei_thr_limit();
>>> +
>>> +	/* Fallback to old default if APEI limit is not available. */
>>> +	if (!thr_limit)
>>> +		return THRESHOLD_MAX;
>>> +
>>> +	return min(thr_limit, THRESHOLD_MAX);
>>> +}
>>> +
>>>    static void mce_threshold_block_init(struct threshold_block *b, int offset)
>>>    {
>>>    	struct thresh_restart tr = {
>>> @@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
>>>    		.lvt_off		= offset,
>>>    	};
>>> -	b->threshold_limit		= THRESHOLD_MAX;
>>> +	b->threshold_limit		= get_thr_limit();
>>>    	threshold_restart_block(&tr);
>>>    };
>>> @@ -1071,7 +1083,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
>>>    	b->address		= address;
>>>    	b->interrupt_enable	= 0;
>>>    	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
>>> -	b->threshold_limit	= THRESHOLD_MAX;
>>> +	b->threshold_limit	= get_thr_limit();
>>>    	if (b->interrupt_capable) {
>>>    		default_attrs[2] = &interrupt_enable.attr;
>>> @@ -1082,6 +1094,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
>>>    	list_add(&b->miscj, &tb->miscj);
>>> +	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
>>
>> Why is this necessary? Shouldn't this patch consist of mainly
>> s/THRESHOLD_MAX/get_thr_limit();
>>
>>
>> In allocate_threshold_block have already properly set threshold_limit. So
>> this change really ensures threshold_restart_block is being called for the
>> given block being initialized. Ignoring the changed threshold limit logic,
>> why is this extra call necessary now and wasn't before?
>>
> 
> It is necessary to apply the threshold limit to the hardware register.
> The MCA thresholding registers are accessed in two passes: first during
> per-CPU init, and second when the MCE subsystem devices are created.
> 
> The hardware registers are updated in the first pass, and they are left
> as-is in the second pass assuming no configuration has changed. That's
> why there isn't a "reset" in the second pass.
> 
> The APEI tables are parsed between the first and second passes. So now
> we need to update the registers during the second pass to apply the
> value found from HEST.

So APEI is initialized as part of the subsys_initcall which is processed 
via:

start_kernel
rest_init
kernel_init
kernel_init_freeable
do_basic_setup
do_initcalls

And the first mce_threshold_block_init() happens from :

start_kernel
arch_cpu_finalize_init <---- way before rest_init()
identify_boot_cpu
identify_cpu
mcheck_cpu_init
mcheck_cpu_init_vendor
mce_amd_feature_init
prepare_threshold_block
mce_threshold_block_init


Finally the per-cpu hotplug callback is installed via:

mcheck_init_device <- initiated from a device_initcall, happens after 
APEI subsys init.
mce_cpu_online  - called on every cpu from the HP machinery
mce_threshold_create_device
threshold_create_bank
allocate_threshold_blocks
mce_threshold_block_init - newly added call in alloc block, used to 
update the register with the new limit


Given that mce_cpu_online is already called on every online cpu at the 
time of installation of the callback, and every subsequent cpu that will 
come online I can't help but wonder why do we have to do the mce 
initialization from start_kernel, can't we move the mcheck_cpu_init call 
into mce_cpu_online, or have the latter subsume the former?

Sorry if I'm being too nitpicky, I just want to have proper 
understanding of the subsystem and the various (implicit) requirements 
it has.


At the very least I believe this commit message should at least allude 
to the fact that mce threshold devices have a strict requirement to be 
created after the APEI subsys has been created.


> 
> Thanks,
> Yazen


