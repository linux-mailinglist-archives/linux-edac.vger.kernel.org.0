Return-Path: <linux-edac+bounces-4827-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF37B83397
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 08:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59FF4844BA
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C32DA757;
	Thu, 18 Sep 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ON/u/9yy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655F1A5BB4
	for <linux-edac@vger.kernel.org>; Thu, 18 Sep 2025 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178560; cv=none; b=BIXC7up3x9WslpWwBlhHRQnzhpV2Z6TYSLl6orEfhNAFNhT0WCvRznMPGUyGwp2sFm0AGQ0SJb2/X4krbW3xllOKo/0jUhXm4jkheiDjd5WbpEpe1cmsjl1hHcqfwtFua8GJ8R96X6VroXFvpxrlo0XkBYpGjlKjPRVfqdSHDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178560; c=relaxed/simple;
	bh=ELfpsgc+RpQB3S36UjQO015tAKdWYBWIk9UnBTNjciA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eoq/pedcey0mcBWe5HbYnnXlCMaTwXGiuFZpp4qi/idqXQgxNblSOhWH0L1sC3Tj6JbWKUIiMzO1vzwrDQL+Bl51zhQhEEwlX1MeP4USS7x51sYC7yoQIwZpymeEhQlA6ARfXIwgNJgftkvt7zOaA7cwaVpL2klj/RMNcSozU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ON/u/9yy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ec4d6ba12eso277849f8f.1
        for <linux-edac@vger.kernel.org>; Wed, 17 Sep 2025 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758178556; x=1758783356; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMl5/TdXffzcTbDdrtFGzlD4L4XHEZgeTd0uNfSEJUQ=;
        b=ON/u/9yyH2B/sXVJLzKKWhR4b2WeSkKB2rzIUZaDHrEDAWCMbsw/4IqhMoRtx/pO3v
         4qAMUfoNXSYTipS2mt0esgd+0X/t3pW9CNOqbgOuQL8CZEDdzXMezwm9P2sG+TKZ2Y+N
         WUKrn2mXdzG1MRbCGqX+Cm/NMPryHi12J1mtfS3dkMDZSioQq2VwvijIjXkdAJMPMCL1
         EzAoUE5C4IYsl6ibG14kHCRrRIOXXsl34gEGd0uV78R+Eq8kC6Xq4fqILa+7LYiEr7hr
         D2fArFJMoVhiLPa2FaXQ48IJ2CnBZ1FLfKxgSgdtZuyYWQEWfNHmBXJFq1Av7D5AsmOZ
         2yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178556; x=1758783356;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMl5/TdXffzcTbDdrtFGzlD4L4XHEZgeTd0uNfSEJUQ=;
        b=FFu8NHVkX80ZCe8KrEfEyLyzhfm559IUnrBeZb0F6dWKwHcbRCjvCj1E3ZHZ4UfKHc
         i8k4SQJYW4lM3qVlKvRc7gn4ltfBZa7eCNzJMG23j8Sqr0i5bbYwK4aGgcF1jTQfxWS/
         Yu8loE0P4WOGuNRnSIfGu5IH3QimyL0KAU52Hn5h1apzwgO/k0RY4nrG/ac1Yyvigp5+
         d/GNi4MlHjsqquRXkhwXNeQH3rtUbCyIGz3rbAZwKJIRdJcQfY99Jlq81CRJBS4gIVgG
         dcI4yfj2125VetEmXSVT0xVDmNsb9N9agfLhhfCki2atAMC1DomgfqwnJgY0ur53HKA7
         XSkw==
X-Gm-Message-State: AOJu0Yz18u+tfV/b+vvywYKazxeRxJJ45thRpKG+YZ2ueSy21Cx+oOfD
	7YXZId89CJYAx2vE01EP+5MSQDtActmxumnPXCwKqu40H62VbrDjhj6FhmEsKFtkSgcee6lOU7s
	UAaGq
X-Gm-Gg: ASbGncs5ofVfDiefWlPmvsLy7fQaf+xR0ZwGPxsJ5kLo2T5Ml9RH8rracFg0BN8joQh
	NpU15paY9TR/VCH2hZc2FnaPl5rLbPb/eu8XafvR/c11kvkHezh426Zq+Lt+ah3mp2U/I+QHDeZ
	vcOJJI9s1H40Ug93wDz9EnnMpeqhee0zR2GDGOukRf3d2EYYpyeet/hEgbNtiQPIt3A7Ec5SAM4
	g/jSWPR0g0S7c63+r8WXOmCI2hhmuT72CxwQSNuc1Ulxg/41kGzEbNJ1hvKWsopaqXvBYuOtHcv
	8UVRWpqG7TXBNk3+HeCobmaTSSwTENY7S0ajUISoHkMl7HGPnsOFAUadH1rAnlzXZxWcqqtnZEQ
	fEu27zNLsTCEUStnc3Zs5ZKf6j/AOId2VtcdtOM7YUKae0A==
X-Google-Smtp-Source: AGHT+IEYa0Vf0pp1bOmg+hCDz/P6t0/xstWTcnbM84+O4suT9/JWb3DgDnnWC1AoB2CaC01nbLd97w==
X-Received: by 2002:a05:6000:18a9:b0:3e7:65a6:dc7 with SMTP id ffacd0b85a97d-3ecdf9b8389mr3069622f8f.8.1758178556370;
        Wed, 17 Sep 2025 23:55:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbf286dsm2213453f8f.56.2025.09.17.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:55:55 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:55:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org
Subject: [bug report] EDAC: Add a driver for the AMD Versal NET DDR controller
Message-ID: <aMus-KpPMcCk2iJr@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shubhrajyoti Datta,

Commit d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR
controller") from Sep 8, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/edac/versalnet_edac.c:849 init_versalnet()
	warn: '_res' from device_register() not released on lines: 849.

drivers/edac/versalnet_edac.c
    761 static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
    762 {
    763         u32 num_chans, rank, dwidth, config;
    764         struct edac_mc_layer layers[2];
    765         struct mem_ctl_info *mci;
    766         struct device *dev;
    767         enum dev_type dt;
    768         char *name;
    769         int rc, i;
    770 
    771         for (i = 0; i < NUM_CONTROLLERS; i++) {
    772                 config = priv->adec[CONF + i * ADEC_NUM];
    773                 num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
    774                 rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
    775                 dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
    776 
    777                 switch (dwidth) {
    778                 case XDDR5_BUS_WIDTH_16:
    779                         dt = DEV_X16;
    780                         break;
    781                 case XDDR5_BUS_WIDTH_32:
    782                         dt = DEV_X32;
    783                         break;
    784                 case XDDR5_BUS_WIDTH_64:
    785                         dt = DEV_X64;
    786                         break;
    787                 default:
    788                         dt = DEV_UNKNOWN;
    789                 }
    790 
    791                 if (dt == DEV_UNKNOWN)
    792                         continue;
    793 
    794                 /* Find the first enabled device and register that one. */
    795                 layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
    796                 layers[0].size = rank;
    797                 layers[0].is_virt_csrow = true;
    798                 layers[1].type = EDAC_MC_LAYER_CHANNEL;
    799                 layers[1].size = num_chans;
    800                 layers[1].is_virt_csrow = false;
    801 
    802                 rc = -ENOMEM;
    803                 mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
    804                                     sizeof(struct mc_priv));
    805                 if (!mci) {
    806                         edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
    807                         goto err_alloc;
    808                 }
    809 
    810                 priv->mci[i] = mci;
    811                 priv->dwidth = dt;
    812 
    813                 dev = kzalloc(sizeof(*dev), GFP_KERNEL);
    814                 dev->release = versal_edac_release;
    815                 name = kmalloc(32, GFP_KERNEL);
    816                 sprintf(name, "versal-net-ddrmc5-edac-%d", i);
    817                 dev->init_name = name;
    818                 rc = device_register(dev);
    819                 if (rc)
    820                         goto err_alloc;

This should do a edac_mc_free(mci) before the goto.

    821 
    822                 mci->pdev = dev;
    823 
    824                 platform_set_drvdata(pdev, priv);
    825 
    826                 mc_init(mci, dev);
    827                 rc = edac_mc_add_mc(mci);
    828                 if (rc) {
    829                         edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
    830                         goto err_alloc;

I guess this should unregister and edac_mc_free mci before the goto.

    831                 }
    832         }
    833         return 0;
    834 
    835 err_alloc:
    836         while (i--) {
    837                 mci = priv->mci[i];
    838                 if (!mci)

No need for this check.  We know it's non-NULL.

    839                         continue;
    840 
    841                 if (mci->pdev) {

Unnecessary NULL check.

    842                         device_unregister(mci->pdev);
    843                         edac_mc_del_mc(mci->pdev);

I would have thought these would be in the other order but I don't know
if it matters.  I have a paragraph on unwinding from loops at the end of
my blog:

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

    844                 }
    845 
    846                 edac_mc_free(mci);
    847         }
    848 
--> 849         return rc;
    850 }

regards,
dan carpenter

