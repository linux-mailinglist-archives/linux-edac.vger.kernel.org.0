Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E8659172
	for <lists+linux-edac@lfdr.de>; Thu, 29 Dec 2022 21:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiL2USB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Dec 2022 15:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiL2USB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Dec 2022 15:18:01 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1E140F1;
        Thu, 29 Dec 2022 12:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672345080; x=1703881080;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=PQ848iD1ustBfk9pOIqJVV9lQblCt84oT36k4PUVOrA=;
  b=Au+746kU/mS5E9ViAuzzn4M6g4JvgJKa1NEknqwj7SfStVN/ddXMabrA
   l4BL5gNkhWQzKnvSYtkHXHemE5CTRKLyWeMi+G6MiFODLvd2gNKTqV4m2
   JjcfzUNj2YISHyffS4Ye5SbhRsjqmflCD3XEYMkNBq6DJq3EiZUX/875A
   U=;
X-IronPort-AV: E=Sophos;i="5.96,285,1665446400"; 
   d="scan'208";a="166268760"
Subject: Re: [PATCH v2] edac: fix period calculation in
 edac_device_reset_delay_period()
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 20:17:57 +0000
Received: from EX13D28EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id B4C2143387;
        Thu, 29 Dec 2022 20:17:53 +0000 (UTC)
Received: from EX19D034EUC002.ant.amazon.com (10.252.61.195) by
 EX13D28EUC002.ant.amazon.com (10.43.164.254) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 29 Dec 2022 20:17:52 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D034EUC002.ant.amazon.com (10.252.61.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.20; Thu, 29 Dec 2022 20:17:52 +0000
Received: from [192.168.167.129] (10.85.143.176) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 29 Dec 2022 20:17:48 +0000
Message-ID: <aebd2f07-674c-b848-69e7-5479d111bad1@amazon.com>
Date:   Thu, 29 Dec 2022 22:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <hanochu@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <amitlavi@amazon.com>,
        <dkl@amazon.com>
References: <20221020124458.22153-1-farbere@amazon.com>
 <Y62xA548/wQAggRL@zn.tnic>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Y62xA548/wQAggRL@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12/29/2022 5:23 PM, Borislav Petkov wrote:
> On Thu, Oct 20, 2022 at 12:44:58PM +0000, Eliav Farber wrote:
>> Fix period calculation in case user sets a value of 1000.
>> The input of round_jiffies_relative() should be in jiffies and not in
>> milli-seconds.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>
> Fixes: c4cf3b454eca ("EDAC: Rework workqueue handling")
>
> I guess.
>
> Also, I think the one-liner below does the same, no?

The one-liner below will not work.
See the comment in edac_device_workq_setup() that explains why round
is used:
"
optimize here for the 1 second case, which will be normal value, to
fire ON the 1 second time event. This helps reduce all sorts of
timers firing on sub-second basis, while they are happy
to fire together on the 1 second exactly
"
So only the first schedule should be rounded.
But all other schedules after that should be 1000ms.
When rounding jiffs and saving it in edac_dev->delay it means that all
future schedules will not be with the correct delay.

The fix I suggested is the same logic used in:
  - edac_device_workq_setup()
  - edac_device_workq_function()

--
Regards, Eliav


> ---
>
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 19522c568aa5..88942a6edc2c 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -399,7 +399,7 @@ void edac_device_reset_delay_period(struct 
> edac_device_ctl_info *edac_dev,
>        unsigned long jiffs = msecs_to_jiffies(value);
>
>        if (value == 1000)
> -               jiffs = round_jiffies_relative(value);
> +               jiffs = round_jiffies_relative(jiffs);
>
>        edac_dev->poll_msec = value;
>        edac_dev->delay     = jiffs;
>
> -- 
> Regards/Gruss,
>    Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
