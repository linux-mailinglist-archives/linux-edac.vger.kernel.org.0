Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26E61CA8
	for <lists+linux-edac@lfdr.de>; Mon,  8 Jul 2019 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGHKAZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Jul 2019 06:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:43594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfGHKAY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Jul 2019 06:00:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF6CF360;
        Mon,  8 Jul 2019 03:00:23 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CEA3F246;
        Mon,  8 Jul 2019 03:00:20 -0700 (PDT)
Subject: Re: [PATCH RFC 2/4] arm64: mm: Add RAS extension system register
 check to SEA handling
To:     Tyler Baicar OS <baicar@os.amperecomputing.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-3-git-send-email-baicar@os.amperecomputing.com>
From:   James Morse <james.morse@arm.com>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>,
        "Andrew.Murray@arm.com" <Andrew.Murray@arm.com>
Message-ID: <df262b97-eda2-0556-d6ef-532a0d697131@arm.com>
Date:   Mon, 8 Jul 2019 11:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562086280-5351-3-git-send-email-baicar@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hey Tyler,

On 02/07/2019 17:51, Tyler Baicar OS wrote:
> On systems that support the ARM RAS extension, synchronous external
> abort syndrome information could be captured in the core's RAS extension
> system registers. So, when handling SEAs check the RAS system registers
> for error syndrome information.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 2d11501..76b42ca 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -37,6 +37,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
>  #include <asm/traps.h>
> +#include <asm/ras.h>
>  
>  struct fault_info {
>  	int	(*fn)(unsigned long addr, unsigned int esr,
> @@ -632,6 +633,8 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  
>  	inf = esr_to_fault_info(esr);
>  
> +	arch_arm_ras_report_error();
> +
>  	/*
>  	 * Return value ignored as we rely on signal merging.
>  	 * Future patches will make this more robust.
> 

If we interrupted a preemptible context, do_sea() is preemptible too... This means we
can't know if we're still running on the same CPU as the one that took the external-abort.
(until this series, it hasn't mattered).

Fixing this means cramming something into entry.S's el1_da, as this may unmask interrupts
before calling do_mem_abort(). But its going to be ugly because some of do_mem_abort()s
ESR values need to be preemptible because they sleep, e.g. page-faults calling
handle_mm_fault().
For do_sea(), do_exit() will 'fix' the preempt count if we kill the thread, but if we
don't, it still needs to be balanced. Doing all this in assembly is going to be unreadable!

Mark Rutland has a series to move the entry assembly into C [0]. Based on that that it
should be possible for the new el1_abort() to spot a Synchronous-External-Abort ESR, and
wrap the do_mem_abort() with preempt enable/disable, before inheriting the flags. (which
for synchronous exceptions, I think we should always do)


Thanks,

James

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm
