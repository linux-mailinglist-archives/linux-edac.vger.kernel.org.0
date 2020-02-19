Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF338164426
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2020 13:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBSM0M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Feb 2020 07:26:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726530AbgBSM0M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Feb 2020 07:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582115170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU/Kb9yyQfFq/B4zFRzH8ISmhlDlgLRWQwirtVr5slw=;
        b=Jelrroctzu8vHohLrnIAeEwVryxtJuA1eVOeBkp+u2p35NnVtt0CJ/NAjodzJy3mzzUEY5
        1jusNmDPk4unvtlQ2y7sGcbEmfiR0l/H4wYy60grN3RaXY4bzv1WowiYu4P2Zz+DsGQH6k
        bogWkhOr9PbZr6oPL/0DYV2ic7d8DHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-b9pysub7Opy2xssPrJfx3Q-1; Wed, 19 Feb 2020 07:26:03 -0500
X-MC-Unique: b9pysub7Opy2xssPrJfx3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A18A5107ACC5;
        Wed, 19 Feb 2020 12:26:01 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5767C5C112;
        Wed, 19 Feb 2020 12:26:00 +0000 (UTC)
Subject: Re: [PATCH v2] x86/mce: Do not log spurious corrected mce errors
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
References: <20200217130659.15895-1-prarit@redhat.com>
 <20200218161319.GG14449@zn.tnic>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <894a39cb-21e7-3e43-1907-cae390537ccf@redhat.com>
Date:   Wed, 19 Feb 2020 07:25:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200218161319.GG14449@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/18/20 11:13 AM, Borislav Petkov wrote:
> On Mon, Feb 17, 2020 at 08:06:59AM -0500, Prarit Bhargava wrote:
>> A user has reported that they are seeing spurious corrected errors on
>> their hardware.
>>
>> Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
>> "spurious corrected errors may be logged in the IA32_MC0_STATUS register
>> with the valid field (bit 63) set, the uncorrected error field (bit 61)
>> not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
>> an MCA Error Code (bits [15:0]) of 0x0005."
>>
>> Block these spurious errors from the console and logs.
>>
>> Links to Intel Specification updates:
>> HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-desktop-specification-update.html
>> HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-mobile-specification-update.html
>> HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v3-spec-update.html
>> BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/core/5th-gen-core-family-spec-update.html
> 
> My previous review comment still holds:
> 
> Those links tend to get stale with time. If you really want to refer to
> the PDFs, add a new bugzilla entry on https://bugzilla.kernel.org/, add
> them there as an attachment and add the link to the entry to the commit
> message.
> 
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
> 
> WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
> #36:

Borislav, when I've been using your Co-developed-by & not using a Signed-off-by
process but when I run checkpatch.py I get the following warning:

WARNING: Co-developed-by and Signed-off-by: name/email do not match
#21:
Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>

When I submitted this patch I looked at other commits in the kernel near
top-of-tree and they have Signed-off-by followed by Co-developed-by, and also
took your suggestion of not using a Signed-off-by for Alexander.  That's why I
chose to display them this way in v2.

Examples:

126196100063 ("lib/zlib: add s390 hardware support for kernel zlib_inflate")
40ca1bf580ef ("PCI: brcmstb: Add MSI support")

I'm now thoroughly confused as to what the correct format is.  It seems like
checkpatch.py is telling me to include a Signed-off-by in addition to the
Co-developed-by for Alexander but you explicitly told me not to.

P.

> 
> See Documentation/process/submitting-patches.rst for more detail.
> 
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: linux-edac@vger.kernel.org
>> ---
>>  arch/x86/kernel/cpu/mce/core.c     |  2 ++
>>  arch/x86/kernel/cpu/mce/intel.c    | 17 +++++++++++++++++
>>  arch/x86/kernel/cpu/mce/internal.h |  1 +
>>  3 files changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 2c4f949611e4..fe3983d551cc 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1877,6 +1877,8 @@ bool filter_mce(struct mce *m)
>>  {
>>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>>  		return amd_filter_mce(m);
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		return intel_filter_mce(m);
>>  
>>  	return false;
>>  }
>> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
>> index 5627b1091b85..989148e6746c 100644
>> --- a/arch/x86/kernel/cpu/mce/intel.c
>> +++ b/arch/x86/kernel/cpu/mce/intel.c
>> @@ -520,3 +520,20 @@ void mce_intel_feature_clear(struct cpuinfo_x86 *c)
>>  {
>>  	intel_clear_lmce();
>>  }
>> +
>> +bool intel_filter_mce(struct mce *m)
>> +{
>> +	struct cpuinfo_x86 *c = &boot_cpu_data;
>> +
>> +	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
>> +	if ((c->x86 == 6) &&
>> +	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
>> +	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
>> +	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
>> +	     (c->x86_model == INTEL_FAM6_HASWELL_G)) &&
>> +	    (m->bank == 0) &&
>> +	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
>> +		return true;
>> +
>> +	return false;
>> +}
>> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
>> index b785c0d0b590..821faba5b05d 100644
>> --- a/arch/x86/kernel/cpu/mce/internal.h
>> +++ b/arch/x86/kernel/cpu/mce/internal.h
>> @@ -175,5 +175,6 @@ extern bool amd_filter_mce(struct mce *m);
>>  #else
>>  static inline bool amd_filter_mce(struct mce *m)			{ return false; };
>>  #endif
>> +extern bool intel_filter_mce(struct mce *m);
> 
> It doesn't even build:
> 
> ld: arch/x86/kernel/cpu/mce/core.o: in function `filter_mce':
> /home/boris/kernel/linux/arch/x86/kernel/cpu/mce/core.c:1881: undefined reference to `intel_filter_mce'
> make: *** [Makefile:1077: vmlinux] Error 1
> 
> Hint: do it like it is done for amd_filter_mce() but in the respective
> #ifdef CONFIG_X86_MCE_INTEL place.
> 

