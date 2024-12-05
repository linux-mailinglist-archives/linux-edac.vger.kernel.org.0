Return-Path: <linux-edac+bounces-2645-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A59E557F
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 13:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179FF282ACF
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61658219A87;
	Thu,  5 Dec 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="Fo5PxjnQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE34218EBA
	for <linux-edac@vger.kernel.org>; Thu,  5 Dec 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401700; cv=none; b=b93sjohj3h0qC2kzqZtTjWqRGuPC8cM/35eaE6JnnWVAZy/hxaF6ODVnIsQw/aWxAdRUQmtb8q/OVrb3ctC3ZKLOWqxj2f/HwrZr/FQ7kGCepVWNkS5v3fLRhUo2GbhTaxlaOr7ullIB8AApQVguCMcYlYnR7WhXN1aufnEXFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401700; c=relaxed/simple;
	bh=JnWAs62KFU3usRLUd7hPRMQAMO+SPPu6KpB1amv2JnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBI2vWSEQoN/bc6zu4Tbys8+duSpM/kAv5JhJMY2CAoHMMqSHJpARkuTy9MSX8Rgcby7eNmuq9SBdhN9EHPqRdOFqQciMlteABe0bD71ubM6aWM1PocR2flBHBVUySBV5bRKLH/L4XZEWcsNAKR3cejAaa0wtl/uegxFEovE2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=Fo5PxjnQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so725633a91.1
        for <linux-edac@vger.kernel.org>; Thu, 05 Dec 2024 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733401696; x=1734006496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJ6zOt8jFxRe4ecCDXzzF1gBv8xwcEddUM9cvRD+Wys=;
        b=Fo5PxjnQ2UlfHB5ZwXaxm26QxsoMg/qbZrYK9faPA5CWqW3wcjYmvJm8BuRr3tatXV
         l+qKwS4+QqyQG2prxXzvxh5XMF8dwVOuPr0BIh8claj8VTqIxUl2CUSpZUiEEdu4gVpt
         X4rtdQt6lxh2lZPv5vfGERivSca8m/jy7WpTnGJFpmoqxH14RxM7zASpMFE4EfTL06AU
         Vd+y2CF6lMSoR6ttpupM2MpKxt93gL8ojMwR23Pz057PpsIkI8Ed+LVg0oxDohWDxa9y
         m27/8BeTjjKS2NEmwgjyTUMUXZowUHlnPjNNrbCMoFV+eyuq/FdZMtNJHA0NAHXLb8kT
         ARxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401696; x=1734006496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ6zOt8jFxRe4ecCDXzzF1gBv8xwcEddUM9cvRD+Wys=;
        b=l20MBy4kTG5T5uNBUA90AaEbhqpwBKxQQme0yMa9Uxeavvt0bhqFJgVxE+h9qbpb82
         MjrzAKoR5NQvr1F6oBtYkYau8He3ouWdAHR8wzVbbTO4PZ/xvfaCnZHtUVMImeyTetWH
         iO6qJb/rpiUkywK7IWvoIU6HFlRjVS51EjmT143c7BKDTmZpOFofsXoFJYtc/nxOOwXJ
         8vRyshQlZPZiLorkxt5QrJo0l2mZUu+lWOhJJXVVD/3T0m8jBLsFG74E5eJ4BDf4K5Za
         tQGBc3Gj25UkqtgvBFwi/sqti7ufmSXGdHMSvEFYMkysNTQR0Q7wisQ4/5rN+vAJSxej
         IYGQ==
X-Gm-Message-State: AOJu0YzqXI7Of66/tk8dnw8MJP+yf0ac4lbSeAnBx67Jt4e60VVRrD61
	obdASESKXiExaesdtrspQqUaJoK1Wb+S6hY3at2nxE6cxFwH1rJdrDCClNWmf8k=
X-Gm-Gg: ASbGncse1gLHnDAQrtGmkMiKfWTPUj1Qyfh1g9bQYP5VpluK1BJt3lUTCIuCw+trbNi
	PIQlaWJJBtbqr9eWSR32ZhqcoibsIEvCkyPHJAz/mQb10t7h7xUfynK32ZHsPlSo5uwevwxnTZv
	u5J8IAg1Tum53UP88qWsC4zN6wVarskPETOP8gqNLaP4jLvOnvmBlwE9C7m5FW6H0V2R3vpYbOd
	R40UtjWf8Z+NFyaATQNypD9HwEfelU+N/AJ+QpgD0nVuqPtEMhjJr81axDuf1rnPToCx1A3xlI3
	eyGD4L2hBqQEX/2KqObdx7RtSjM=
X-Google-Smtp-Source: AGHT+IExpRwVSF+yqX4igWDp2mLfe53H4VbB5IOAGsXo+GnRkkSKEa6C02781yHNUjeHFEc/wfXDZw==
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ef2f498ccamr5905058a91.18.1733401696399;
        Thu, 05 Dec 2024 04:28:16 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45edf1c4sm1283286a91.0.2024.12.05.04.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 04:28:15 -0800 (PST)
Message-ID: <0e278e8a-eb50-4817-b0ec-7455e217def3@pf.is.s.u-tokyo.ac.jp>
Date: Thu, 5 Dec 2024 21:28:12 +0900
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] edac: al_mc: free mem_ctl_info on error path in .probe()
To: "Shenhar, Talel" <talel@amazon.com>, "bp@alien8.de" <bp@alien8.de>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
 <rric@kernel.org>, "Kudrjavets, Gunnar" <gunnarku@amazon.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <bdce9341621b4b089a9d04614f06bb1e@amazon.com>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <bdce9341621b4b089a9d04614f06bb1e@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Talel,

On 12/5/24 20:47, Shenhar, Talel wrote:
> Thanks, Joe, for reaching out.
> 
> I noticed that your patch explicitly calls edac_mc_free() in the error path, but it seems this is already handled by the devm framework.
> Specifically, in devm_add_action_or_reset():
> static void devm_al_mc_edac_free(void *data)
> {
>      edac_mc_free(data);
> }
Yes, you are absolutely right, I overlooked that the devm framework 
already handles the cleanup process.
Please disregard my patch.
> 
> This ensures that edac_mc_free() is called automatically if an error occurs during initialization or the device is removed.
> Could you clarify the memory leak scenario you're addressing? Are there specific cases where the devm handling might not be triggered, leading to the observed leak?
> If such a scenario exists, understanding the exact path where devm_al_mc_edac_free() is bypassed would help evaluate whether the explicit call is necessary.
> Without such a case, the patch might introduce redundant cleanup logic.
> 
> Looking forward to your insights!
> 
> Best regards,
> Talel
> 
> 
> -----Original Message-----
> From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Sent: Thursday, December 5, 2024 12:58 PM
> To: Shenhar, Talel <talel@amazon.com>; bp@alien8.de; tony.luck@intel.com; james.morse@arm.com; mchehab@kernel.org; rric@kernel.org
> Cc: linux-edac@vger.kernel.org; Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Subject: [EXTERNAL] [PATCH] edac: al_mc: free mem_ctl_info on error path in .probe()
> 
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> In al_mc_edac_probe(), the mem_ctl_info allocated by edac_mc_alloc() is not freed in the error path, resulting in a memory leak. Add a
> edac_mc_free() call to fix this.
> 
> Fixes: e23a7cdeb3da ("EDAC/al-mc-edac: Add Amazon's Annapurna Labs Memory Controller driver")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>   drivers/edac/al_mc_edac.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c index 178b9e581a72..3908e999f4ff 100644
> --- a/drivers/edac/al_mc_edac.c
> +++ b/drivers/edac/al_mc_edac.c
> @@ -240,7 +240,7 @@ static int al_mc_edac_probe(struct platform_device *pdev)
> 
>          ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_free, mci);
>          if (ret)
> -               return ret;
> +               goto free;
> 
>          platform_set_drvdata(pdev, mci);
>          al_mc = mci->pvt_info;
> @@ -288,12 +288,12 @@ static int al_mc_edac_probe(struct platform_device *pdev)
>                  dev_err(&pdev->dev,
>                          "fail to add memory controller device (%d)\n",
>                          ret);
> -               return ret;
> +               goto free;
>          }
> 
>          ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
>          if (ret)
> -               return ret;
> +               goto free;
> 
>          if (al_mc->irq_ue > 0) {
>                  ret = devm_request_irq(&pdev->dev, @@ -306,7 +306,7 @@ static int al_mc_edac_probe(struct platform_device *pdev)
>                          dev_err(&pdev->dev,
>                                  "failed to request UE IRQ %d (%d)\n",
>                                  al_mc->irq_ue, ret);
> -                       return ret;
> +                       goto free;
>                  }
>          }
> 
> @@ -321,11 +321,15 @@ static int al_mc_edac_probe(struct platform_device *pdev)
>                          dev_err(&pdev->dev,
>                                  "failed to request CE IRQ %d (%d)\n",
>                                  al_mc->irq_ce, ret);
> -                       return ret;
> +                       goto free;
>                  }
>          }
> 
>          return 0;
> +
> +free:
> +       edac_mc_free(mci);
> +       return ret;
>   }
> 
>   static const struct of_device_id al_mc_edac_of_match[] = {
> --
> 2.34.1
> 

Best,
Joe

