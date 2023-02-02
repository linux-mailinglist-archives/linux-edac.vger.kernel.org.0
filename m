Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D46888E3
	for <lists+linux-edac@lfdr.de>; Thu,  2 Feb 2023 22:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBBVSm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Feb 2023 16:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjBBVSi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Feb 2023 16:18:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC36EADA;
        Thu,  2 Feb 2023 13:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADF46B82877;
        Thu,  2 Feb 2023 21:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8058EC433D2;
        Thu,  2 Feb 2023 21:18:33 +0000 (UTC)
Date:   Thu, 2 Feb 2023 16:18:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <shiju.jose@huawei.com>
Cc:     <mhiramat@kernel.org>, <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>
Subject: Re: [RFC PATCH 1/1] tracing: Fix poll() and select() do not work on
 per_cpu trace_pipe and trace_pipe_raw
Message-ID: <20230202161831.6a4fca2a@rorschach.local.home>
In-Reply-To: <20230202182309.742-2-shiju.jose@huawei.com>
References: <20230202182309.742-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2 Feb 2023 18:23:09 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> poll() and select() on per_cpu trace_pipe and trace_pipe_raw do not work
> since kernel 6.1-rc6. This issue is seen after the commit
> 42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
> polling block on watermark").
> 
> This issue is firstly detected and reported, when testing the CXL error
> events in the rasdaemon and also erified using the test application for poll()
> and select().
> 
> This issue occurs for the per_cpu case, when calling the ring_buffer_poll_wait(),
> in kernel/trace/ring_buffer.c, with the buffer_percent > 0 and then wait until the
> percentage of pages are available. The default value set for the buffer_percent is 50
> in the kernel/trace/trace.c.
> 
> As a fix, allow userspace application could set buffer_percent as 0 through
> the buffer_percent_fops, so that the task will wake up as soon as data is added
> to any of the specific cpu buffer.
> 
> Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

This makes sense to me. I'm going to run a bunch of tests on this and
see if anything else breaks.

Thanks!

-- Steve


>  kernel/trace/trace.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a555a861b978..01164c78483a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9148,9 +9148,6 @@ buffer_percent_write(struct file *filp, const char __user *ubuf,
>  	if (val > 100)
>  		return -EINVAL;
>  
> -	if (!val)
> -		val = 1;
> -
>  	tr->buffer_percent = val;
>  
>  	(*ppos)++;

