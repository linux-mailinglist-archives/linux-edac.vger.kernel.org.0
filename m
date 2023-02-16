Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1C69966A
	for <lists+linux-edac@lfdr.de>; Thu, 16 Feb 2023 14:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBPNz0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Feb 2023 08:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBPNzX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Feb 2023 08:55:23 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8543B21B;
        Thu, 16 Feb 2023 05:55:22 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSejD-0006gg-DY; Thu, 16 Feb 2023 14:55:15 +0100
Message-ID: <8c33484b-9a35-11af-b856-22e49b3c31f0@leemhuis.info>
Date:   Thu, 16 Feb 2023 14:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH V2 1/1] rasdaemon: Fix poll() on per_cpu
 trace_pipe_raw blocks indefinitely
Content-Language: en-US, de-DE
To:     Shiju Jose <shiju.jose@huawei.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        tanxiaofei <tanxiaofei@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20230204193345.842-1-shiju.jose@huawei.com>
 <286293b4-5ae6-1348-9d69-7049ef5adf35@leemhuis.info>
 <1e759e44f5e64b4e99096afd9e89b6dc@huawei.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1e759e44f5e64b4e99096afd9e89b6dc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676555722;159f4814;
X-HE-SMSGID: 1pSejD-0006gg-DY
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16.02.23 14:40, Shiju Jose wrote:
> Hello,
> 
>> -----Original Message-----
>> From: Linux regression tracking (Thorsten Leemhuis)
>> <regressions@leemhuis.info>
>> Sent: 16 February 2023 11:48
>> To: rostedt@goodmis.org
>> Cc: mhiramat@kernel.org; linux-kernel@vger.kernel.org; linux-trace-
>> kernel@vger.kernel.org; tanxiaofei <tanxiaofei@huawei.com>; Jonathan
>> Cameron <jonathan.cameron@huawei.com>; Linuxarm
>> <linuxarm@huawei.com>; Linux kernel regressions list
>> <regressions@lists.linux.dev>; Shiju Jose <shiju.jose@huawei.com>;
>> mchehab@kernel.org; linux-edac@vger.kernel.org
>> Subject: Re: [RFC PATCH V2 1/1] rasdaemon: Fix poll() on per_cpu
>> trace_pipe_raw blocks indefinitely
>>
>> Hi, this is your Linux kernel regression tracker.
> 
> Kernel fix patch for this issue is already in the mainline. Please see the commit
> 3e46d910d8acf94e5360126593b68bf4fee4c4a1
> ("tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw")

Great, thx for letting me know.

>> On 04.02.23 20:33, shiju.jose@huawei.com wrote:
>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>
>>> The error events are not received in the rasdaemon since kernel 6.1-rc6.
>>> This issue is firstly detected and reported, when testing the CXL
>>> error events in the rasdaemon.
>>
>> Thanks for working on this. This submission looks stalled, unless I missed
>> something. This is unfortunate, as this afaics is fixing a regression (caused by a
>> commit from Steven). Hence it would be good to get this fixed rather sooner
>> than later. Or is the RFC in the subject the reason why there was no progress? Is
>> it maybe time to remove it?
> 
> I made the pull request for this rasdaemon  patch here,
>  https://github.com/mchehab/rasdaemon/pull/86

Ha, stupid me, I didn't even notice this thread was about a rasdaemon
change (I landed here as the patch description liked to the tracked
regression report). Apologies for mixing this up; I deal with a lot of
regression reports and try to avoid mistakes like this, but they
nevertheless happen. :-/

Ciao, Thorsten
