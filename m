Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2833A463
	for <lists+linux-edac@lfdr.de>; Sun,  9 Jun 2019 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfFIJGn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 9 Jun 2019 05:06:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34041 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFIJGn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 9 Jun 2019 05:06:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so6922019wmd.1;
        Sun, 09 Jun 2019 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MGbF2zwewFao6V8gYmheCoVkiBGrE6w/oP1aoRraL0s=;
        b=lifjidMxnNUyfeXsVR3ARiInR98xudKHtkgL05VFoeh7+nK4cN0hXa3CCqqav5kOA4
         +Ztx0r5no6QXMVDrqWSYjBIt3y7tX7mrVeQ6CINj500LmkOaDQwBswGMASam7U1k0CLY
         5+QO4NzGxhd1qfgcSqPJOGsb+PHLFad+tNOdm21U8y8lxelMjsVTpSIQ/+wpLlF0l9SW
         zx8FYcVTOi4QXqn38/iLgaa0fw/D2H60YfRrFH+mj3I+nQKXRe0iAN7krjfZNFl6S1cH
         Q/xBJQRlm9hPqth550eZ5S0Jdd6AeDkZyfsalJlQez0vyth5vhAZ3kel0Y1o3WsX4hu1
         TV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MGbF2zwewFao6V8gYmheCoVkiBGrE6w/oP1aoRraL0s=;
        b=iyxVNi8QEq2oZZX2DObTpMdbzvJM3Zu0PfUUvYOxDXoXr3SeoTh9GHXF918RlfLlHG
         B2pnVYJyvVsLZrjuyUCl1Iz5a6Cixh8hGXvDqdjYbshblNeVrvKQUmM2eQ1JHe0H440H
         IV1hgjQ2tO5VAxK8Cbr1pHPOuwqhFGtlZgKlqzVNCUHD7ohx/eGIlAMrxvxu0X17k6f5
         oy+6cv9ODLYttmt3kM7XlX/QsE78OyCRL0tahei/nBJxsT6JM8XvNVTO3kTXSKJLhkj5
         1YG5FMdUAHtdBp1LZ5CfnVR3Exn6QKvFG6TsqPb2UGJOv8bqkiUlRXjJVgquiA7K0A2s
         1lxQ==
X-Gm-Message-State: APjAAAU+phi1T4YtPvF1bFHmDogvrNlBDgfO1FrD1vB2xzFcRuYruzKY
        EQVj5vbUskdpWO07iaXvAPYpqXd8
X-Google-Smtp-Source: APXvYqwRWaVxK5E+E6DAmqsWw2u/AD5MGLLSu4aQWfDF1P8Lu5EM3wkAemLZ6WLTo2YCNjAkqQrTgg==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr2002837wmc.22.1560071200178;
        Sun, 09 Jun 2019 02:06:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w6sm8723440wro.71.2019.06.09.02.06.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 02:06:39 -0700 (PDT)
Date:   Sun, 9 Jun 2019 11:06:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-edac@vger.kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        tglx@linutronix.de
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:ras/core] RAS/CEC: Rename count_threshold to
 action_threshold
Message-ID: <20190609090637.GA26453@gmail.com>
References: <tip-b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


* tip-bot for Borislav Petkov <tipbot@zytor.com> wrote:

> Commit-ID:  b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
> Gitweb:     https://git.kernel.org/tip/b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
> Author:     Borislav Petkov <bp@suse.de>
> AuthorDate: Sat, 20 Apr 2019 21:30:11 +0200
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Sat, 8 Jun 2019 17:38:17 +0200
> 
> RAS/CEC: Rename count_threshold to action_threshold
> 
> ... which is the better, more-fitting name anyway.
> 
> Tony:
>  - make action_threshold u64 due to debugfs accessors expecting u64.
>  - rename the remaining: s/count_threshold/action_threshold/g
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-edac <linux-edac@vger.kernel.org>

JFYI, the SOB chain is a bit messed up here, the proper chain would be:

 Signed-off-by: Borislav Petkov <bp@suse.de>
 Signed-off-by: Tony Luck <tony.luck@intel.com>
 Signed-off-by: Borislav Petkov <bp@suse.de>

This shows that the patch started out as your effort as a developer, then 
Tony enhanced it and passed it to you as maintainer.

See for example this commit for an example:

  7675104990ed ("sched: Implement lockless wake-queues")

Note that this pattern also signals the co-developed portion, so that tag 
can be dropped - but it can be kept too for extra clarity.

Thanks,

	Ingo
