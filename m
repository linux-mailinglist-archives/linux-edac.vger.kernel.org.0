Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1832680CA2
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jan 2023 12:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjA3L5f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Jan 2023 06:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjA3L5d (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Jan 2023 06:57:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D211350C;
        Mon, 30 Jan 2023 03:57:18 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMSmh-00044Y-Gc; Mon, 30 Jan 2023 12:57:15 +0100
Message-ID: <1a78baae-eb78-5add-13b3-9526082160d9@leemhuis.info>
Date:   Mon, 30 Jan 2023 12:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug-report] rasdaemon doesnot report new records.
Content-Language: en-US, de-DE
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     William ROCHE <william.roche@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>, rostedt@goodmis.org,
        LKML <linux-kernel@vger.kernel.org>,
        "harshit.m.mogalapalli@gmail.com" <harshit.m.mogalapalli@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675079838;0605a8db;
X-HE-SMSGID: 1pMSmh-00044Y-Gc
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 30.01.23 10:34, Harshit Mogalapalli wrote:
> Hi,
> 
> Since kernel 6.1-rc6 rasdaemon fails to update the summary of the records.
> 
> When we inject MCE errors, generally ras-mc-ctl --summary should be able
> to read new errors, but starting from 6.1-rc6 the summary(count on
> number of MCE records) doesnot udpate when we inject new mce errors.
> 
> This started happening after this commit
> 42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
> polling block on watermark") -- Commit landed first in 6.1-rc6, 6.1-rc5
> kernel doesnot have this problem.
> 
> On reverting this commit, rasdaemon works good(i.e It is able to read
> the new mce records).
>
> This continues to happen on latest kernel(v6.2-rc6) as well.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 42fb0a1e84ff525
#regzbot title tracing/ring-buffer: rasdaemon does not report new records
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> In a Good case -- 6.2-rc6 + revert of 42fb0a1e84ff
> ("tracing/ring-buffer: Have polling block on watermark"), post poll read
> happens without being stuck.
> 
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu0/trace_pipe_raw", O_RDONLY) = 4
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu1/trace_pipe_raw", O_RDONLY) = 5
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu2/trace_pipe_raw", O_RDONLY) = 6
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu3/trace_pipe_raw", O_RDONLY) = 7
> [...]
> poll([{fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6,
> events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 5, -1) =
> 1 ([{fd=4, revents=POLLIN}])
> read(4,
> "\215~\0\0\0\0\0\0t\0\0\0\0\0\0\0\34\t\2\0\263\0\0\0#\0\0\0\n\1\0\t"...,
> 4096) = 4096
> newfstatat(AT_FDCWD, "/etc/localtime", {st_mode=S_IFREG|0644,
> st_size=114, ...}, 0) = 0
> write(2, "rasdaemon: ", 11rasdaemon: )             = 11
> write(2, "mce_record store: 0x56047b270008"..., 33mce_record store:
> 0x56047b270008
> ) = 33
> 
> 
> In a case where new records are not updated in summary: -- 6.2-rc6
> The reason why the database of records isn't populated, is simply
> because rasdaemon doesn't get notified anymore by the kernel:
> 
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu0/trace_pipe_raw", O_RDONLY) = 4
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu1/trace_pipe_raw", O_RDONLY) = 5
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu2/trace_pipe_raw", O_RDONLY) = 6
> openat(AT_FDCWD,
> "/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/cpu3/trace_pipe_raw", O_RDONLY) = 7
> [...]
> poll([{fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=6,
> events=POLLIN}, {fd=7, events=POLLIN}, {fd=8, events=POLLIN}], 5, -1
> 
> --- Stuck here even when we inject MCE-errors.
> 
> 
> Before the Commit 42fb0a1e84ff ("tracing/ring-buffer: Have polling block
> on watermark"), an error injection could wake the poll() call on the
> above special files, and I can confirm that the subsequent read() call
> did not hang. With the Commit 42fb0a1e84ff, an error injection doesn't
> wake the poll() call anymore.
> 
> We need to let rasdaemon (or any other trace consumer using the per_cpu
> files) retrieve the available information as soon as it is available.
> 
> Additional info:
> 1.
> https://github.com/mchehab/rasdaemon/blob/master/ras-events.c#:~:text=ready%20%3D%20poll(fds%2C%20(n_cpus%20%2B%201)%2C%20%2D1)%3B this is the code which is getting hit on rasdaemon side.
> 
> 2. Changing the buffer_percent to a lower value didnot change the
> behaviour.
> 
> 
> Thanks,
> Harshit
> 
> 
> 
> 
> 
