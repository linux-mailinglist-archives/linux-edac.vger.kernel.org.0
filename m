Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7254A999A1
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbfHVQ5O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 22 Aug 2019 12:57:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfHVQ5O (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 12:57:14 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id BCD5FCFD583CE7066BF8;
        Thu, 22 Aug 2019 17:57:11 +0100 (IST)
Received: from LHREML523-MBX.china.huawei.com ([169.254.7.10]) by
 LHREML713-CAH.china.huawei.com ([10.201.108.36]) with mapi id 14.03.0415.000;
 Thu, 22 Aug 2019 17:57:05 +0100
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
Subject: RE: [PATCH RFC 2/4] ACPI: APEI: Add ghes_handle_memory_failure to
 the new notification method
Thread-Topic: [PATCH RFC 2/4] ACPI: APEI: Add ghes_handle_memory_failure to
 the new notification method
Thread-Index: AQHVUPaFGfpBQkFdekWj0CRbk5VWqqcF13eAgAE2pSA=
Date:   Thu, 22 Aug 2019 16:57:04 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A6584C7BAF@lhreml523-mbx.china.huawei.com>
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <20190812101149.26036-3-shiju.jose@huawei.com>
 <12b3ccff-0cda-0467-a9ba-0682be6f333e@arm.com>
In-Reply-To: <12b3ccff-0cda-0467-a9ba-0682be6f333e@arm.com>
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

>-----Original Message-----
>From: James Morse [mailto:james.morse@arm.com]
>Sent: 21 August 2019 18:23
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org;
>tony.luck@intel.com; bp@alien8.de; baicar@os.amperecomputing.com;
>Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
>Subject: Re: [PATCH RFC 2/4] ACPI: APEI: Add ghes_handle_memory_failure to
>the new notification method
>
>Hi,
>
>On 12/08/2019 11:11, Shiju Jose wrote:
>> This patch adds ghes_handle_memory_failure to the new error
>> notification method.
>
>The commit message doesn't answer the question: why?
>
>The existing code works. This just looks like additional churn.
>Given a user, I think the vendor specific example is useful. I don't think making
>this thing more pluggable is a good idea.
This was intended to replace the  number of if(guid_equal(...)) else if(guid_equal(...)) checks in the ghes_do_proc() , which would grow when new UEFI defined error sections would be added in the future.
>
>
>Thanks,
>
>James

Thanks,
Shiju
