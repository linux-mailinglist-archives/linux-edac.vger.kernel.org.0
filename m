Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADE2A9E1F
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgKFTfh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 14:35:37 -0500
Received: from foss.arm.com ([217.140.110.172]:44104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFTfg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Nov 2020 14:35:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133E01474;
        Fri,  6 Nov 2020 11:35:36 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C7A3F718;
        Fri,  6 Nov 2020 11:35:34 -0800 (PST)
Subject: Re: [PATCH] Dump cper error table in mce_panic
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, yangfeng1@kingsoft.com,
        CHENGUOMIN@kingsoft.com, yaoaili@kingsoft.com
References: <20201104065057.40442-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <112d8a04-4f0d-6705-4da1-e8d95a14dbaf@arm.com>
Date:   Fri, 6 Nov 2020 19:35:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201104065057.40442-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello!

On 04/11/2020 06:50, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> For X86_MCE, When there is a fatal ue error, BIOS will prepare one
> detailed cper error table before raising MCE,

(outside GHES-ASSIST), Its not supposed to do this.

There is an example flow described in 18.4.1 "Example: Firmware First Handling Using NMI
Notification" of ACPI v6.3:
https://uefi.org/sites/default/files/resources/ACPI_Spec_6_3_A_Oct_6_2020.pdf


The machine-check is the notification from hardware, which in step 1 of the above should
go to firmware. You should only see an NMI, which is step 8.
Step 7 is to clear the error from hardware, so triggering a machine-check is pointless.
(but I agree no firmware ever follows this!)


You appear to have something that behaves as GHES-ASSIST. Can you post the decompiled dump
of your HEST table? (decompiled, no binaries!) If its large, you can post it to me off
list and I'll copy the relevant bits here...


> this cper table is meant
> to supply addtional error information and not to race with mce handler
> to panic.

This is a description of GHES_ASSIST. See 18.7 "GHES_ASSIST Error Reporting" of the above pdf.


> Usually possible unexpected cper process from NMI watchdog race panic
> with MCE panic is not a problem, the panic process will coordinate with
> each core. But When the CPER is not processed in the first kernel and
> leave it to the second kernel, this is a problem, lead to a kdump fail.

> Now in this patch, the mce_panic will race with unexpected NMI to dump
> the cper error log and get it cleaned, this will prevent the cper table
> leak to the second kernel, which will fix the kdump fail problem, and
> also guarrante the cper log is collected which it's meant to.

> Anyway,For x86_mce platform, the ghes module is still needed not to
> panic for fatal memory UE as it's MCE handler's work.

If and only if those GHES are marked as GHES_ASSIST.

If they are not, then you have a fully fledged firwmare-first system.

Could you share what your system is describing it as in the HEST so we can work out what
is going on here?!

We need to work this out first.


Thanks,

James

