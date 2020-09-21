Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC62F27229E
	for <lists+linux-edac@lfdr.de>; Mon, 21 Sep 2020 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIULgB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Sep 2020 07:36:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgIULgA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Sep 2020 07:36:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C87329B30D6C3AE099E;
        Mon, 21 Sep 2020 19:35:59 +0800 (CST)
Received: from [10.174.179.35] (10.174.179.35) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 19:35:51 +0800
Subject: Re: [RFC PATCH] mce: don't not enable IRQ in wait_for_panic()
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <openipmi-developer@lists.sourceforge.net>
CC:     <tony.luck@intel.com>, <minyard@acm.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <andi@firstfloor.org>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <hidehiro.kawai.ez@hitachi.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>
References: <1600339070-570840-1-git-send-email-wubo40@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <2262c2ee-3272-987a-0bdb-a0ce55a1d43c@huawei.com>
Date:   Mon, 21 Sep 2020 19:35:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1600339070-570840-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.35]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2020/9/17 18:37, Wu Bo wrote:
> In my virtual machine (have 4 cpus), Use mce_inject to inject errors
> into the system. After mce-inject injects an uncorrectable error,
> there is a probability that the virtual machine is not reset immediately,
> but hangs for more than 3000 seconds, and appeared unable to
> handle kernel paging request.
> 
> The analysis reasons are as follows:
> 1) MCE appears on all CPUs, Currently all CPUs are in the NMI interrupt
>     context. cpu0 is the first to seize the opportunity to run panic
>     routines, and panic event should stop the other processors before
>     do ipmi flush_messages(). but cpu1, cpu2 and cpu3 has already
>     in NMI interrupt context, So the Second NMI interrupt(IPI)
>     will not be processed again by cpu1, cpu2 and cpu3.
>     At this time, cpu1,cpu2 and cpu3 did not stopped.
> 
> 2) cpu1, cpu2 and cpu3 are waitting for cpu0 to finish the panic process.
>     if a timeout waiting for other CPUs happened, do wait_for_panic(),
>     the irq is enabled in the wait_for_panic() function.
> 
> 3) ipmi IRQ occurs on the cpu3, and the cpu0 is doing the panic,
>     they have the opportunity to call the smi_event_handler()
>     function concurrently. the ipmi IRQ affects the panic process of cpu0.
> 
>    CPU0                                    CPU3
> 
>     |-nmi_handle do mce_panic               |-nmi_handle do_machine_check
>     |                                       |
>     |-panic()                               |-wait_for_panic()
>     |                                       |
>     |-stop other cpus ---- NMI ------> (Ignore, already in nmi interrupt)
>     |                                       |
>     |-notifier call(ipmi panic_event)       |<-ipmi IRQ occurs
>     |                                       |
>    \|/                                     \|/
> do smi_event_handler()             do smi_event_handler()
> 
> My understanding is that panic() runs with only one operational CPU
> in the system, other CPUs should be stopped, if other CPUs does not stop,
> at least IRQ interrupts should be disabled. The x86 architecture,
> disable IRQ interrupt will not affect IPI when do mce panic,
> because IPI is notified through NMI interrupt. If my analysis
> is not right, please correct me, thanks.
> 
> Steps to reproduce (Have a certain probability):
> 1. # vim /tmp/uncorrected
> CPU 1 BANK 4
> STATUS uncorrected 0xc0
> MCGSTATUS  EIPV MCIP
> ADDR 0x1234
> RIP 0xdeadbabe
> RAISINGCPU 0
> MCGCAP SER CMCI TES 0x6
>   
> 2. # modprobe mce_inject
> 3. # cd /tmp
> 4. # mce-inject uncorrected
> 
Hi,

I tested the 5.9-rc5 version and found that the problem still exists. Is 
there a good solution ?

Best regards,
Wu Bo

