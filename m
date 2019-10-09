Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE4D1356
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfJIP5k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 11:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731559AbfJIP5k (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 11:57:40 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D63758
        for <linux-edac@vger.kernel.org>; Wed,  9 Oct 2019 15:57:40 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so1273521wmk.1
        for <linux-edac@vger.kernel.org>; Wed, 09 Oct 2019 08:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3ptxyyHx0/qzXbUl9U/H+quIFMeBGhW5hUUCE/0MjM=;
        b=bbAOUHUGx0uInej6tq1xQDBl1ctMS2M+1PkxlIffAl2DJJ28PS5fTdS3KzWNiQufm/
         62DkRukK4Rp7gmjELvubixzJ+UJd5ir4hcgi9R6fnaOKVDdFhOtA9iMyiq/AhDixrXi3
         H+FkHvYtfQSD9aUaCN1ENe6TtjUBLnOzyTzOJmGmZAEjm6unmOOpEmFKyNiGLVFSVI68
         ekuHvAYuJGA1Bcwg+v0mKggds3NumYtOsx3YBmShsq/QDK4Dw+qUpjA3FG69kmr+71dA
         FxQXvGXn8gVpWbKNjaFGYe/VpTLzboK7AQvRAgsmWOa3pOj+VGwk1WJtrfpWUiuQsq5Q
         Da7A==
X-Gm-Message-State: APjAAAUQCrw1XTg98XTxtDmUW2QRNqoPrkoO7jyig8jh5p4lS/CcIn+P
        GRGVtSPxAK1gCJJt0ZFGV3E5E+4kmJl2eJeuR48VZREiIEHpUtSgB5Zlz8BFxN6dfeK0FndAwsV
        RbrWFtM64CpUgKaxdnaiUJQ==
X-Received: by 2002:adf:dc8c:: with SMTP id r12mr3468319wrj.107.1570636658572;
        Wed, 09 Oct 2019 08:57:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+wX+0Fvu5SZNmKleHQuTrQYzbUMiEsd1/1OUnhTlZ4mxXcbH5/HWJm+m8uqOx261atg4O6A==
X-Received: by 2002:adf:dc8c:: with SMTP id r12mr3468273wrj.107.1570636658129;
        Wed, 09 Oct 2019 08:57:38 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id a10sm3027406wrm.52.2019.10.09.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:57:37 -0700 (PDT)
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
To:     Benjamin Berg <bberg@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
References: <20191009155424.249277-1-bberg@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dafb0aa8-b1e1-14ac-7345-1a504ac2c441@redhat.com>
Date:   Wed, 9 Oct 2019 17:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191009155424.249277-1-bberg@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 09-10-2019 17:54, Benjamin Berg wrote:
> On modern CPUs it is quite normal that the temperature limits are
> reached and the CPU is throttled. In fact, often the thermal design is
> not sufficient to cool the CPU at full load and limits can quickly be
> reached when a burst in load happens. This will even happen with
> technologies like RAPL limitting the long term power consumption of
> the package.
> 
> So these messages do not usually indicate a hardware issue (e.g.
> insufficient cooling). Log them as warnings to avoid confusion about
> their severity.
> 
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> Tested-by: Christian Kellner <ckellner@redhat.com>

Ah, yes lets please lower the log-prio of these messages:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
> index 6e2becf547c5..bc441d68d060 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event, int event, int level)
>   	/* if we just entered the thermal event */
>   	if (new_event) {
>   		if (event == THERMAL_THROTTLING_EVENT)
> -			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> +			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
>   				this_cpu,
>   				level == CORE_LEVEL ? "Core" : "Package",
>   				state->count);
> 
