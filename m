Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6D6C2DCB
	for <lists+linux-edac@lfdr.de>; Tue, 21 Mar 2023 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCUJ0R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 21 Mar 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCUJ0Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Mar 2023 05:26:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523991CAE9
        for <linux-edac@vger.kernel.org>; Tue, 21 Mar 2023 02:26:14 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PgmRt3GkNz6J7P6;
        Tue, 21 Mar 2023 17:25:46 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 09:26:11 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.021;
 Tue, 21 Mar 2023 09:26:11 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        tanxiaofei <tanxiaofei@huawei.com>,
        fenglei <fenglei47@h-partners.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/1] rasdaemon: Fix for regression in
 ras_mc_create_table() if some cpus are offline at the system start
Thread-Topic: [PATCH 1/1] rasdaemon: Fix for regression in
 ras_mc_create_table() if some cpus are offline at the system start
Thread-Index: AQHZVmPPJ39H1ai4fkiTv9Y4giisiq8APIWAgATDsFA=
Date:   Tue, 21 Mar 2023 09:26:11 +0000
Message-ID: <ea2afdc810954b03bf272199fcefd87b@huawei.com>
References: <20230314105725.1184-1-shiju.jose@huawei.com>
 <20230318093553.3e524594@coco.lan>
In-Reply-To: <20230318093553.3e524594@coco.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.149.198]
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

Hi Mauro,

>-----Original Message-----
>From: Mauro Carvalho Chehab <mchehab@kernel.org>
>Sent: 18 March 2023 08:36
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; tanxiaofei <tanxiaofei@huawei.com>; fenglei
><fenglei47@h-partners.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH 1/1] rasdaemon: Fix for regression in
>ras_mc_create_table() if some cpus are offline at the system start
>
>Hi Jose,
>
>Em Tue, 14 Mar 2023 10:57:25 +0000
><shiju.jose@huawei.com> escreveu:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Issues:
>> Regression in the ras_mc_create_table() if some of the cpus are
>> offline at the system start when run the rasdaemon. This issue is
>> reproducible in ras_mc_create_table() with decode and record
>> non-standard events and reproducible sometimes with
>> ras_mc_create_table() for the standard events.
>> Also in the multi thread way, there is memory leak in
>> ras_mc_event_opendb() as struct sqlite3_priv *priv and sqlite3 *db
>> allocated/initialized per thread, but stored in the common struct
>> ras_events ras in pthread data, which is shared across the threads.
>
>Could you please submit rasdaemon patches via github pull requests?
>
>It is currently easier to me to pick patches from there. You can still send then to
>the ML in case you want others to take a look and review them, but I'll be
>applying them only after the PR at rasdaemon.

I  will  submit the pull request in the github.
 
>
>Regards,
>Mauro
>
Thanks,
Shiju
