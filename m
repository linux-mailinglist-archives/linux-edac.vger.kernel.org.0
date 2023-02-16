Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4809F699676
	for <lists+linux-edac@lfdr.de>; Thu, 16 Feb 2023 14:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPN7I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Feb 2023 08:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBPN7G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Feb 2023 08:59:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37A3C78C;
        Thu, 16 Feb 2023 05:59:05 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSemu-0007RO-1L; Thu, 16 Feb 2023 14:59:04 +0100
Message-ID: <43fadb7f-cdc0-eb4b-7d3e-6b754a5cc77a@leemhuis.info>
Date:   Thu, 16 Feb 2023 14:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [bug-report] rasdaemon doesnot report new records.
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com>
 <1a78baae-eb78-5add-13b3-9526082160d9@leemhuis.info>
In-Reply-To: <1a78baae-eb78-5add-13b3-9526082160d9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676555945;4ca6869e;
X-HE-SMSGID: 1pSemu-0007RO-1L
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 30.01.23 12:57, Linux kernel regression tracking (#adding) wrote:
> On 30.01.23 10:34, Harshit Mogalapalli wrote:
>>
>> Since kernel 6.1-rc6 rasdaemon fails to update the summary of the records.
>>
>> When we inject MCE errors, generally ras-mc-ctl --summary should be able
>> to read new errors, but starting from 6.1-rc6 the summary(count on
>> number of MCE records) doesnot udpate when we inject new mce errors.
>>
>> This started happening after this commit
>> 42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
>> polling block on watermark") -- Commit landed first in 6.1-rc6, 6.1-rc5
>> kernel doesnot have this problem.
>>
>> On reverting this commit, rasdaemon works good(i.e It is able to read
>> the new mce records).
>>
>> This continues to happen on latest kernel(v6.2-rc6) as well.
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 42fb0a1e84ff525
> #regzbot title tracing/ring-buffer: rasdaemon does not report new records
> #regzbot ignore-activity

For the record, I in
https://lore.kernel.org/lkml/1e759e44f5e64b4e99096afd9e89b6dc@huawei.com/
was told that the mainline commit 3e46d910d8ac ("tracing: Fix poll() and
select() do not work on per_cpu trace_pipe and trace_pipe_raw") fixes
this on the kernel side. There apparently is a rasdaemon change to
improve things, too.

#regzbot fix: 3e46d910d8ac

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
