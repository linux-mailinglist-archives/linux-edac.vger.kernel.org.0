Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DA675722
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jan 2023 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjATO3U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Jan 2023 09:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATO3T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Jan 2023 09:29:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37905233D4;
        Fri, 20 Jan 2023 06:28:52 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nz1x46w9Hz688Cb;
        Fri, 20 Jan 2023 22:25:12 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 14:28:16 +0000
Date:   Fri, 20 Jan 2023 14:28:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <shiju.jose@huawei.com>
CC:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 1/4] rasdaemon: Move definition for BIT and BIT_ULL
 to a common file
Message-ID: <20230120142815.00003d8b@huawei.com>
In-Reply-To: <20230119171809.1406-2-shiju.jose@huawei.com>
References: <20230119171809.1406-1-shiju.jose@huawei.com>
        <20230119171809.1406-2-shiju.jose@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 19 Jan 2023 17:18:06 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Move definition for BIT() and BIT_ULL() to the
> common file ras-record.h
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

As you know I've looked at and tested this before you posted it
so I'm happy with it, except mostly places where I think there
is room to improve ras daemon in general ;)

This patch makes sense though I suspect it will one day get moved again
to an even more generic header.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

Thanks

Jonathan


> ---
>  ras-non-standard-handler.h | 3 ---
>  ras-record.h               | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
> index 57d4cb5..393b756 100644
> --- a/ras-non-standard-handler.h
> +++ b/ras-non-standard-handler.h
> @@ -17,9 +17,6 @@
>  #include "ras-events.h"
>  #include "libtrace/event-parse.h"
>  
> -#define BIT(nr)                 (1UL << (nr))
> -#define BIT_ULL(nr)             (1ULL << (nr))
> -
>  struct ras_ns_ev_decoder {
>  	struct ras_ns_ev_decoder *next;
>  	const char *sec_type;
> diff --git a/ras-record.h b/ras-record.h
> index d9f7733..219f10b 100644
> --- a/ras-record.h
> +++ b/ras-record.h
> @@ -25,6 +25,9 @@
>  
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
>  
> +#define BIT(nr)                 (1UL << (nr))
> +#define BIT_ULL(nr)             (1ULL << (nr))
> +
>  extern long user_hz;
>  
>  struct ras_events;

