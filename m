Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7ED54E5
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2019 09:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfJMHfM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Oct 2019 03:35:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbfJMHfM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 13 Oct 2019 03:35:12 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D0383B72D
        for <linux-edac@vger.kernel.org>; Sun, 13 Oct 2019 07:35:12 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id l5so8381736edr.10
        for <linux-edac@vger.kernel.org>; Sun, 13 Oct 2019 00:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nhMwoFA/Zdj7REX7JZ9vKBwgACObI42dK519n+ylCo=;
        b=uFTukT2EiDn1H2xk59/90JvVj2PqrknZNZ3ISV30b7gM4CxHZgP/0nvVsmAR/VovgY
         Rp6QoItqkB7HyGSIgweEPuFGosdJ/aHAYE1oLb/pWXs8LPhtPs1CdyzA2E1enxPErZjr
         fXTSSIr45OTuEGYS5pZl71/yi2jwmvlWa5qCIkGLVYpIW8hX9r2UKQKRjxWtXVtEhJe3
         XSfGA0jEIBJm6JXlY7HnGSNhT2dgT9pDHsi7c70ae2LN0ccsL9jQ2YUzxApnvebLIOvw
         MbtTsXVV7UsKliq7W79YHsBA8btiEdmQnUva5uVhE1jT5cSWxRA9Mygl9PEm6e4w6AFP
         4LrA==
X-Gm-Message-State: APjAAAXx5tImALm4795tQKBVJYtkh3h5+2XhVCsdz7TgsoHLQqSEUtvB
        6dBfbauHQQ08cPhxGNUH0VUOUQFAZKPMvV6s6FS1C9ekL6sGke/h8YoAxqPC4nrfoJzrx6fR1KH
        Is2c1cSoHQsRwhyqlzvMMlQ==
X-Received: by 2002:aa7:c6cf:: with SMTP id b15mr22102435eds.215.1570952110652;
        Sun, 13 Oct 2019 00:35:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaaWc1RW2fUkJ93Cyh8P72IOM0zreeQVqZTdbNARbLtHBJmDsAswhMB+6rig1it3UkM/KPyQ==
X-Received: by 2002:aa7:c6cf:: with SMTP id b15mr22102421eds.215.1570952110454;
        Sun, 13 Oct 2019 00:35:10 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id f36sm2471710ede.28.2019.10.13.00.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 00:35:09 -0700 (PDT)
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
To:     Benjamin Berg <bberg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <5da27a3e.1c69fb81.d3083.7f73SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1eab3630-30d7-ff8f-8da6-aa9fc5c17f34@redhat.com>
Date:   Sun, 13 Oct 2019 09:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5da27a3e.1c69fb81.d3083.7f73SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Benjamin,

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

This seems like the exact same patch as you send before, is there
any reason for this resend ?

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
