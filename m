Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583AD699388
	for <lists+linux-edac@lfdr.de>; Thu, 16 Feb 2023 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBPLrm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Feb 2023 06:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBPLrl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Feb 2023 06:47:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01675593;
        Thu, 16 Feb 2023 03:47:39 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pScjg-0000CY-Ra; Thu, 16 Feb 2023 12:47:36 +0100
Message-ID: <286293b4-5ae6-1348-9d69-7049ef5adf35@leemhuis.info>
Date:   Thu, 16 Feb 2023 12:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [RFC PATCH V2 1/1] rasdaemon: Fix poll() on per_cpu
 trace_pipe_raw blocks indefinitely
Content-Language: en-US, de-DE
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, tanxiaofei@huawei.com,
        jonathan.cameron@huawei.com, linuxarm@huawei.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        shiju.jose@huawei.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org
References: <20230204193345.842-1-shiju.jose@huawei.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230204193345.842-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676548059;509d3c9d;
X-HE-SMSGID: 1pScjg-0000CY-Ra
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 04.02.23 20:33, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> The error events are not received in the rasdaemon since kernel 6.1-rc6.
> This issue is firstly detected and reported, when testing the CXL error
> events in the rasdaemon.

Thanks for working on this. This submission looks stalled, unless I
missed something. This is unfortunate, as this afaics is fixing a
regression (caused by a commit from Steven). Hence it would be good to
get this fixed rather sooner than later. Or is the RFC in the subject
the reason why there was no progress? Is it maybe time to remove it?

> Debugging showed, poll() on trace_pipe_raw in the ras-events.c do not
> return and this issue is seen after the commit
> 42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
> polling block on watermark").
> 
> This also verified using a test application for poll()
> and select() on trace_pipe_raw.
> 
> There is also a bug reported on this issue,
> https://lore.kernel.org/all/31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com/




> This issue occurs for the per_cpu case, which calls the
> ring_buffer_poll_wait(), in kernel/trace/ring_buffer.c, with the
> buffer_percent > 0 and then wait until the percentage of pages are
> available.The default value set for the buffer_percent is 50 in the
> kernel/trace/trace.c. However poll() does not return even met the percentage
> of pages condition.
> 
> As a fix, rasdaemon set buffer_percent as 0 through the
> /sys/kernel/debug/tracing/instances/rasdaemon/buffer_percent, then the
> task will wake up as soon as data is added to any of the specific cpu
> buffer and poll() on per_cpu/cpuX/trace_pipe_raw does not block
> indefinitely.
> 
> Dependency on the kernel RFC patch
> tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw

BTW, this patch afaics should have these tags:

Fixes: 42fb0a1e84ff ("tracing/ring-buffer: Have polling block on watermark")
Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Link:
https://lore.kernel.org/r/31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com/

An likely a

Cc: <stable@vger.kernel.org> # 6.1.x

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
#regzbot ^backmonitor:
https://lore.kernel.org/r/31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com/

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> 
> Changes:
> RFC V1 -> RFC V2
> 1. Rename the patch header subject.
> 2. Changes for the backward compatability to the old kernels.
> ---
>  ras-events.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/ras-events.c b/ras-events.c
> index 3691311..e505a0e 100644
> --- a/ras-events.c
> +++ b/ras-events.c
> @@ -383,6 +383,8 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
>  	int warnonce[n_cpus];
>  	char pipe_raw[PATH_MAX];
>  	int legacy_kernel = 0;
> +	int fd;
> +	char buf[10];
>  #if 0
>  	int need_sleep = 0;
>  #endif
> @@ -402,6 +404,26 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
>  		return -ENOMEM;
>  	}
>  
> +	/* Fix for poll() on the per_cpu trace_pipe and trace_pipe_raw blocks
> +	 * indefinitely with the default buffer_percent in the kernel trace system,
> +	 * which is introduced by the following change in the kernel.
> +	 * https://lore.kernel.org/all/20221020231427.41be3f26@gandalf.local.home/T/#u.
> +	 * Set buffer_percent to 0 so that poll() will return immediately
> +	 * when the trace data is available in the ras per_cpu trace pipe_raw
> +	 */
> +	fd = open_trace(pdata[0].ras, "buffer_percent", O_WRONLY);
> +	if (fd >= 0) {
> +		/* For the backward compatabilty to the old kernel, do not return
> +		 * if fail to set the buffer_percent.
> +		 */
> +		snprintf(buf, sizeof(buf), "0");
> +		size = write(fd, buf, strlen(buf));
> +		if (size <= 0)
> +			log(TERM, LOG_WARNING, "can't write to buffer_percent\n");
> +		close(fd);
> +	} else
> +		log(TERM, LOG_WARNING, "Can't open buffer_percent\n");
> +
>  	for (i = 0; i < (n_cpus + 1); i++)
>  		fds[i].fd = -1;
>  
