Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D05FB54C
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2019 17:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfKMQiu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 13 Nov 2019 11:38:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfKMQit (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Nov 2019 11:38:49 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 620F7F6A421BDE46866D;
        Wed, 13 Nov 2019 16:38:46 +0000 (GMT)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Nov 2019 16:38:45 +0000
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 16:38:45 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Wed, 13 Nov 2019 16:38:45 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 0/7] rasdaemon: add fixes, database closure and signal
 handling
Thread-Topic: [PATCH 0/7] rasdaemon: add fixes, database closure and signal
 handling
Thread-Index: AQHVhD+VWTNr2YGQWUSVWVtO2U1NGqeJeMVw
Date:   Wed, 13 Nov 2019 16:38:45 +0000
Message-ID: <3214142033cc4a8d8d050721bdaa8340@huawei.com>
References: <Shiju Jose> <20191016163401.16980-1-shiju.jose@huawei.com>
In-Reply-To: <20191016163401.16980-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro,

Can you please review this patch set?

Thanks,
Shiju

>-----Original Message-----
>From: Shiju Jose
>Sent: 16 October 2019 17:34
>To: mchehab@kernel.org; linux-edac@vger.kernel.org
>Cc: Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: [PATCH 0/7] rasdaemon: add fixes, database closure and signal
>handling
>
>This patch set add
>1. fixes for some memory leaks and file closure.
>2. closure for the sqlite3 database.
>3. signal handling for the cleanup.
>
>Shiju Jose (7):
>  rasdaemon: fix cleanup issues in
>    ras-events.c:read_ras_event_all_cpus()
>  rasdaemon: fix memory leak in ras-events.c:handle_ras_events()
>  rasdaemon: fix missing fclose in
>    ras-events.c:select_tracing_timestamp()
>  rasdaemon: fix memory leak in ras-events.c:add_event_handler()
>  rasdaemon: delete multiple definitions of ARRAY_SIZE
>  rasdaemon: add closure and cleanups for the database
>  rasdaemon: add signal handling for the cleanup
>
> ras-diskerror-handler.c    |   2 -
> ras-events.c               |  88 +++++++++++++++++++++++++++-----
> ras-mce-handler.h          |   3 --
> ras-non-standard-handler.c |  16 ++++++
> ras-non-standard-handler.h |   6 ++-
> ras-record.c               | 123
>+++++++++++++++++++++++++++++++++++++++++++--
> ras-record.h               |   5 ++
> 7 files changed, 222 insertions(+), 21 deletions(-)
>
>--
>2.1.4
>

