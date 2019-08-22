Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22F999A7
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbfHVQ5S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 22 Aug 2019 12:57:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390198AbfHVQ5S (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 12:57:18 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9398412634E070F8825B;
        Thu, 22 Aug 2019 17:57:16 +0100 (IST)
Received: from LHREML523-MBX.china.huawei.com ([169.254.7.10]) by
 LHREML710-CAH.china.huawei.com ([10.201.108.33]) with mapi id 14.03.0415.000;
 Thu, 22 Aug 2019 17:56:56 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
Subject: RE: [PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHVUPaLJkVPMew7R0uzXOUXh4tDRKcF11kAgAEaSNA=
Date:   Thu, 22 Aug 2019 16:56:55 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A6584C6BA0@lhreml523-mbx.china.huawei.com>
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <72f44e4d-a20b-df1c-ddfe-55219e0ed429@arm.com>
In-Reply-To: <72f44e4d-a20b-df1c-ddfe-55219e0ed429@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.93.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James, 

Thanks for the feedback.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of James Morse
>Sent: 21 August 2019 18:23
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org;
>tony.luck@intel.com; bp@alien8.de; baicar@os.amperecomputing.com;
>Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
>Subject: Re: [PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor
>specific HW errors
>
>Hi,
>
>On 12/08/2019 11:11, Shiju Jose wrote:
>> Presently kernel does not support reporting the vendor specific HW
>> errors, in the non-standard format, to the vendor drivers for the recovery.
>
>'non standard' here is probably a little jarring to the casual reader. You're
>referring to the UEFI spec's "N.2.3 Non-standard Section Body", which refers to
>any section type published somewhere other than the UEFI spec.
OK. I will change it.  
>
>These still have to have a GUID to identify them, so they still have the same
>section header format.
Yes. 
 
>
>
>> This patch set add this support and also move the existing handler
>> functions for the standard errors to the new callback method.
>
>Could you give an example of where this would be useful? You're adding an API
>with no caller to justify its existence.
One such example is handling the local errors occurred in a device controller, such as PCIe.

>
>
>GUIDs should only belong to one driver.
UEFI spec's N.2.3 Non-standard Section Body mentioned,  "The type (e.g. format) of a non-standard section is identified by the GUID populated in the Section Descriptor's Section Type field." 
There is a possibility to define common non-standard error section format which will be used for more than one driver if the error data to be reported is in the same format. Then can the same GUID belong to multiple drivers?

>
>I don't think we should call drivers for something described as a fatal error.
>(which is the case with what you have here)
The notification is intended only for the recoverable errors as the ghes_proc() call panic for the fatal errors in the early stage.

>
>
>> Also the CCIX RAS patches could be move to the proposed callback method.
>
>Presumably for any vendor-specific stuff?
This information was related to the proposal to replace the  number of if(guid_equal(...)) else if(guid_equal(...)) checks in the ghes_do_proc() for the existing UEFI spec defined error sections(such as PCIe,  Memory, ARM HW error) by registering the corresponding handler functions to the proposed notification method. The same apply to the CCIX error sections and any other error sections defined by the UEFI spec in the future.  

>
>
>Thanks,
>
>James

Thanks,
Shiju
