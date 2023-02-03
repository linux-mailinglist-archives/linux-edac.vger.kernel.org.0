Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581326893C8
	for <lists+linux-edac@lfdr.de>; Fri,  3 Feb 2023 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBCJbb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 3 Feb 2023 04:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBCJb2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Feb 2023 04:31:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932931F5DC;
        Fri,  3 Feb 2023 01:31:13 -0800 (PST)
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P7Vk24sT9z6J9fr;
        Fri,  3 Feb 2023 17:30:02 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 3 Feb 2023 09:31:11 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2375.034;
 Fri, 3 Feb 2023 09:31:11 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RESEND PATCH V3 2/4] rasdaemon: Add support for the CXL poison
 events
Thread-Topic: [RESEND PATCH V3 2/4] rasdaemon: Add support for the CXL poison
 events
Thread-Index: AQHZNzLN5iUmsHWwIUGecRCDH4ZAy668DlwAgADlB8A=
Date:   Fri, 3 Feb 2023 09:31:11 +0000
Message-ID: <a5df429552ea4c65b680f985daa32c29@huawei.com>
References: <20230202181846.692-1-shiju.jose@huawei.com>
        <20230202181846.692-3-shiju.jose@huawei.com>
 <Y9wR+Kqs1P65ztwT@aschofie-mobl2>
In-Reply-To: <Y9wR+Kqs1P65ztwT@aschofie-mobl2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>-----Original Message-----
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 02 February 2023 19:42
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: mchehab@kernel.org; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RESEND PATCH V3 2/4] rasdaemon: Add support for the CXL poison
>events
>
>On Thu, Feb 02, 2023 at 06:18:44PM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support to log and record the CXL poison events.
>>
>> The corresponding Kernel patches here:
>> https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef
>> 7f08.1674070170.git.alison.schofield@intel.com/
>>
>> Presently RFC draft version for logging, could be extended for the
>> policy based recovery action for the frequent poison events depending
>> on the above kernel patches.
>
>Hi Shiju,
>
>Looks good to me based on the kernel patches you reference above.
>I want to let you know that a v6 is in the works, and will lead to some naming
>changes below - but minor stuff.

Hi Alison,

Thanks for the information. I will make changes according to the v6.
>
>Alison
>

Thanks,
Shiju



