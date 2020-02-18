Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F4D162A37
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2020 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRQRs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Feb 2020 11:17:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36903 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgBRQRs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Feb 2020 11:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582042667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+q/3SoI7jBB7C//HgS1a1L9BZSk3CwgQSLwvdKG4XQ=;
        b=LnmiuCYl/GAECTZ/XrmEgGXQdJ3ntgtW0QFU0UD6AqxpB2829SiBwFxKyiV6xhJuK4Y6aV
        N/BDSD7ajA+otgjkBtSpmYMhwi54Rw2jr8S5IwodNlO9wdlaBF6/dBQLFmfa8ZI+rB4RdR
        VnbHbszXIuO+q9qcZiqHhi8cegv2JwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-xOFPaiX0M5GJPqZ0kAFCxw-1; Tue, 18 Feb 2020 11:17:39 -0500
X-MC-Unique: xOFPaiX0M5GJPqZ0kAFCxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00FD610C7F22;
        Tue, 18 Feb 2020 16:17:37 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DED3660BE1;
        Tue, 18 Feb 2020 16:17:34 +0000 (UTC)
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
Message-ID: <e1bf1a0e-db70-906f-d09c-90cc2eef28dc@redhat.com>
Date:   Tue, 18 Feb 2020 11:17:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200218161319.GG14449@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
> #ifdef CONFIG_X86_MCE_INTEL place.'

That's weird.  I just re-compiled it on my system without any issue.  Can I have
your .config to double check my compile?  I'm using the standard fedora config FWIW.

P.
> 

