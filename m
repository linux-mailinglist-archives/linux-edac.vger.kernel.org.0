Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6765CCACBB
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2019 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfJCR2R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Oct 2019 13:28:17 -0400
Received: from foss.arm.com ([217.140.110.172]:51898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbfJCR2Q (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Oct 2019 13:28:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9425F1000;
        Thu,  3 Oct 2019 10:21:59 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180473F739;
        Thu,  3 Oct 2019 10:21:57 -0700 (PDT)
Subject: Re: [PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "baicar@os.amperecomputing.com" <baicar@os.amperecomputing.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <72f44e4d-a20b-df1c-ddfe-55219e0ed429@arm.com>
 <86258A5CC0A3704780874CF6004BA8A6584C6BA0@lhreml523-mbx.china.huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <baa9760b-248e-e90f-68ed-1f94e128ef29@arm.com>
Date:   Thu, 3 Oct 2019 18:21:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A6584C6BA0@lhreml523-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shiju,

On 22/08/2019 17:56, Shiju Jose wrote:
> James Morse wrote:
>> On 12/08/2019 11:11, Shiju Jose wrote:
>>> Presently kernel does not support reporting the vendor specific HW
>>> errors, in the non-standard format, to the vendor drivers for the recovery.
>>
>> 'non standard' here is probably a little jarring to the casual reader. You're
>> referring to the UEFI spec's "N.2.3 Non-standard Section Body", which refers to
>> any section type published somewhere other than the UEFI spec.

>>> This patch set add this support and also move the existing handler
>>> functions for the standard errors to the new callback method.
>>
>> Could you give an example of where this would be useful? You're adding an API
>> with no caller to justify its existence.

> One such example is handling the local errors occurred in a device controller, such as PCIe.

Could we have the example in the form of patches? (sorry, I wasn't clear)

I don't think its realistic that a PCIe device driver would want to know about errors on
other devices in the system. (SAS-HBA meet the GPU).

PCIe's has AER for handling errors that (may have) occurred on a PCIe link, and this has
its own CPER records.


>> GUIDs should only belong to one driver.

> UEFI spec's N.2.3 Non-standard Section Body mentioned,  "The type (e.g. format) of a
> non-standard section is identified by the GUID populated in the Section Descriptor's
> Section Type field." 
> There is a possibility to define common non-standard error section format

I agree the GUID describes the format of the error record,


> which will
> be used for more than one driver if the error data to be reported is in the same format.
> Then can the same GUID belong to multiple drivers?

... but here we disagree.

CPER has a component/block-diagram view of the system. It describes a Memory error or an
error with a PCIe endpoint. An error record affects one component.

If you wanted to describe an error caused by a failed transaction between a PCIe device
and memory, you would need two of these records, and its guesswork as to what happened
between them.

But the PCIe device has no business poking around in the memory error. Even if it did APEI
would be the wrong place to do this as its not the only caller of memory_failure().


>>> Also the CCIX RAS patches could be move to the proposed callback method.
>>
>> Presumably for any vendor-specific stuff?

> This information was related to the proposal to replace the  number of if(guid_equal(...)) else
> if(guid_equal(...)) checks in the ghes_do_proc() for the existing UEFI spec defined error 
> sections(such as PCIe,  Memory, ARM HW error)

'the standard ones'

> by registering the corresponding handler functions to the proposed notification method.

I really don't like this. Registering a handler for 'memory corruption' would require
walking a list of dynamically allocated pointers. Can there be more than one entry? Can
random drivers block memory_failure() while they allocate more memory to send packets over
USB? What if it loops?

For the standard error sources the kernel needs to run 'the' handler as quickly as
possible, with a minimum of code/memory-access in the meantime. It already takes too long.


Thanks,

James


> The same apply to the CCIX error sections and any other
> error sections defined by the UEFI spec in the future.  


