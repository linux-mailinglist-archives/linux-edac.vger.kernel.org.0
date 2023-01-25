Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7051967B6FC
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jan 2023 17:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjAYQeQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Jan 2023 11:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAYQeP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Jan 2023 11:34:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22652E0CA;
        Wed, 25 Jan 2023 08:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674664449; x=1706200449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wawEQfNX2gaRXTv2GneaEoA/jaFamhbPObYDEvyVBoY=;
  b=g0ZAHMf317jebkLqXfUWMpp/5cVvP2W+UofL7b+32kMj5nSISa0+Pahl
   UCfgrw03jYLuhdn5nP0HiZibcaqko64aihvwViUzxNVhnixR/J5QYgUKr
   NVpqRp4oVGpOq6xEcebNpZ7TNGxSrm018qg/2IUOk6aEXU9yDNfKOv4B7
   86q0HcuP3ZAB9ryU6iyZUvAm+myZUWtQBOUChwhHmE6QSsJTV+56MJMI7
   A6QiWsRmtc+JHM6PEwL7/Yc3p9Kb0wpwSKYfH7RQTS8oWx1hnFJV5G3Mr
   Pk3OEp2kgYujLzsi/nkPQJzdOzOlX4HnvBpJ3U/NTGynOJUxNywNblFMz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="412832341"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="412832341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:34:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="693016463"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="693016463"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.209.145.70]) ([10.209.145.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:34:08 -0800
Message-ID: <97493ce9-cce2-5845-d952-fa696fa2404e@intel.com>
Date:   Wed, 25 Jan 2023 09:34:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH V2 1/4] rasdaemon: Move definition for BIT and BIT_ULL to
 a common file
Content-Language: en-US
To:     shiju.jose@huawei.com, linux-edac@vger.kernel.org,
        linux-cxl@vger.kernel.org, mchehab@kernel.org
Cc:     jonathan.cameron@huawei.com, linuxarm@huawei.com
References: <20230124165733.1452-1-shiju.jose@huawei.com>
 <20230124165733.1452-2-shiju.jose@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230124165733.1452-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 1/24/23 9:57 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Move definition for BIT() and BIT_ULL() to the
> common file ras-record.h
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   ras-non-standard-handler.h | 3 ---
>   ras-record.h               | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
> index 4d9f938..c360eaf 100644
> --- a/ras-non-standard-handler.h
> +++ b/ras-non-standard-handler.h
> @@ -17,9 +17,6 @@
>   #include "ras-events.h"
>   #include <traceevent/event-parse.h>
>   
> -#define BIT(nr)                 (1UL << (nr))
> -#define BIT_ULL(nr)             (1ULL << (nr))
> -
>   struct ras_ns_ev_decoder {
>   	struct ras_ns_ev_decoder *next;
>   	const char *sec_type;
> diff --git a/ras-record.h b/ras-record.h
> index d9f7733..219f10b 100644
> --- a/ras-record.h
> +++ b/ras-record.h
> @@ -25,6 +25,9 @@
>   
>   #define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
>   
> +#define BIT(nr)                 (1UL << (nr))
> +#define BIT_ULL(nr)             (1ULL << (nr))
> +
>   extern long user_hz;
>   
>   struct ras_events;
